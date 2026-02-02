import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nezha_ui/theme/colors.dart';

/// 公告栏滚动方向
enum NZNoticeBarDirection {
  /// 自右向左滚动 (水平)
  horizontal,

  /// 自下向上滚动 (垂直)
  vertical,
}

/// 公告栏样式主题
enum NZNoticeBarTheme {
  /// 默认主题 (橙黄色系)
  warning,

  /// 成功主题 (绿色系)
  success,

  /// 错误主题 (红色系)
  error,

  /// 信息主题 (蓝色系)
  info,

  /// 金融/新闻主题 (深色背景)
  finance,
}

/// NZNoticeBar 公告栏组件。
///
/// 用于循环播放重要的公告、新闻或提示信息。支持水平和垂直滚动。
class NZNoticeBar extends StatefulWidget {
  /// 公告内容列表，如果是水平滚动通常只传一个 String
  final List<String> text;

  /// 主题样式
  final NZNoticeBarTheme theme;

  /// 滚动方向
  final NZNoticeBarDirection direction;

  /// 前置图标
  final Widget? icon;

  /// 后置组件 (通常是关闭图标或箭头)
  final Widget? suffix;

  /// 滚动速度 (像素/秒)，仅对水平滚动有效
  final double speed;

  /// 垂直滚动的停留时间 (毫秒)
  final int duration;

  /// 点击回调
  final VoidCallback? onTap;

  /// 后置组件点击回调 (如关闭)
  final VoidCallback? onSuffixTap;

  /// 背景颜色，设置后将覆盖主题默认色
  final Color? backgroundColor;

  /// 文字颜色，设置后将覆盖主题默认色
  final Color? textColor;

  const NZNoticeBar({
    super.key,
    required this.text,
    this.theme = NZNoticeBarTheme.warning,
    this.direction = NZNoticeBarDirection.horizontal,
    this.icon,
    this.suffix,
    this.speed = 50.0,
    this.duration = 3000,
    this.onTap,
    this.onSuffixTap,
    this.backgroundColor,
    this.textColor,
  });

  @override
  State<NZNoticeBar> createState() => _NZNoticeBarState();
}

class _NZNoticeBarState extends State<NZNoticeBar>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  Timer? _timer;
  int _currentIndex = 0;
  double _offset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.direction == NZNoticeBarDirection.horizontal) {
        _startHorizontalScroll();
      } else {
        _startVerticalScroll();
      }
    });
  }

  void _startHorizontalScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!mounted) return;
      if (_scrollController.hasClients) {
        _offset += widget.speed / 60;
        if (_offset >= _scrollController.position.maxScrollExtent) {
          _offset = -_scrollController.position.viewportDimension;
        }
        _scrollController.jumpTo(_offset);
      }
    });
  }

  void _startVerticalScroll() {
    if (widget.text.length <= 1) return;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: widget.duration), (timer) {
      if (!mounted) return;
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.text.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Color _getBackgroundColor() {
    if (widget.backgroundColor != null) return widget.backgroundColor!;
    switch (widget.theme) {
      case NZNoticeBarTheme.warning:
        return const Color(0xFFFFF7E8);
      case NZNoticeBarTheme.success:
        return const Color(0xFFE8FFEA);
      case NZNoticeBarTheme.error:
        return const Color(0xFFFFECE8);
      case NZNoticeBarTheme.info:
        return const Color(0xFFE8F3FF);
      case NZNoticeBarTheme.finance:
        return const Color(0xFF1D2129);
    }
  }

  Color _getTextColor() {
    if (widget.textColor != null) return widget.textColor!;
    switch (widget.theme) {
      case NZNoticeBarTheme.warning:
        return const Color(0xFFFF9900);
      case NZNoticeBarTheme.success:
        return const Color(0xFF00B42A);
      case NZNoticeBarTheme.error:
        return const Color(0xFFF53F3F);
      case NZNoticeBarTheme.info:
        return NZColor.nezhaPrimary;
      case NZNoticeBarTheme.finance:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getBackgroundColor();
    final textColor = _getTextColor();

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(color: bgColor),
        child: Row(
          children: [
            if (widget.icon != null) ...[
              IconTheme(
                data: IconThemeData(color: textColor, size: 16),
                child: widget.icon!,
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: widget.direction == NZNoticeBarDirection.horizontal
                  ? ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Center(
                          child: Text(
                            widget.text.first,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight:
                                  widget.theme == NZNoticeBarTheme.finance
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        );
                      },
                    )
                  : AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        key: ValueKey<int>(_currentIndex),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.text[_currentIndex],
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: widget.theme == NZNoticeBarTheme.finance
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
            ),
            if (widget.suffix != null) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: widget.onSuffixTap,
                child: IconTheme(
                  data: IconThemeData(
                    color: textColor.withValues(alpha: 0.6),
                    size: 16,
                  ),
                  child: widget.suffix!,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
