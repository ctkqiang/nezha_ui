import 'package:flutter/material.dart';

/// NZDrawerPosition
/// 抽屉显示位置
enum NZDrawerPosition { left, right, top, bottom }

/// NZDrawer
/// 一个高度可定制的抽屉组件，可以放置在屏幕的任何一侧。
class NZDrawer extends StatelessWidget {
  /// 抽屉内容
  final Widget child;

  /// 抽屉位置
  final NZDrawerPosition position;

  /// 尺寸 (左/右为宽度，上/下为高度)
  final double? size;

  /// 背景颜色
  final Color? backgroundColor;

  /// 抽屉阴影
  final double elevation;

  /// 是否显示拖动手柄 (仅适用于顶部/底部)
  final bool showDragHandle;

  /// 圆角半径
  final double borderRadius;

  const NZDrawer({
    super.key,
    required this.child,
    this.position = NZDrawerPosition.left,
    this.size,
    this.backgroundColor,
    this.elevation = 16.0,
    this.showDragHandle = true,
    this.borderRadius = 16.0,
  });

  /// 以模态框形式显示抽屉的静态方法
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    NZDrawerPosition position = NZDrawerPosition.left,
    double? size,
    Color? backgroundColor,
    double elevation = 16.0,
    bool showDragHandle = true,
    double borderRadius = 16.0,
  }) {
    if (position == NZDrawerPosition.bottom) {
      return showModalBottomSheet<T>(
        context: context,
        backgroundColor: backgroundColor ?? Theme.of(context).canvasColor,
        elevation: elevation,
        isScrollControlled: true,
        showDragHandle: showDragHandle,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(borderRadius),
          ),
        ),
        builder: (context) => Container(
          height: size,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: child,
        ),
      );
    }

    // 对于顶部、左侧、右侧，我们使用自定义对话框或 Scaffold 集成的抽屉。
    // 为了简单起见，我们将顶部实现为底部菜单的变体，将左侧/右侧实现为标准抽屉。

    if (position == NZDrawerPosition.top) {
      return showGeneralDialog<T>(
        context: context,
        barrierDismissible: true,
        barrierLabel: '关闭',
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, anim1, anim2) {
          return Align(
            alignment: Alignment.topCenter,
            child: Material(
              color: backgroundColor ?? Theme.of(context).canvasColor,
              elevation: elevation,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(borderRadius),
              ),
              child: Container(
                width: double.infinity,
                height: size ?? 300,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: child,
              ),
            ),
          );
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(anim1),
            child: child,
          );
        },
      );
    }

    // 对于左侧和右侧，通常与 Scaffold.drawer / Scaffold.endDrawer 一起使用
    // 但我们也可以将它们作为模态对话框显示。
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: '关闭',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: position == NZDrawerPosition.left
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Material(
            color: backgroundColor ?? Theme.of(context).canvasColor,
            elevation: elevation,
            borderRadius: BorderRadius.horizontal(
              left: position == NZDrawerPosition.right
                  ? Radius.circular(borderRadius)
                  : Radius.zero,
              right: position == NZDrawerPosition.left
                  ? Radius.circular(borderRadius)
                  : Radius.zero,
            ),
            child: SizedBox(
              width: size ?? 300,
              height: double.infinity,
              child: child,
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(position == NZDrawerPosition.left ? -1 : 1, 0),
            end: Offset.zero,
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 当作为标准组件使用时 (例如在 Scaffold.drawer 中)
    return Drawer(
      width:
          (position == NZDrawerPosition.left ||
              position == NZDrawerPosition.right)
          ? size
          : null,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: position == NZDrawerPosition.right
              ? Radius.circular(borderRadius)
              : Radius.zero,
          right: position == NZDrawerPosition.left
              ? Radius.circular(borderRadius)
              : Radius.zero,
        ),
      ),
      child: child,
    );
  }
}
