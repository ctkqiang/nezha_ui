import 'package:flutter/material.dart';
import 'package:nezha_ui/theme/colors.dart';

export 'theme/colors.dart';
export 'theme/theme.dart';
export 'components/button.dart';
export 'components/divider.dart';
export 'nezha_ui.dart';

class NezhaApp extends StatefulWidget {
  final String title;
  final Widget? main;
  final bool? showPerformanceOverlay;
  final ThemeData? darkTheme;
  final ThemeData? theme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final ThemeMode? themeMode;
  final Map<String, WidgetBuilder>? routes;
  final GlobalKey<NavigatorState>? navigatorKey;
  final List<NavigatorObserver> navigatorObservers;

  const NezhaApp({
    super.key,
    required this.title,
    this.main,
    this.routes,
    this.showPerformanceOverlay,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.navigatorKey,
    this.navigatorObservers = const <NavigatorObserver>[],
  });

  @override
  State<NezhaApp> createState() => _NezhaAppState();
}

class _NezhaAppState extends State<NezhaApp> {
  late HeroController _heroController;
  late NavigatorObserver _navigatorObserver;

  @override
  void initState() {
    super.initState();
    _heroController = HeroController();
    _navigatorObserver = widget.navigatorObservers.isNotEmpty
        ? widget.navigatorObservers.first
        : NavigatorObserver();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData? theme = widget.theme ?? ThemeData.fallback();
    final ThemeData? darkTheme = widget.darkTheme ?? theme;
    final ThemeData highContrastTheme = widget.highContrastTheme ?? theme!;
    final ThemeData highContrastDarkTheme =
        widget.highContrastDarkTheme ?? darkTheme!;

    final ThemeMode mode = widget.themeMode!;
    final bool useDarkTheme =
        mode == ThemeMode.dark ||
        (mode == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);

    final ThemeData effectiveTheme = useDarkTheme ? darkTheme! : theme!;

    Widget result = WidgetsApp.router(
      key: GlobalObjectKey(this),
      color: NZColor.nezhaPrimary,
      showPerformanceOverlay: widget.showPerformanceOverlay ?? false,
    );

    result = HeroControllerScope(controller: _heroController, child: result);

    return result;
  }
}
