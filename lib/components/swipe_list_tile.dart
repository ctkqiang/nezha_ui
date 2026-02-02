import 'package:flutter/material.dart';
import 'package:nezha_ui/theme/colors.dart';

/// 滑动操作按钮配置
class NZSwipeAction {
  /// 按钮标签
  final String? label;

  /// 按钮图标
  final Widget? icon;

  /// 背景颜色
  final Color? backgroundColor;

  /// 点击回调
  final VoidCallback? onTap;

  /// 按钮宽度，默认 80.0
  final double width;

  /// 按钮高度，默认 80.0
  final double height;

  const NZSwipeAction({
    this.label,
    this.icon,
    this.backgroundColor,
    this.onTap,
    this.width = 80.0,
    this.height = 80.0,
  });
}

/// 滑动单元格组件 (类似微信小程序风格)
/// 支持左右滑动展示操作按钮，支持长按
class NZSwipeListTile extends StatefulWidget {
  /// 单元格主内容
  final Widget child;

  /// 左侧滑动出的按钮
  final List<NZSwipeAction> leftActions;

  /// 右侧滑动出的按钮
  final List<NZSwipeAction> rightActions;

  /// 顶部滑动出的按钮
  final List<NZSwipeAction> topActions;

  /// 底部滑动出的按钮
  final List<NZSwipeAction> bottomActions;

  /// 是否禁用滑动
  final bool disabled;

  /// 长按回调
  final VoidCallback? onLongPress;

  /// 点击回调
  final VoidCallback? onTap;

  /// 背景颜色
  final Color? backgroundColor;

  const NZSwipeListTile({
    super.key,
    required this.child,
    this.leftActions = const [],
    this.rightActions = const [],
    this.topActions = const [],
    this.bottomActions = const [],
    this.disabled = false,
    this.onLongPress,
    this.onTap,
    this.backgroundColor,
  });

  @override
  State<NZSwipeListTile> createState() => _NZSwipeListTileState();
}

class _NZSwipeListTileState extends State<NZSwipeListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _dragExtent = Offset.zero;
  bool _isHorizontal = true;

  double get _maxLeftExtent {
    return widget.leftActions.fold(0, (sum, action) => sum + action.width);
  }

  double get _maxRightExtent {
    return widget.rightActions.fold(0, (sum, action) => sum + action.width);
  }

  double get _maxTopExtent {
    return widget.topActions.fold(0, (sum, action) => sum + action.height);
  }

  double get _maxBottomExtent {
    return widget.bottomActions.fold(0, (sum, action) => sum + action.height);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _controller.addListener(() {
      setState(() {
        if (_isHorizontal) {
          _dragExtent = Offset(_controller.value, 0);
        } else {
          _dragExtent = Offset(0, _controller.value);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    if (widget.disabled) return;
    // 重置方向判定
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (widget.disabled) return;
    setState(() {
      // 如果还没有确定方向，根据首次滑动的偏移量确定
      if (_dragExtent == Offset.zero) {
        if (details.delta.dx.abs() > details.delta.dy.abs()) {
          _isHorizontal = true;
        } else {
          _isHorizontal = false;
        }
      }

      if (_isHorizontal) {
        double newX = _dragExtent.dx + details.delta.dx;
        // 限制范围
        if (newX > 0 && widget.leftActions.isEmpty) newX = 0;
        if (newX < 0 && widget.rightActions.isEmpty) newX = 0;
        if (newX > _maxLeftExtent) newX = _maxLeftExtent;
        if (newX < -_maxRightExtent) newX = -_maxRightExtent;
        _dragExtent = Offset(newX, 0);
      } else {
        double newY = _dragExtent.dy + details.delta.dy;
        // 限制范围
        if (newY > 0 && widget.topActions.isEmpty) newY = 0;
        if (newY < 0 && widget.bottomActions.isEmpty) newY = 0;
        if (newY > _maxTopExtent) newY = _maxTopExtent;
        if (newY < -_maxBottomExtent) newY = -_maxBottomExtent;
        _dragExtent = Offset(0, newY);
      }
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (widget.disabled) return;
    if (_isHorizontal) {
      if (_dragExtent.dx > 0) {
        if (_dragExtent.dx > _maxLeftExtent / 2) {
          _openLeft();
        } else {
          _close();
        }
      } else if (_dragExtent.dx < 0) {
        if (_dragExtent.dx.abs() > _maxRightExtent / 2) {
          _openRight();
        } else {
          _close();
        }
      }
    } else {
      if (_dragExtent.dy > 0) {
        if (_dragExtent.dy > _maxTopExtent / 2) {
          _openTop();
        } else {
          _close();
        }
      } else if (_dragExtent.dy < 0) {
        if (_dragExtent.dy.abs() > _maxBottomExtent / 2) {
          _openBottom();
        } else {
          _close();
        }
      }
    }
  }

  void _openLeft() {
    _isHorizontal = true;
    _controller.value = _dragExtent.dx;
    _controller.animateTo(_maxLeftExtent, curve: Curves.easeOut);
  }

  void _openRight() {
    _isHorizontal = true;
    _controller.value = _dragExtent.dx;
    _controller.animateTo(-_maxRightExtent, curve: Curves.easeOut);
  }

  void _openTop() {
    _isHorizontal = false;
    _controller.value = _dragExtent.dy;
    _controller.animateTo(_maxTopExtent, curve: Curves.easeOut);
  }

  void _openBottom() {
    _isHorizontal = false;
    _controller.value = _dragExtent.dy;
    _controller.animateTo(-_maxBottomExtent, curve: Curves.easeOut);
  }

  void _close() {
    if (_isHorizontal) {
      _controller.value = _dragExtent.dx;
    } else {
      _controller.value = _dragExtent.dy;
    }
    _controller.animateTo(0, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDragStart,
      onPanUpdate: _handleDragUpdate,
      onPanEnd: _handleDragEnd,
      onLongPress: widget.onLongPress,
      onTap: () {
        if (_dragExtent != Offset.zero) {
          _close();
        } else if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 背景层 (操作按钮)
          Positioned.fill(
            child: Container(
              color: widget.backgroundColor ?? Colors.white,
              child: Stack(
                children: [
                  // 左侧按钮
                  if (widget.leftActions.isNotEmpty)
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Row(
                        children: widget.leftActions.map((action) {
                          return _buildAction(action, true, Axis.horizontal);
                        }).toList(),
                      ),
                    ),
                  // 右侧按钮
                  if (widget.rightActions.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Row(
                        children: widget.rightActions.map((action) {
                          return _buildAction(action, false, Axis.horizontal);
                        }).toList(),
                      ),
                    ),
                  // 顶部按钮
                  if (widget.topActions.isNotEmpty)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: widget.topActions.map((action) {
                          return _buildAction(action, true, Axis.vertical);
                        }).toList(),
                      ),
                    ),
                  // 底部按钮
                  if (widget.bottomActions.isNotEmpty)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: widget.bottomActions.map((action) {
                          return _buildAction(action, false, Axis.vertical);
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // 内容层
          Transform.translate(
            offset: _dragExtent,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.white,
              ),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAction(NZSwipeAction action, bool isLeading, Axis axis) {
    return GestureDetector(
      onTap: () {
        _close();
        action.onTap?.call();
      },
      child: Container(
        width: axis == Axis.horizontal ? action.width : null,
        height: axis == Axis.vertical ? action.height : null,
        color:
            action.backgroundColor ??
            (isLeading ? NZColor.nezhaPrimary : NZColor.red600),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (action.icon != null) ...[
              IconTheme(
                data: const IconThemeData(color: Colors.white, size: 20),
                child: action.icon!,
              ),
              if (action.label != null) const SizedBox(height: 4),
            ],
            if (action.label != null)
              Text(
                action.label!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
