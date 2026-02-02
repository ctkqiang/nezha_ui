import 'package:flutter/material.dart';

/// NZBackToTop
/// 当用户向下滚动时出现的按钮，允许用户快速滚动回顶部。
class NZBackToTop extends StatefulWidget {
  /// 监听和控制的滚动控制器
  final ScrollController scrollController;

  /// 按钮出现前距离顶部的阈值距离
  final double threshold;

  /// 子组件 (通常是一个图标)
  final Widget? child;

  /// 滚动动画的持续时间
  final Duration duration;

  /// 滚动动画的曲线
  final Curve curve;

  /// 距离屏幕边缘的内边距
  final EdgeInsets padding;

  const NZBackToTop({
    super.key,
    required this.scrollController,
    this.threshold = 300.0,
    this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  State<NZBackToTop> createState() => _NZBackToTopState();
}

class _NZBackToTopState extends State<NZBackToTop> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final bool isVisible = widget.scrollController.offset > widget.threshold;
    if (isVisible != _isVisible) {
      setState(() {
        _isVisible = isVisible;
      });
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Padding(
        padding: widget.padding,
        child: FloatingActionButton(
          mini: true,
          onPressed: _scrollToTop,
          child: widget.child ?? const Icon(Icons.arrow_upward_rounded),
        ),
      ),
    );
  }
}
