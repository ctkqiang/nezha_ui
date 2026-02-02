import 'dart:async';
import 'package:flutter/material.dart';
import 'text.dart';

/// NZToast 类型枚举
enum NZToastType {
  /// 成功状态
  success,

  /// 错误状态
  error,

  /// 加载中状态
  loading,

  /// 信息提示状态
  info,

  /// 纯文本状态
  text,
}

/// NZToast 提示组件
///
/// 模仿微信小程序风格设计，提供全局的轻量级反馈。
/// 支持成功、错误、加载中、信息提示和纯文本五种模式。
class NZToast {
  static Timer? _timer;
  static OverlayEntry? _overlayEntry;

  /// 显示 Toast 提示
  ///
  /// [context] 上下文对象
  /// [message] 提示文本内容
  /// [type] 提示类型，默认为 [NZToastType.text]
  /// [duration] 显示持续时间，默认为 2 秒（loading 类型不会自动关闭）
  /// [mask] 是否显示透明遮罩，防止背景点击，默认为 false
  static void show(
    BuildContext context, {
    required String message,
    NZToastType type = NZToastType.text,
    Duration duration = const Duration(seconds: 2),
    bool mask = false,
  }) {
    // 清除之前的定时器和 Overlay
    _timer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;

    final overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) =>
          _NZToastWidget(message: message, type: type, mask: mask),
    );

    overlayState.insert(_overlayEntry!);

    // 如果不是加载中类型，则设置定时自动隐藏
    if (type != NZToastType.loading) {
      _timer = Timer(duration, () {
        hide();
      });
    }
  }

  /// 隐藏当前显示的 Toast
  static void hide() {
    _timer?.cancel();
    _timer = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  /// 显示成功提示的快捷方法
  static void success(BuildContext context, String message) =>
      show(context, message: message, type: NZToastType.success);

  /// 显示错误提示的快捷方法
  static void error(BuildContext context, String message) =>
      show(context, message: message, type: NZToastType.error);

  /// 显示加载中提示的快捷方法（默认开启遮罩，需手动调用 [hide] 关闭）
  static void loading(BuildContext context, String message) =>
      show(context, message: message, type: NZToastType.loading, mask: true);
}

/// 内部使用的 Toast 渲染组件
class _NZToastWidget extends StatelessWidget {
  final String message;
  final NZToastType type;
  final bool mask;

  const _NZToastWidget({
    required this.message,
    required this.type,
    required this.mask,
  });

  @override
  Widget build(BuildContext context) {
    // 根据当前主题亮度决定背景色
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 根据类型选择显示的图标
    Widget? icon;
    switch (type) {
      case NZToastType.success:
        icon = const Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.white,
          size: 40,
        );
        break;
      case NZToastType.error:
        icon = const Icon(
          Icons.error_outline_rounded,
          color: Colors.white,
          size: 40,
        );
        break;
      case NZToastType.loading:
        icon = const SizedBox(
          width: 36,
          height: 36,
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
        );
        break;
      case NZToastType.info:
        icon = const Icon(
          Icons.info_outline_rounded,
          color: Colors.white,
          size: 40,
        );
        break;
      case NZToastType.text:
        icon = null;
        break;
    }

    // Toast 核心内容视图
    final content = Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 120,
            maxWidth: 240,
            minHeight: 120,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            // 模仿微信的半透明深色背景
            color: (isDark ? Colors.white : Colors.black).withValues(
              alpha: 0.8,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon, const SizedBox(height: 16)],
              NZText.label(
                message,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    // 如果开启了遮罩，则包裹一层拦截点击的 Barrier
    if (mask) {
      return Stack(
        children: [
          const ModalBarrier(dismissible: false, color: Colors.transparent),
          content,
        ],
      );
    }

    return content;
  }
}
