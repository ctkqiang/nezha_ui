import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

/// K线盘面技术指标枚举
enum KLineIndicator {
  // --- 趋势型指标 (Trend) ---
  ma('MA', '移动平均线', '识别长短期价格趋势'),
  ema('EMA', '指数移动平均线', '更快速地反映近期价格变化'),
  macd('MACD', '指数平滑异同移动平均线', '寻找趋势转折与进出场点位'),
  sar('SAR', '抛物线指标', '自动追踪趋势的止盈止损点'),

  // --- 动量/震荡指标 (Momentum) ---
  rsi('RSI', '相对强弱指数', '通过 30/70 区间判断超买或超卖'),
  kdj('KDJ', '随机指标', '震荡行情中寻找价格拐点'),
  bias('BIAS', '乖离率', '判断价格向均线回归的可能性'),
  dmi('DMI', '趋向指标', '区分震荡市与单边市，判断趋势强弱'),

  // --- 波动率与成交量 (Volatility & Volume) ---
  boll('BOLL', '布林带', '利用标准差确定价格波动范围'),
  vol('VOL', '成交量', '验证价格变动的真实能量'),
  atr('ATR', '真实波幅均值', '衡量波动率，常用于计算动态止损'),
  obv('OBV', '能量潮', '观察主力资金的流入流出情况'),
  vwap('VWAP', '成交量加权平均价', '日内交易的真实基准价格'),

  // --- 支撑与阻力 (Support/Resistance) ---
  fib('FIB', '斐波那契回撤', '寻找 0.618 等心理预期支撑位');

  const KLineIndicator(this.code, this.zhName, this.description);
  final String code;
  final String zhName;
  final String description;

  @override
  String toString() => '$code ($zhName)';
}

/// K线数据模型
class KLineData {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  const KLineData({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });
}

/// K 线蜡烛图样式
enum KLineStyle { solid, hollow, line, ohlc }

/// NZKPan 是 NezhaUI 提供的专业金融 K 线图表组件。
class NZKPan extends StatefulWidget {
  final List<KLineData> data;
  final String symbol;
  final bool isChinaStyle;
  final KLineStyle style;
  final Set<KLineIndicator> indicators;
  final double height;
  final Color? gridColor;
  final ValueChanged<KLineData?>? onCrosshairChanged;

  const NZKPan({
    super.key,
    required this.data,
    this.symbol = 'BTC/USDT',
    this.isChinaStyle = true,
    this.style = KLineStyle.solid,
    this.indicators = const {KLineIndicator.ma, KLineIndicator.vol},
    this.height = 400,
    this.gridColor,
    this.onCrosshairChanged,
  });

  @override
  State<NZKPan> createState() => _NZKPanState();
}

class _NZKPanState extends State<NZKPan> {
  Offset? _tapPosition;
  KLineData? _selectedData;
  double _scale = 1.0;
  double _lastScale = 1.0;
  double _scrollOffset = 0.0;
  double _lastScrollOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color upColor = widget.isChinaStyle
        ? NZColor.red500
        : NZColor.green500;
    final Color downColor = widget.isChinaStyle
        ? NZColor.green500
        : NZColor.red500;
    final Color bgColor = isDark ? const Color(0xFF131722) : Colors.white;
    final Color axisColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final Color textColor = isDark ? Colors.grey[400]! : Colors.grey[600]!;

    return Container(
      height: widget.height,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: axisColor, width: 0.5),
      ),
      child: Column(
        children: [
          _buildIndicatorHeader(textColor, upColor, downColor),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GestureDetector(
                  onScaleStart: (details) {
                    _lastScale = _scale;
                    _lastScrollOffset = _scrollOffset;
                  },
                  onScaleUpdate: (details) {
                    setState(() {
                      // Handle Zoom
                      if (details.scale != 1.0) {
                        _scale = (_lastScale * details.scale).clamp(0.5, 5.0);
                      }

                      // Handle Scroll
                      _scrollOffset =
                          _lastScrollOffset + details.focalPointDelta.dx;

                      // Keep crosshair updated if active
                      if (_tapPosition != null) {
                        _tapPosition = details.localFocalPoint;
                      }
                    });
                  },
                  onLongPressStart: (details) =>
                      _updateCrosshair(details.localPosition),
                  onLongPressMoveUpdate: (details) =>
                      _updateCrosshair(details.localPosition),
                  onLongPressEnd: (_) => _updateCrosshair(null),
                  onTapDown: (details) =>
                      _updateCrosshair(details.localPosition),
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: KLinePainter(
                      data: widget.data,
                      style: widget.style,
                      upColor: upColor,
                      downColor: downColor,
                      axisColor: axisColor,
                      textColor: textColor,
                      indicators: widget.indicators,
                      tapPosition: _tapPosition,
                      scale: _scale,
                      scrollOffset: _scrollOffset,
                      isDark: isDark,
                      onDataSelected: (data) {
                        if (_selectedData != data) {
                          Future.microtask(() {
                            if (mounted) setState(() => _selectedData = data);
                            widget.onCrosshairChanged?.call(data);
                          });
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _updateCrosshair(Offset? position) {
    setState(() => _tapPosition = position);
  }

  Widget _buildIndicatorHeader(
    Color textColor,
    Color upColor,
    Color downColor,
  ) {
    final last = widget.data.last;
    final prev = widget.data.length > 1
        ? widget.data[widget.data.length - 2]
        : last;
    final change = last.close - prev.close;
    final changePercent = (change / prev.close) * 100;
    final color = change >= 0 ? upColor : downColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: textColor.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.symbol,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                'MA(5,10,20)',
                style: TextStyle(
                  fontSize: 9,
                  color: textColor.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          ...widget.indicators
              .take(2)
              .map(
                (ind) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    ind.code,
                    style: TextStyle(fontSize: 10, color: textColor),
                  ),
                ),
              ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                last.close.toStringAsFixed(2),
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1,
                ),
              ),
              Text(
                '${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)} (${changePercent.toStringAsFixed(2)}%)',
                style: TextStyle(color: color, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class KLinePainter extends CustomPainter {
  final List<KLineData> data;
  final KLineStyle style;
  final Color upColor;
  final Color downColor;
  final Color axisColor;
  final Color textColor;
  final Set<KLineIndicator> indicators;
  final Offset? tapPosition;
  final double scale;
  final double scrollOffset;
  final bool isDark;
  final Function(KLineData?) onDataSelected;

  KLinePainter({
    required this.data,
    required this.style,
    required this.upColor,
    required this.downColor,
    required this.axisColor,
    required this.textColor,
    required this.indicators,
    required this.scale,
    required this.scrollOffset,
    required this.isDark,
    this.tapPosition,
    required this.onDataSelected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final double baseCandleWidth = 10.0;
    final double candleWidth = baseCandleWidth * scale;
    final double candlePadding = candleWidth * 0.2;

    // Calculate how many candles can fit in the viewport
    final int visibleCount = (size.width / candleWidth).ceil() + 1;

    // Calculate the start index based on scrollOffset
    // Default scrollOffset is 0, which means the rightmost candle is at the right edge
    final double totalWidth = data.length * candleWidth;
    final double maxScroll = max(0.0, totalWidth - size.width);

    // Clamp scrollOffset to stay within data bounds
    final double effectiveScroll = scrollOffset.clamp(-maxScroll, 0.0);

    // Start drawing from...
    final int startIndex = ((-effectiveScroll) / candleWidth).floor().clamp(
      0,
      data.length,
    );
    final int endIndex = (startIndex + visibleCount).clamp(0, data.length);

    final List<KLineData> visibleData = data.sublist(startIndex, endIndex);
    if (visibleData.isEmpty) return;

    final double chartHeight = size.height * 0.7;
    final double volumeHeight = size.height * 0.2;

    // Calculate Min/Max for Scaling (only for visible data)
    double minPrice = visibleData.map((e) => e.low).reduce(min);
    double maxPrice = visibleData.map((e) => e.high).reduce(max);
    double maxVolume = visibleData.map((e) => e.volume).reduce(max);

    // Padding for Price Axis
    final double pricePadding = (maxPrice - minPrice) * 0.1;
    minPrice -= pricePadding;
    maxPrice += pricePadding;

    // Draw Grid & Axes
    _drawGrid(canvas, size, chartHeight, volumeHeight, minPrice, maxPrice);

    // Draw Candles & Volumes
    for (int i = startIndex; i < endIndex; i++) {
      final d = data[i];
      final isUp = d.close >= d.open;
      final color = isUp ? upColor : downColor;

      // Calculate X position relative to viewport
      final x = (i * candleWidth) + effectiveScroll + candleWidth / 2;

      if (x < -candleWidth || x > size.width + candleWidth) continue;

      // Candle Y positions
      final yOpen = _getY(d.open, minPrice, maxPrice, chartHeight);
      final yClose = _getY(d.close, minPrice, maxPrice, chartHeight);
      final yHigh = _getY(d.high, minPrice, maxPrice, chartHeight);
      final yLow = _getY(d.low, minPrice, maxPrice, chartHeight);

      // Volume Y positions
      final vY = size.height - (d.volume / maxVolume) * volumeHeight;

      // Draw Volume
      final vPaint = Paint()..color = color.withValues(alpha: 0.4);
      canvas.drawRect(
        Rect.fromLTRB(
          x - candleWidth / 2 + candlePadding,
          vY,
          x + candleWidth / 2 - candlePadding,
          size.height,
        ),
        vPaint,
      );

      // Draw Candle
      _drawCandle(
        canvas,
        x,
        candleWidth - candlePadding * 2,
        yOpen,
        yClose,
        yHigh,
        yLow,
        isUp,
        color,
      );
    }

    // Draw MA Lines (Only for visible range + padding for continuity)
    if (indicators.contains(KLineIndicator.ma)) {
      _drawMA(
        canvas,
        5,
        Colors.orange,
        minPrice,
        maxPrice,
        chartHeight,
        candleWidth,
        effectiveScroll,
      );
      _drawMA(
        canvas,
        10,
        Colors.blue,
        minPrice,
        maxPrice,
        chartHeight,
        candleWidth,
        effectiveScroll,
      );
    }

    // Draw EMA Lines
    if (indicators.contains(KLineIndicator.ema)) {
      _drawEMA(
        canvas,
        7,
        Colors.purple,
        minPrice,
        maxPrice,
        chartHeight,
        candleWidth,
        effectiveScroll,
      );
      _drawEMA(
        canvas,
        25,
        Colors.teal,
        minPrice,
        maxPrice,
        chartHeight,
        candleWidth,
        effectiveScroll,
      );
    }

    // Handle Crosshair
    if (tapPosition != null) {
      // Find the index based on tapPosition and scrollOffset
      final double relativeX = tapPosition!.dx - effectiveScroll;
      final int index = (relativeX / candleWidth).floor().clamp(
        0,
        data.length - 1,
      );
      final selected = data[index];

      final x = (index * candleWidth) + effectiveScroll + candleWidth / 2;

      final chPaint = Paint()
        ..color = textColor.withValues(alpha: 0.5)
        ..strokeWidth = 1;

      // Vertical line
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), chPaint);
      // Horizontal line
      canvas.drawLine(
        Offset(0, tapPosition!.dy),
        Offset(size.width, tapPosition!.dy),
        chPaint,
      );

      onDataSelected(selected);

      // Draw Info Tooltip
      _drawTooltip(canvas, size, selected, isDark);

      // Draw Price Label on crosshair
      final double priceAtY =
          maxPrice - (tapPosition!.dy / chartHeight) * (maxPrice - minPrice);
      if (tapPosition!.dy <= chartHeight) {
        _drawPriceTag(
          canvas,
          priceAtY.toStringAsFixed(2),
          Offset(size.width - 50, tapPosition!.dy - 10),
          isDark: true,
        );
      }
    } else {
      onDataSelected(null);
    }
  }

  void _drawTooltip(Canvas canvas, Size size, KLineData data, bool isDark) {
    final double padding = 8.0;
    final double rowHeight = 16.0;
    final double width = 120.0;
    final double height = rowHeight * 5 + padding * 2;

    // Determine tooltip position (avoid covering the crosshair)
    double x = tapPosition!.dx + 20;
    if (x + width > size.width) {
      x = tapPosition!.dx - width - 20;
    }
    double y = 20;

    final bgPaint = Paint()
      ..color = (isDark ? Colors.black87 : Colors.white.withValues(alpha: 0.9))
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = axisColor.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(x, y, width, height),
      const Radius.circular(4),
    );

    canvas.drawRRect(rect, bgPaint);
    canvas.drawRRect(rect, borderPaint);

    final textStyle = TextStyle(
      color: textColor,
      fontSize: 10,
      fontFamily: 'monospace',
    );

    void drawRow(String label, String value, int rowIdx, {Color? valueColor}) {
      final labelPainter = TextPainter(
        text: TextSpan(text: label, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      final valuePainter = TextPainter(
        text: TextSpan(
          text: value,
          style: textStyle.copyWith(
            color: valueColor ?? textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      labelPainter.paint(
        canvas,
        Offset(x + padding, y + padding + rowIdx * rowHeight),
      );
      valuePainter.paint(
        canvas,
        Offset(
          x + width - padding - valuePainter.width,
          y + padding + rowIdx * rowHeight,
        ),
      );
    }

    final isUp = data.close >= data.open;
    final color = isUp ? upColor : downColor;

    drawRow('Open', data.open.toStringAsFixed(2), 0);
    drawRow('High', data.high.toStringAsFixed(2), 1);
    drawRow('Low', data.low.toStringAsFixed(2), 2);
    drawRow('Close', data.close.toStringAsFixed(2), 3, valueColor: color);
    drawRow('Vol', data.volume.toInt().toString(), 4);
  }

  void _drawPriceTag(
    Canvas canvas,
    String text,
    Offset offset, {
    required bool isDark,
  }) {
    final paint = Paint()..color = isDark ? Colors.black87 : Colors.white70;
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          offset.dx - 4,
          offset.dy - 2,
          tp.width + 8,
          tp.height + 4,
        ),
        const Radius.circular(4),
      ),
      paint,
    );
    tp.paint(canvas, offset);
  }

  void _drawGrid(
    Canvas canvas,
    Size size,
    double chartH,
    double volH,
    double minP,
    double maxP,
  ) {
    final paint = Paint()
      ..color = axisColor.withValues(alpha: 0.1)
      ..strokeWidth = 0.5;

    // Horizontal Grid Lines (Price)
    for (int i = 0; i <= 4; i++) {
      final y = (chartH / 4) * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);

      final price = maxP - (maxP - minP) * (i / 4);
      _drawText(
        canvas,
        price.toStringAsFixed(2),
        Offset(size.width - 55, y - 12),
        isBold: i == 0 || i == 4,
      );
    }

    // Vertical Grid Lines (Time)
    final double baseCandleWidth = 10.0;
    final double candleWidth = baseCandleWidth * scale;
    final double totalWidth = data.length * candleWidth;
    final double maxScroll = max(0.0, totalWidth - size.width);
    final double effectiveScroll = scrollOffset.clamp(-maxScroll, 0.0);

    // 每隔 50 个数据点画一条垂直线和时间标签
    const int timeStep = 50;
    for (int i = 0; i < data.length; i += timeStep) {
      final x = (i * candleWidth) + effectiveScroll + candleWidth / 2;
      if (x < 0 || x > size.width) continue;

      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);

      final timeStr =
          "${data[i].time.hour.toString().padLeft(2, '0')}:${data[i].time.minute.toString().padLeft(2, '0')}";
      _drawText(canvas, timeStr, Offset(x - 15, size.height - 15));
    }
  }

  void _drawCandle(
    Canvas canvas,
    double x,
    double width,
    double yO,
    double yC,
    double yH,
    double yL,
    bool isUp,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = max(1.0, width * 0.05);

    // Wick
    canvas.drawLine(Offset(x, yH), Offset(x, yL), paint);

    // Body
    final top = min(yO, yC);
    final bottom = max(yO, yC);
    final rect = Rect.fromLTRB(x - width / 2, top, x + width / 2, bottom);

    if (style == KLineStyle.hollow && isUp) {
      paint.style = PaintingStyle.stroke;
      canvas.drawRect(rect, paint);
    } else {
      paint.style = PaintingStyle.fill;
      canvas.drawRect(rect, paint);
    }
  }

  void _drawMA(
    Canvas canvas,
    int period,
    Color color,
    double minP,
    double maxP,
    double chartH,
    double candleW,
    double scrollOffset,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final path = Path();
    bool started = false;

    for (int i = period - 1; i < data.length; i++) {
      double sum = 0;
      for (int j = 0; j < period; j++) {
        sum += data[i - j].close;
      }
      final avg = sum / period;

      final x = (i * candleW) + scrollOffset + candleW / 2;

      // Skip points far outside the viewport
      if (x < -50 || x > canvas.getLocalClipBounds().width + 50) {
        if (started) {
          // If we were drawing, we should stop and restart when we enter again
          // But for simple MA lines, just continuing is usually fine as path handles it
        }
        continue;
      }

      final y = _getY(avg, minP, maxP, chartH);

      if (!started) {
        path.moveTo(x, y);
        started = true;
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  void _drawEMA(
    Canvas canvas,
    int period,
    Color color,
    double minP,
    double maxP,
    double chartH,
    double candleW,
    double scrollOffset,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final path = Path();
    bool started = false;

    // EMA calculation: EMA = (Price - Previous EMA) * (2 / (Period + 1)) + Previous EMA
    final double multiplier = 2 / (period + 1);
    double? lastEma;

    for (int i = 0; i < data.length; i++) {
      final double price = data[i].close;
      if (lastEma == null) {
        lastEma = price;
      } else {
        lastEma = (price - lastEma) * multiplier + lastEma;
      }

      // Only start drawing after we have enough data (though EMA can start from 1st point)
      if (i < period - 1) continue;

      final x = (i * candleW) + scrollOffset + candleW / 2;
      if (x < -50 || x > canvas.getLocalClipBounds().width + 50) continue;

      final y = _getY(lastEma, minP, maxP, chartH);

      if (!started) {
        path.moveTo(x, y);
        started = true;
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset offset, {
    bool isBold = false,
  }) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: textColor.withValues(alpha: 0.8),
          fontSize: 9,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, offset);
  }

  double _getY(double price, double minP, double maxP, double chartH) {
    return chartH - (price - minP) / (maxP - minP) * chartH;
  }

  @override
  bool shouldRepaint(covariant KLinePainter oldDelegate) {
    return oldDelegate.scale != scale ||
        oldDelegate.scrollOffset != scrollOffset ||
        oldDelegate.tapPosition != tapPosition ||
        oldDelegate.data != data;
  }
}
