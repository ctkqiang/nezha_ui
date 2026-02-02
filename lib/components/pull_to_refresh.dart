import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/colors.dart';

/// 刷新组件的状态枚举
enum NZRefreshStatus {
  /// 初始状态/下拉中
  pulling,

  /// 已经拉到位，释放即可刷新
  ready,

  /// 正在刷新中
  refreshing,

  /// 刷新成功
  success,
}

/// NZPullToRefresh 是一个符合 NezhaUI 设计规范的下拉刷新组件。
///
/// 它在原生 [RefreshIndicator] 的基础上进行了封装，支持：
/// 1. 隐藏默认的加载圆圈 (noSpinner)。
/// 2. 自定义提示文本 (Label)。
/// 3. 自定义色彩和圆角。
class NZPullToRefresh extends StatefulWidget {
  /// 刷新时展示的内容（通常是一个 ScrollView）
  final Widget child;

  /// 刷新时的回调函数
  final Future<void> Function() onRefresh;

  /// 是否显示默认的加载圆圈。
  /// 默认为 true。如果设置为 false，将不会显示 Spinner。
  final bool showSpinner;

  /// 自定义提示文本（初始状态/下拉时）。
  /// 当 [showSpinner] 为 false 时生效。
  final String? label;

  /// 释放即可刷新的提示文本。
  final String? readyLabel;

  /// 正在刷新时的提示文本。
  final String? refreshingLabel;

  /// 刷新成功后的提示文本。
  final String? successLabel;

  /// 提示文本的样式
  final TextStyle? labelStyle;

  /// 是否显示图标。
  final bool showIcon;

  /// 刷新成功后的图标。
  final IconData? successIcon;

  /// 刷新指示器的背景颜色
  final Color? backgroundColor;

  /// 刷新指示器的进度条颜色
  final Color? color;

  /// 刷新指示器的出现偏移量
  final double displacement;

  /// 触发刷新的拉动距离
  /// 默认为 60.0
  final double triggerDistance;

  /// 刷新结束后的延迟时间。
  /// 默认不延迟。
  final Duration refreshDelay;

  /// 是否开启震动反馈
  final bool enableHaptic;

  const NZPullToRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
    this.showSpinner = true,
    this.label,
    this.readyLabel = '释放立即刷新',
    this.refreshingLabel = '正在刷新...',
    this.successLabel = '刷新成功',
    this.labelStyle,
    this.showIcon = true,
    this.successIcon = Icons.check_circle_outline_rounded,
    this.backgroundColor,
    this.color,
    this.displacement = 40.0,
    this.triggerDistance = 60.0,
    this.refreshDelay = Duration.zero,
    this.enableHaptic = true,
  });

  @override
  State<NZPullToRefresh> createState() => _NZPullToRefreshState();
}

class _NZPullToRefreshState extends State<NZPullToRefresh> {
  double _pullOffset = 0.0;
  NZRefreshStatus _status = NZRefreshStatus.pulling;

  Future<void> _handleRefresh() async {
    if (_status == NZRefreshStatus.refreshing) return;

    setState(() {
      _status = NZRefreshStatus.refreshing;
    });

    if (widget.enableHaptic) {
      HapticFeedback.mediumImpact();
    }

    try {
      await widget.onRefresh();
      if (mounted) {
        setState(() {
          _status = NZRefreshStatus.success;
        });
        if (widget.enableHaptic) {
          HapticFeedback.lightImpact();
        }
      }
      if (widget.refreshDelay != Duration.zero) {
        await Future.delayed(widget.refreshDelay);
      }
    } finally {
      if (mounted) {
        setState(() {
          _status = NZRefreshStatus.pulling;
        });
      }
    }
  }

  void _updateOffset(double pixels) {
    final newOffset = -pixels;
    if (newOffset == _pullOffset) return;

    setState(() {
      _pullOffset = newOffset;

      // 只有在非刷新/成功状态下才更新 ready 状态
      if (_status != NZRefreshStatus.refreshing &&
          _status != NZRefreshStatus.success) {
        if (_pullOffset >= widget.triggerDistance) {
          if (_status != NZRefreshStatus.ready) {
            _status = NZRefreshStatus.ready;
            if (widget.enableHaptic) {
              HapticFeedback.selectionClick();
            }
          }
        } else {
          _status = NZRefreshStatus.pulling;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color indicatorColor = widget.color ?? NZColor.nezhaPrimary;

    if (!widget.showSpinner) {
      return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification ||
              notification is ScrollEndNotification ||
              notification is OverscrollNotification) {
            _updateOffset(notification.metrics.pixels);
          }
          return false;
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            if (widget.label != null ||
                widget.readyLabel != null ||
                widget.refreshingLabel != null ||
                widget.successLabel != null)
              Positioned(
                top:
                    _status == NZRefreshStatus.refreshing ||
                        _status == NZRefreshStatus.success
                    ? (widget.displacement / 2)
                    : (widget.displacement / 2) +
                          (_pullOffset > 0 ? 0 : _pullOffset),
                child: Opacity(
                  opacity:
                      _status == NZRefreshStatus.refreshing ||
                          _status == NZRefreshStatus.success
                      ? 1.0
                      : (_pullOffset / (widget.displacement * 0.8)).clamp(
                          0.0,
                          1.0,
                        ),
                  child: _buildLabelContent(indicatorColor),
                ),
              ),
            RefreshIndicator(
              onRefresh: _handleRefresh,
              displacement: widget.displacement,
              edgeOffset: widget.displacement / 2,
              backgroundColor: Colors.transparent,
              color: Colors.transparent,
              strokeWidth: 0,
              elevation: 0,
              semanticsLabel: widget.label,
              child: widget.child,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      displacement: widget.displacement,
      backgroundColor: widget.backgroundColor ?? Colors.white,
      color: indicatorColor,
      semanticsLabel: widget.label,
      child: widget.child,
    );
  }

  Widget _buildLabelContent(Color color) {
    String currentText = widget.label ?? '下拉刷新';
    Widget icon;

    switch (_status) {
      case NZRefreshStatus.success:
        currentText = widget.successLabel ?? '刷新成功';
        icon = Icon(
          widget.successIcon ?? Icons.check_circle_outline_rounded,
          size: 16,
          color: color.withValues(alpha: 0.6),
        );
        break;
      case NZRefreshStatus.refreshing:
        currentText = widget.refreshingLabel ?? '正在刷新...';
        icon = SizedBox(
          width: 14,
          height: 14,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              color.withValues(alpha: 0.6),
            ),
          ),
        );
        break;
      case NZRefreshStatus.ready:
        currentText = widget.readyLabel ?? '释放立即刷新';
        icon = Icon(
          Icons.arrow_upward_rounded,
          size: 16,
          color: color.withValues(alpha: 0.6),
        );
        break;
      case NZRefreshStatus.pulling:
        currentText = widget.label ?? '下拉刷新';
        icon = Icon(
          Icons.arrow_downward_rounded,
          size: 16,
          color: color.withValues(alpha: 0.6),
        );
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showIcon) ...[icon, const SizedBox(width: 8)],
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOutBack,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Text(
            currentText,
            key: ValueKey<String>(currentText),
            style:
                widget.labelStyle ??
                TextStyle(
                  color: color.withValues(alpha: 0.8),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
