import 'package:flutter/material.dart';
import 'package:nezha_ui/nezha.dart';

/// NZPopUp 动作按钮配置
class NZPopUpAction {
  /// 按钮文本
  final String label;

  /// 点击回调
  final VoidCallback? onPressed;

  /// 是否为警示性操作（显示为红色）
  final bool isDestructive;

  /// 是否为主操作（加粗显示）
  final bool isPrimary;

  /// 自定义颜色
  final Color? color;

  const NZPopUpAction({
    required this.label,
    this.onPressed,
    this.isDestructive = false,
    this.isPrimary = false,
    this.color,
  });
}

/// NZPopUp 是一个微信风格的弹窗组件。
/// 支持标题、内容描述以及横向或纵向排列的操作按钮。
class NZPopUp extends StatelessWidget {
  /// 弹窗标题
  final String? title;

  /// 弹窗内容描述
  final String? content;

  /// 自定义内容组件，优先级高于 [content]
  final Widget? contentWidget;

  /// 操作按钮列表
  final List<NZPopUpAction> actions;

  /// 按钮排列方向，默认横向。当按钮超过 2 个时建议设为纵向。
  final Axis actionsAxis;

  /// 是否可以通过点击遮罩层关闭
  final bool barrierDismissible;

  const NZPopUp({
    super.key,
    this.title,
    this.content,
    this.contentWidget,
    required this.actions,
    this.actionsAxis = Axis.horizontal,
    this.barrierDismissible = true,
  });

  /// 快速显示一个警告弹窗
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? content,
    Widget? contentWidget,
    required List<NZPopUpAction> actions,
    Axis actionsAxis = Axis.horizontal,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => NZPopUp(
        title: title,
        content: content,
        contentWidget: contentWidget,
        actions: actions,
        actionsAxis: actionsAxis,
      ),
    );
  }

  /// 快速显示一个带“确定”和“取消”的确认弹窗
  static Future<bool?> confirm(
    BuildContext context, {
    String? title,
    String? content,
    String confirmLabel = '确定',
    String cancelLabel = '取消',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDestructive = false,
  }) {
    return show<bool>(
      context,
      title: title,
      content: content,
      actions: [
        NZPopUpAction(
          label: cancelLabel,
          onPressed: () {
            Navigator.pop(context, false);
            onCancel?.call();
          },
        ),
        NZPopUpAction(
          label: confirmLabel,
          isPrimary: true,
          isDestructive: isDestructive,
          onPressed: () {
            Navigator.pop(context, true);
            onConfirm?.call();
          },
        ),
      ],
    );
  }

  /// 快速显示一个仅带“确定”的提示弹窗
  static Future<void> alert(
    BuildContext context, {
    String? title,
    String? content,
    String confirmLabel = '确定',
    VoidCallback? onConfirm,
  }) {
    return show<void>(
      context,
      title: title,
      content: content,
      actions: [
        NZPopUpAction(
          label: confirmLabel,
          isPrimary: true,
          onPressed: () {
            Navigator.pop(context);
            onConfirm?.call();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 48),
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 标题和内容
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null) ...[
                    Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (contentWidget != null)
                    contentWidget!
                  else if (content != null)
                    Text(
                      content!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: title == null
                            ? Colors.black
                            : Colors.black.withValues(alpha: 0.5),
                        height: 1.4,
                      ),
                    ),
                ],
              ),
            ),
            // 分隔线
            const Divider(
              height: 0.5,
              thickness: 0.5,
              color: Color(0xFFE5E5E5),
            ),
            // 按钮栏
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    if (actionsAxis == Axis.horizontal && actions.length <= 2) {
      return IntrinsicHeight(
        child: Row(
          children: List.generate(actions.length, (index) {
            final action = actions[index];
            return Expanded(
              child: Row(
                children: [
                  if (index > 0)
                    const VerticalDivider(
                      width: 0.5,
                      thickness: 0.5,
                      color: Color(0xFFE5E5E5),
                    ),
                  Expanded(child: _buildActionButton(context, action)),
                ],
              ),
            );
          }),
        ),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(actions.length, (index) {
          final action = actions[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (index > 0)
                const Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: Color(0xFFE5E5E5),
                ),
              _buildActionButton(context, action),
            ],
          );
        }),
      );
    }
  }

  Widget _buildActionButton(BuildContext context, NZPopUpAction action) {
    Color textColor =
        action.color ??
        (action.isDestructive
            ? NZColor.red500
            : (action.isPrimary ? NZColor.nezhaPrimary : Colors.black));

    return InkWell(
      onTap: action.onPressed,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(
          actionsAxis == Axis.horizontal && actions.indexOf(action) == 0
              ? 12
              : (actionsAxis == Axis.vertical &&
                        actions.indexOf(action) == actions.length - 1
                    ? 12
                    : 0),
        ),
        bottomRight: Radius.circular(
          actionsAxis == Axis.horizontal &&
                  actions.indexOf(action) == actions.length - 1
              ? 12
              : (actionsAxis == Axis.vertical &&
                        actions.indexOf(action) == actions.length - 1
                    ? 12
                    : 0),
        ),
      ),
      child: Container(
        height: 56,
        alignment: Alignment.center,
        child: Text(
          action.label,
          style: TextStyle(
            fontSize: 17,
            fontWeight: action.isPrimary ? FontWeight.w600 : FontWeight.normal,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
