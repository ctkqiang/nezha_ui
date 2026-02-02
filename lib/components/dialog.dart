import 'package:flutter/material.dart';
import 'package:nezha_ui/nezha.dart';

/// NZDialog 动作按钮配置
class NZDialogAction {
  final String label;
  final VoidCallback? onPressed;
  final bool isDestructive;
  final bool isPrimary;
  final Color? color;

  const NZDialogAction({
    required this.label,
    this.onPressed,
    this.isDestructive = false,
    this.isPrimary = false,
    this.color,
  });
}

/// NZDialog 类型
enum NZDialogType {
  /// 基础对话框
  basic,

  /// 确认对话框
  confirm,

  /// 成功对话框
  success,

  /// 错误对话框
  error,

  /// 警告对话框
  warning,

  /// 信息对话框
  info,

  /// 输入对话框
  input,

  /// 加载对话框
  loading,

  /// 进度对话框
  progress,

  /// 图片/视觉对话框
  image,

  /// 状态展示对话框
  status,
}

/// NZDialog 是一个多功能的对话框组件，支持 10 种以上不同的样式。
class NZDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? content;
  final List<NZDialogAction>? actions;
  final NZDialogType type;
  final IconData? icon;
  final Color? iconColor;
  final double? progressValue;
  final String? imagePath;
  final bool barrierDismissible;
  final Widget? footer;

  const NZDialog({
    super.key,
    this.title,
    this.message,
    this.content,
    this.actions,
    this.type = NZDialogType.basic,
    this.icon,
    this.iconColor,
    this.progressValue,
    this.imagePath,
    this.barrierDismissible = true,
    this.footer,
  });

  /// 快速显示对话框
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? message,
    Widget? content,
    List<NZDialogAction>? actions,
    NZDialogType type = NZDialogType.basic,
    IconData? icon,
    Color? iconColor,
    double? progress,
    String? imagePath,
    bool barrierDismissible = true,
    Widget? footer,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => NZDialog(
        title: title,
        message: message,
        content: content,
        actions: actions,
        type: type,
        icon: icon,
        iconColor: iconColor,
        progressValue: progress,
        imagePath: imagePath,
        barrierDismissible: barrierDismissible,
        footer: footer,
      ),
    );
  }

  static Future<void> alert(
    BuildContext context,
    String message, {
    String title = '提示',
  }) {
    return show(
      context,
      type: NZDialogType.basic,
      title: title,
      message: message,
      actions: [
        NZDialogAction(
          label: '我知道了',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  /// 2. 确认对话框
  static Future<bool?> confirm(
    BuildContext context,
    String message, {
    String title = '确认操作',
    String confirmLabel = '确定',
    String cancelLabel = '取消',
  }) {
    return show<bool>(
      context,
      type: NZDialogType.confirm,
      title: title,
      message: message,
      actions: [
        NZDialogAction(
          label: cancelLabel,
          onPressed: () => Navigator.pop(context, false),
        ),
        NZDialogAction(
          label: confirmLabel,
          isPrimary: true,
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }

  /// 3. 成功对话框
  static Future<void> success(
    BuildContext context,
    String message, {
    String title = '成功',
  }) {
    return show(
      context,
      type: NZDialogType.success,
      title: title,
      message: message,
      icon: Icons.check_circle_rounded,
      iconColor: Colors.green,
      actions: [
        NZDialogAction(
          label: '确定',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  static Future<void> error(
    BuildContext context,
    String message, {
    String title = '出错了',
  }) {
    return show(
      context,
      type: NZDialogType.error,
      title: title,
      message: message,
      icon: Icons.error_rounded,
      iconColor: Colors.red,
      actions: [
        NZDialogAction(
          label: '返回',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  ///  警告对话框
  static Future<void> warning(
    BuildContext context,
    String message, {
    String title = '安全警告',
  }) {
    return show(
      context,
      type: NZDialogType.warning,
      title: title,
      message: message,
      icon: Icons.warning_rounded,
      iconColor: Colors.orange,
      actions: [
        NZDialogAction(
          label: '理解并继续',
          isDestructive: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  /// 信息对话框
  static Future<void> info(
    BuildContext context,
    String message, {
    String title = '详情',
  }) {
    return show(
      context,
      type: NZDialogType.info,
      title: title,
      message: message,
      icon: Icons.info_rounded,
      iconColor: Colors.blue,
      actions: [
        NZDialogAction(label: '关闭', onPressed: () => Navigator.pop(context)),
      ],
    );
  }

  /// 7. 输入对话框
  static Future<String?> input(
    BuildContext context, {
    String title = '输入内容',
    String? hintText,
    String confirmLabel = '提交',
    String? initialValue,
  }) {
    final controller = TextEditingController(text: initialValue);
    return show<String>(
      context,
      type: NZDialogType.input,
      title: title,
      content: TextField(
        controller: controller,
        autofocus: true,
        style: TextStyle(
          fontSize: 15,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        onSubmitted: (value) => Navigator.pop(context, value),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.03),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: NZColor.nezhaPrimary, width: 1.5),
          ),
        ),
      ),
      actions: [
        NZDialogAction(label: '取消', onPressed: () => Navigator.pop(context)),
        NZDialogAction(
          label: confirmLabel,
          isPrimary: true,
          onPressed: () => Navigator.pop(context, controller.text),
        ),
      ],
    );
  }

  static Future<void> loading(
    BuildContext context, {
    String message = '加载中...',
  }) {
    return show(
      context,
      type: NZDialogType.loading,
      message: message,
      barrierDismissible: false,
    );
  }

  ///  进度对话框
  static Future<void> progress(
    BuildContext context,
    double value, {
    String title = '正在同步数据',
  }) {
    return show(
      context,
      type: NZDialogType.progress,
      title: title,
      progress: value,
      barrierDismissible: false,
      actions: [
        NZDialogAction(label: '后台运行', onPressed: () => Navigator.pop(context)),
      ],
    );
  }

  static Future<void> image(
    BuildContext context,
    String imageUrl, {
    String? title,
    String? message,
  }) {
    return show(
      context,
      type: NZDialogType.image,
      title: title,
      message: message,
      imagePath: imageUrl,
      actions: [
        NZDialogAction(
          label: '关闭',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  /// 11. 状态展示对话框
  static Future<void> status(
    BuildContext context, {
    required String title,
    required String message,
    required Widget statusWidget,
  }) {
    return show(
      context,
      type: NZDialogType.status,
      title: title,
      message: message,
      content: statusWidget,
      actions: [
        NZDialogAction(
          label: '确定',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (type == NZDialogType.image && imagePath != null)
                  Image.network(
                    imagePath!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 200,
                        color: isDark ? Colors.grey[850] : Colors.grey[100],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: isDark ? Colors.grey[850] : Colors.grey[100],
                        child: Icon(
                          Icons.broken_image_outlined,
                          size: 48,
                          color: isDark ? Colors.white24 : Colors.black12,
                        ),
                      );
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          size: 48,
                          color: iconColor ?? NZColor.nezhaPrimary,
                        ),
                        const SizedBox(height: 16),
                      ],
                      if (type == NZDialogType.loading) ...[
                        const CircularProgressIndicator(strokeWidth: 3),
                        const SizedBox(height: 20),
                      ],
                      if (title != null) ...[
                        Text(
                          title!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      if (message != null)
                        Text(
                          message!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: isDark ? Colors.white70 : Colors.black54,
                            height: 1.5,
                          ),
                        ),
                      if (content != null) ...[
                        const SizedBox(height: 16),
                        content!,
                      ],
                      if (type == NZDialogType.progress &&
                          progressValue != null) ...[
                        const SizedBox(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progressValue,
                            backgroundColor: (iconColor ?? NZColor.nezhaPrimary)
                                .withValues(alpha: 0.1),
                            valueColor: AlwaysStoppedAnimation(
                              iconColor ?? NZColor.nezhaPrimary,
                            ),
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(progressValue! * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (actions != null && actions!.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.05)
                              : Colors.black.withValues(alpha: 0.05),
                        ),
                      ),
                    ),
                    child: actions!.length <= 2
                        ? IntrinsicHeight(
                            child: Row(
                              children: List.generate(actions!.length, (index) {
                                final action = actions![index];
                                return Expanded(
                                  child: Row(
                                    children: [
                                      if (index > 0)
                                        VerticalDivider(
                                          width: 1,
                                          thickness: 1,
                                          color: isDark
                                              ? Colors.white.withValues(
                                                  alpha: 0.05,
                                                )
                                              : Colors.black.withValues(
                                                  alpha: 0.05,
                                                ),
                                        ),
                                      Expanded(
                                        child: _buildActionButton(
                                          context,
                                          action,
                                          isDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: actions!.map((action) {
                              final isLast = action == actions!.last;
                              return Container(
                                decoration: BoxDecoration(
                                  border: isLast
                                      ? null
                                      : Border(
                                          bottom: BorderSide(
                                            color: isDark
                                                ? Colors.white.withValues(
                                                    alpha: 0.05,
                                                  )
                                                : Colors.black.withValues(
                                                    alpha: 0.05,
                                                  ),
                                          ),
                                        ),
                                ),
                                child: _buildActionButton(
                                  context,
                                  action,
                                  isDark,
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                if (footer != null) footer!,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    NZDialogAction action,
    bool isDark,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action.onPressed ?? () => Navigator.pop(context),
        highlightColor: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.02),
        splashColor: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.black.withValues(alpha: 0.05),
        child: Container(
          height: 54,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            action.label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: action.isPrimary ? FontWeight.w700 : FontWeight.w500,
              color:
                  action.color ??
                  (action.isDestructive
                      ? Colors.redAccent
                      : (action.isPrimary
                            ? NZColor.nezhaPrimary
                            : (isDark ? Colors.white70 : Colors.black87))),
            ),
          ),
        ),
      ),
    );
  }
}
