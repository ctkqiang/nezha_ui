import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:trading_view_flutter/trading_view_flutter.dart';
import 'package:trading_view_flutter/src/web_initializer.dart';

/// NZTradingView 是 NezhaUI 提供的 TradingView 图表包装组件。
///
/// 它封装了 [TradingViewWidget]，并提供了更符合 NezhaUI 规范的配置项。
class NZTradingView extends StatefulWidget {
  final int? id;

  /// 交易对，例如 "BINANCE:BTCUSDT"
  final String symbol;

  /// 图表周期，例如 "1D", "1H", "15"
  final String interval;

  /// 主题颜色，默认为当前系统主题
  final String? theme;

  /// 图表样式，例如 "1" (蜡烛图), "2" (线图)
  final String? style;

  /// 是否启用工具栏
  final bool enableToolbar;

  /// 容器宽度
  final double? width;

  /// 容器高度
  final double? height;

  /// 是否为轻量级图表视图
  final bool isLightWeightChart;

  /// 图表数据 (仅用于轻量级图表)
  final List<TradingViewChartData>? chartValue;

  /// 指标数据 (仅用于轻量级图表)
  final List<ChartIndicator>? indicators;

  /// 成交量数据 (仅用于轻量级图表)
  final List<ChartVolume>? volume;

  /// 指标图片 (仅用于轻量级图表)
  final List<ChartIndicatorImage>? indicatorImages;

  /// 时区，例如 "Asia/Shanghai"
  final String? timezone;

  /// 图表类型
  final TradingViewChartType? tradingViewChartType;

  const NZTradingView({
    super.key,
    this.id,
    required this.symbol,
    this.interval = '1D',
    this.theme,
    this.style,
    this.enableToolbar = true,
    this.width,
    this.height,
    this.isLightWeightChart = false,
    this.chartValue,
    this.indicators,
    this.volume,
    this.indicatorImages,
    this.timezone,
    this.tradingViewChartType,
  });

  /// 创建轻量级图表视图
  const NZTradingView.light({
    super.key,
    this.id,
    required this.symbol,
    this.interval = '1D',
    this.theme,
    this.style = '1',
    this.enableToolbar = false,
    this.width,
    this.height,
    this.chartValue,
    this.indicators,
    this.volume,
    this.indicatorImages,
    this.timezone,
    this.tradingViewChartType,
  }) : isLightWeightChart = true;

  @override
  State<NZTradingView> createState() => _NZTradingViewState();
}

class _NZTradingViewState extends State<NZTradingView> {
  bool _isReady = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initChart();
  }

  Future<void> _initChart() async {
    if (kIsWeb) {
      try {
        // 1. 确保 Web 平台已初始化 (即使 main.dart 已经调过，这里再调一次也无妨)
        WebInitializer.initialize();

        // 2. 构造初始数据用于预加载
        final data = _buildTradingViewData();

        // 3. 在 Web 端手动触发单例的 onLoad，并捕获可能的 UnimplementedError
        // 这是为了解决 trading_view_flutter 在 Web 端初始化时的竞争问题
        await TradingViewEmbedder.instance.onLoad(tradingViewData: data);
      } catch (e) {
        debugPrint('NZTradingView Web Init Error: $e');
        // 如果是 UnimplementedError，通常是因为 setJavaScriptMode，
        // 在 Web 端这不影响使用，所以我们继续。
        if (!e.toString().contains('UnimplementedError')) {
          _error = e.toString();
        }
      } finally {
        if (mounted) {
          setState(() {
            _isReady = true;
          });
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _isReady = true;
        });
      }
    }
  }

  TradingViewData _buildTradingViewData() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // 处理主题映射
    TradingViewTheme tvTheme;
    if (widget.theme != null) {
      tvTheme = widget.theme!.toLowerCase() == 'dark'
          ? TradingViewTheme.dark
          : TradingViewTheme.light;
    } else {
      tvTheme = isDark ? TradingViewTheme.dark : TradingViewTheme.light;
    }

    return TradingViewData(
      id: widget.id ?? widget.symbol.hashCode.abs(),
      symbol: widget.symbol,
      interval: widget.interval,
      theme: tvTheme,
      style: widget.style ?? '1',
      locale: 'zh',
      hideTopToolbar: !widget.enableToolbar,
      isLightWeightChart: widget.isLightWeightChart,
      chartValue: widget.chartValue,
      indicators: widget.indicators,
      volume: widget.volume,
      indicatorImages: widget.indicatorImages,
      timezone: widget.timezone,
      tradingViewChartType: widget.tradingViewChartType,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height ?? 400,
        child: const Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    if (_error != null) {
      return SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height ?? 400,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Text('图表初始化失败: $_error'),
            ],
          ),
        ),
      );
    }

    final data = _buildTradingViewData();

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 400,
      child: widget.isLightWeightChart
          ? TradingViewLightChart(
              key: ValueKey('tv_light_${widget.symbol}_${widget.id}'),
              data: data,
            )
          : TradingViewWidget(
              key: ValueKey('tv_${widget.symbol}_${widget.id}'),
              data: data,
            ),
    );
  }
}
