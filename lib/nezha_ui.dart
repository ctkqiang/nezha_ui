import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nezha_ui/theme/colors.dart';

/// NezhaApp 是基于 Material 设计语言的定制化应用入口组件。
///
/// 它集成了 NezhaUI 的主题系统，并提供了类似 [MaterialApp] 的完整功能，
/// 包括路由管理、主题切换、国际化支持等。
class NezhaApp extends StatefulWidget {
  const NezhaApp({
    super.key,
    this.navigatorKey,
    this.scaffoldMessengerKey,
    this.home,
    Map<String, WidgetBuilder> this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
  });

  const NezhaApp.router({
    super.key,
    this.scaffoldMessengerKey,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
  }) : navigatorKey = null,
       home = null,
       routes = null,
       initialRoute = null,
       onGenerateRoute = null,
       onGenerateInitialRoutes = null,
       onUnknownRoute = null,
       navigatorObservers = const <NavigatorObserver>[];

  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final Color? color;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final ThemeMode themeMode;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final bool debugShowMaterialGrid;

  // Router 相关
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;

  @override
  State<NezhaApp> createState() => _NezhaAppState();
}

class _NezhaAppState extends State<NezhaApp> {
  late HeroController _heroController;

  @override
  void initState() {
    super.initState();
    _heroController = HeroController();
  }

  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates {
    return <LocalizationsDelegate<dynamic>>[
      if (widget.localizationsDelegates != null)
        ...widget.localizationsDelegates!
      else ...const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    // 创建基础主题
    final ThemeData theme = widget.theme ?? ThemeData.fallback();
    final ThemeData darkTheme = widget.darkTheme ?? theme;

    // 确定当前应该应用的主题模式
    final ThemeMode mode = widget.themeMode;
    final bool useDarkTheme =
        mode == ThemeMode.dark ||
        (mode == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);

    final ThemeData effectiveTheme = useDarkTheme ? darkTheme : theme;

    // 内部构建方法，用于应用 Material 特有的层级
    Widget buildApp(BuildContext context, Widget? child) {
      return Material(
        color: effectiveTheme.scaffoldBackgroundColor,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: MediaQuery.of(context),
            child: Theme(
              data: effectiveTheme,
              child: CupertinoTheme(
                data: MaterialBasedCupertinoThemeData(
                  materialTheme: effectiveTheme,
                ),
                child: widget.builder != null
                    ? widget.builder!(context, child)
                    : child!,
              ),
            ),
          ),
        ),
      );
    }

    Widget result;
    if (widget.routerDelegate != null) {
      result = WidgetsApp.router(
        key: GlobalObjectKey(this),
        routeInformationProvider: widget.routeInformationProvider,
        routeInformationParser: widget.routeInformationParser,
        routerDelegate: widget.routerDelegate,
        backButtonDispatcher: widget.backButtonDispatcher,
        builder: buildApp,
        title: widget.title,
        onGenerateTitle: widget.onGenerateTitle,
        color: widget.color ?? NZColor.nezhaPrimary,
        locale: widget.locale,
        localizationsDelegates: _localizationsDelegates,
        localeListResolutionCallback: widget.localeListResolutionCallback,
        localeResolutionCallback: widget.localeResolutionCallback,
        supportedLocales: widget.supportedLocales,
        showPerformanceOverlay: widget.showPerformanceOverlay,
        showSemanticsDebugger: widget.showSemanticsDebugger,
        debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
        shortcuts: widget.shortcuts,
        actions: widget.actions,
        restorationScopeId: widget.restorationScopeId,
      );
    } else {
      result = WidgetsApp(
        key: GlobalObjectKey(this),
        navigatorKey: widget.navigatorKey,
        navigatorObservers: widget.navigatorObservers,
        pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
          return MaterialPageRoute<T>(settings: settings, builder: builder);
        },
        home: widget.home,
        routes: widget.routes ?? const <String, WidgetBuilder>{},
        initialRoute: widget.initialRoute,
        onGenerateRoute: widget.onGenerateRoute,
        onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
        onUnknownRoute: widget.onUnknownRoute,
        builder: buildApp,
        title: widget.title,
        onGenerateTitle: widget.onGenerateTitle,
        color: widget.color ?? NZColor.nezhaPrimary,
        locale: widget.locale,
        localizationsDelegates: _localizationsDelegates,
        localeListResolutionCallback: widget.localeListResolutionCallback,
        localeResolutionCallback: widget.localeResolutionCallback,
        supportedLocales: widget.supportedLocales,
        showPerformanceOverlay: widget.showPerformanceOverlay,
        showSemanticsDebugger: widget.showSemanticsDebugger,
        debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
        shortcuts: widget.shortcuts,
        actions: widget.actions,
        restorationScopeId: widget.restorationScopeId,
      );
    }

    return HeroControllerScope(controller: _heroController, child: result);
  }
}
