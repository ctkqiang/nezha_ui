import 'package:flutter/material.dart';
import 'package:nezha_ui/theme/colors.dart';

/// NZButton 样式类型
enum NZButtonStyle {
  /// 主要按钮：有背景色，通常用于主操作
  primary,

  /// 次要按钮：浅色背景，通常用于次要操作（类似微信小程序风格）
  secondary,

  /// 描边按钮：无背景色，有边框
  outline,

  /// 文字按钮：无背景色，无边框，仅显示文字或图标
  text,
}

/// NZButton 是 NezhaUI 提供的高性能、高可定制化的按钮组件。
///
/// 支持多种样式类型，包括主要按钮、次要按钮、描边按钮和文字按钮。
/// 支持在文字前后添加图标（支持 [IconData]、[Widget] 或图片资源）。
///
/// ### 使用示例：
///
/// ```dart
/// // 基础主要按钮
/// NZButton(
///   onPressed: () => print('Tap'),
///   child: Text('提交'),
/// )
///
/// // 带图标的文字按钮
/// NZButton(
///   style: NZButtonStyle.text,
///   onPressed: () {},
///   icon: Icon(Icons.share, size: 18),
///   child: Text('分享'),
/// )
/// ```
class NZButton extends StatelessWidget {
  /// 点击回调
  final VoidCallback? onPressed;

  /// 按钮内容
  final Widget child;

  /// 按钮样式，默认为 [NZButtonStyle.primary]
  final NZButtonStyle style;

  /// 按钮宽度，如果不设置则根据内容自适应
  final double? width;

  /// 按钮高度，默认为 48.0
  final double height;

  /// 内部边距
  final EdgeInsetsGeometry padding;

  /// 圆角半径，默认为 12.0
  final double borderRadius;

  /// 按钮图标，显示在文字前面
  final Widget? icon;

  /// 图标与文字之间的间距
  final double iconGap;

  const NZButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style = NZButtonStyle.primary,
    this.width,
    this.height = 48.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0),
    this.borderRadius = 12.0,
    this.icon,
    this.iconGap = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;
    BorderSide borderSide = BorderSide.none;

    switch (style) {
      case NZButtonStyle.primary:
        backgroundColor = NZColor.nezhaPrimary;
        foregroundColor = Colors.white;
        break;
      case NZButtonStyle.secondary:
        backgroundColor = const Color(0xFFF2F2F2);
        foregroundColor = const Color(0xFF07C160);
        break;
      case NZButtonStyle.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = NZColor.nezhaPrimary;
        borderSide = const BorderSide(color: NZColor.nezhaPrimary, width: 1.0);
        break;
      case NZButtonStyle.text:
        backgroundColor = Colors.transparent;
        foregroundColor = NZColor.nezhaPrimary;
        break;
    }

    final bool isEnabled = onPressed != null;
    final Color effectiveForegroundColor = isEnabled
        ? foregroundColor
        : foregroundColor.withValues(alpha: 0.5);
    final Color effectiveBackgroundColor = isEnabled
        ? backgroundColor
        : backgroundColor.withValues(alpha: 0.5);

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          IconTheme.merge(
            data: IconThemeData(color: effectiveForegroundColor, size: 18),
            child: icon!,
          ),
          SizedBox(width: iconGap),
        ],
        DefaultTextStyle.merge(
          style: TextStyle(
            color: effectiveForegroundColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          child: child,
        ),
      ],
    );

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          splashColor: effectiveForegroundColor.withValues(alpha: 0.1),
          highlightColor: effectiveForegroundColor.withValues(alpha: 0.05),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              border: borderSide != BorderSide.none
                  ? Border.fromBorderSide(borderSide)
                  : null,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            alignment: Alignment.center,
            child: content,
          ),
        ),
      ),
    );
  }
}

/// NZProgressButton 是一个带有进度条显示功能的按钮。
///
/// 它可以显示从 0% 到 100% 的进度状态，非常适合用于下载、上传或长耗时任务。
///
/// ### 使用示例：
///
/// ```dart
/// NZProgressButton(
///   progress: _downloadProgress, // 0.0 到 1.0 之间的数值
///   onPressed: () {
///     // 开始任务
///   },
///   child: Text(_downloadProgress > 0 ? '下载中...' : '开始下载'),
/// )
/// ```
class NZProgressButton extends StatelessWidget {
  /// 当前进度，范围为 0.0 到 1.0
  final double progress;

  /// 点击回调
  final VoidCallback? onPressed;

  /// 按钮内容
  final Widget child;

  /// 进度条颜色，默认为主色调
  final Color? progressColor;

  /// 按钮背景色
  final Color? backgroundColor;

  /// 文字/图标颜色
  final Color? foregroundColor;

  /// 按钮宽度
  final double? width;

  /// 按钮高度
  final double height;

  /// 圆角半径
  final double borderRadius;

  const NZProgressButton({
    super.key,
    required this.progress,
    required this.onPressed,
    required this.child,
    this.progressColor,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height = 48.0,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveProgressColor = progressColor ?? NZColor.nezhaPrimary;
    final Color effectiveBackgroundColor =
        backgroundColor ?? const Color(0xFFF2F2F2);
    final Color effectiveForegroundColor =
        foregroundColor ?? (progress > 0.5 ? Colors.white : Colors.black87);

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // 进度条背景层
            Positioned.fill(
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(color: effectiveProgressColor),
              ),
            ),
            // 按钮交互层
            Positioned.fill(
              child: InkWell(
                onTap: onPressed,
                splashColor: effectiveForegroundColor.withValues(alpha: 0.1),
                highlightColor: effectiveForegroundColor.withValues(
                  alpha: 0.05,
                ),
                child: Center(
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      color: effectiveForegroundColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
