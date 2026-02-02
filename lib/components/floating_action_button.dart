import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../theme/colors.dart';

/// NZFloatingActionButton 的样式类型
enum NZFloatingActionButtonType {
  /// 标准样式（带有图标和标签）
  standard,

  /// 仅图标样式
  icon,

  /// 图片样式（背景为图片）
  image,
}

/// NZFloatingActionButton 是一个多功能的悬浮按钮，支持：
/// 1. 拖动 (draggable)
/// 2. 图片背景 (image)
/// 3. 仅图标或图标加文字 (standard/icon)
/// 4. 滚动隐藏 (scroll to hide)
class NZFloatingActionButton extends StatefulWidget {
  /// 点击回调
  final VoidCallback onPressed;

  /// 图标组件
  final Widget? icon;

  /// 标签文本（用于 standard 模式）
  final String? label;

  /// 背景图片（用于 image 模式）
  final ImageProvider? image;

  /// 按钮类型
  final NZFloatingActionButtonType type;

  /// 是否可以拖动
  final bool draggable;

  /// 初始位置（仅在 draggable 为 true 时生效）
  final Offset initialPosition;

  /// 滚动控制器（用于实现滚动隐藏功能）
  final ScrollController? scrollController;

  /// 背景颜色
  final Color? backgroundColor;

  /// 前景颜色（图标和文字）
  final Color? foregroundColor;

  /// 英雄动画标签
  final Object? heroTag;

  /// 提示信息
  final String? tooltip;

  const NZFloatingActionButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.label,
    this.image,
    this.type = NZFloatingActionButtonType.standard,
    this.draggable = false,
    this.initialPosition = const Offset(20, 20),
    this.scrollController,
    this.backgroundColor,
    this.foregroundColor,
    this.heroTag,
    this.tooltip,
  });

  /// 快速创建标准样式 FAB (图标 + 文字)
  factory NZFloatingActionButton.standard({
    Key? key,
    required VoidCallback onPressed,
    required Widget icon,
    required String label,
    bool draggable = false,
    Offset initialPosition = const Offset(20, 20),
    ScrollController? scrollController,
    Color? backgroundColor,
    Color? foregroundColor,
    Object? heroTag,
    String? tooltip,
  }) => NZFloatingActionButton(
    key: key,
    onPressed: onPressed,
    icon: icon,
    label: label,
    type: NZFloatingActionButtonType.standard,
    draggable: draggable,
    initialPosition: initialPosition,
    scrollController: scrollController,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    heroTag: heroTag,
    tooltip: tooltip,
  );

  /// 快速创建仅图标样式 FAB
  factory NZFloatingActionButton.icon({
    Key? key,
    required VoidCallback onPressed,
    required Widget icon,
    bool draggable = false,
    Offset initialPosition = const Offset(20, 20),
    ScrollController? scrollController,
    Color? backgroundColor,
    Color? foregroundColor,
    Object? heroTag,
    String? tooltip,
  }) => NZFloatingActionButton(
    key: key,
    onPressed: onPressed,
    icon: icon,
    type: NZFloatingActionButtonType.icon,
    draggable: draggable,
    initialPosition: initialPosition,
    scrollController: scrollController,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    heroTag: heroTag,
    tooltip: tooltip,
  );

  /// 快速创建图片背景样式 FAB
  factory NZFloatingActionButton.image({
    Key? key,
    required VoidCallback onPressed,
    required ImageProvider image,
    Widget? icon,
    bool draggable = false,
    Offset initialPosition = const Offset(20, 20),
    ScrollController? scrollController,
    Object? heroTag,
    String? tooltip,
  }) => NZFloatingActionButton(
    key: key,
    onPressed: onPressed,
    image: image,
    icon: icon,
    type: NZFloatingActionButtonType.image,
    draggable: draggable,
    initialPosition: initialPosition,
    scrollController: scrollController,
    heroTag: heroTag,
    tooltip: tooltip,
  );

  @override
  State<NZFloatingActionButton> createState() => _NZFloatingActionButtonState();
}

class _NZFloatingActionButtonState extends State<NZFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late Offset _position;
  late AnimationController _hideController;
  late Animation<double> _hideAnimation;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _position = widget.initialPosition;
    _hideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _hideAnimation = CurvedAnimation(
      parent: _hideController,
      curve: Curves.easeInOut,
    );
    _hideController.forward(); // 初始显示

    if (widget.scrollController != null) {
      widget.scrollController!.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    if (widget.scrollController != null) {
      widget.scrollController!.removeListener(_onScroll);
    }
    _hideController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (widget.scrollController == null) return;
    if (widget.scrollController!.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isVisible) {
        _isVisible = false;
        _hideController.reverse();
      }
    } else if (widget.scrollController!.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isVisible) {
        _isVisible = true;
        _hideController.forward();
      }
    }
  }

  void _snapToEdge(Size size, EdgeInsets padding) {
    if (!widget.draggable) return;

    final double centerX = size.width / 2;
    double targetX;
    if (_position.dx + 28 < centerX) {
      targetX = 16.0;
    } else {
      targetX = size.width - 56 - 16.0;
    }

    final double targetY = _position.dy.clamp(
      padding.top + 16,
      size.height - padding.bottom - 56 - 16,
    );

    setState(() {
      _position = Offset(targetX, targetY);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? NZColor.nezhaPrimary;
    final Color effectiveForegroundColor =
        widget.foregroundColor ?? Colors.white;

    Widget fabBody;

    switch (widget.type) {
      case NZFloatingActionButtonType.standard:
        fabBody = FloatingActionButton.extended(
          onPressed: widget.onPressed,
          icon: widget.icon,
          label: Text(widget.label!),
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          heroTag: widget.heroTag,
          tooltip: widget.tooltip,
        );
        break;
      case NZFloatingActionButtonType.icon:
        fabBody = FloatingActionButton(
          onPressed: widget.onPressed,
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          heroTag: widget.heroTag,
          tooltip: widget.tooltip,
          child: widget.icon,
        );
        break;
      case NZFloatingActionButtonType.image:
        fabBody = SizedBox(
          width: 56,
          height: 56,
          child: FloatingActionButton(
            onPressed: widget.onPressed,
            backgroundColor: Colors.transparent,
            elevation: 4,
            heroTag: widget.heroTag,
            tooltip: widget.tooltip,
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Image(
                  image: widget.image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                // 蒙层增加层次感
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.1),
                        Colors.black.withValues(alpha: 0.4),
                      ],
                    ),
                  ),
                ),
                if (widget.icon != null)
                  Center(
                    child: IconTheme.merge(
                      data: const IconThemeData(color: Colors.white, size: 24),
                      child: widget.icon!,
                    ),
                  ),
              ],
            ),
          ),
        );
        break;
    }

    Widget content = ScaleTransition(scale: _hideAnimation, child: fabBody);

    if (widget.draggable) {
      return Stack(
        children: [
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: Draggable(
              feedback: Material(
                color: Colors.transparent,
                child: Opacity(opacity: 0.8, child: content),
              ),
              childWhenDragging: const SizedBox.shrink(),
              onDragUpdate: (details) {
                setState(() {
                  _position += details.delta;
                });
              },
              onDragEnd: (details) {
                _snapToEdge(size, padding);
              },
              child: content,
            ),
          ),
        ],
      );
    }

    return content;
  }
}
