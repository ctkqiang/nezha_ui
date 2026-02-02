import 'package:flutter/material.dart';
import 'package:nezha_ui/theme/colors.dart';

/// NZTag 样式类型
enum NZTagStyle {
  /// 填充样式
  filled,

  /// 描边样式
  outline,

  /// 浅色填充样式 (类似微信标签)
  soft,
}

/// NZTagSize 预设大小
enum NZTagSize {
  /// 小号
  small,

  /// 中号 (默认)
  medium,

  /// 大号
  large,
}

/// NZTag 是 NezhaUI 提供的专业标签 (Chip) 组件。
///
/// 它支持多种预设样式、大小以及可选的删除/交互功能。
/// 适用于分类标签、筛选器或状态展示。
class NZTag extends StatelessWidget {
  /// 标签显示的文字
  final String label;

  /// 标签样式类型，默认为 [NZTagStyle.soft]
  final NZTagStyle style;

  /// 标签大小，默认为 [NZTagSize.medium]
  final NZTagSize size;

  /// 标签的主色调，默认为 [NZColor.nezhaPrimary]
  final Color? color;

  /// 前景颜色 (文字颜色)
  final Color? foregroundColor;

  /// 左侧图标
  final Widget? leading;

  /// 右侧图标
  final Widget? trailing;

  /// 点击标签的回调
  final VoidCallback? onTap;

  /// 点击删除图标的回调，若提供则显示删除按钮
  final VoidCallback? onDeleted;

  /// 是否为圆形圆角
  final bool round;

  /// 自定义圆角半径
  final double? borderRadius;

  const NZTag({
    super.key,
    required this.label,
    this.style = NZTagStyle.soft,
    this.size = NZTagSize.medium,
    this.color,
    this.foregroundColor,
    this.leading,
    this.trailing,
    this.onTap,
    this.onDeleted,
    this.round = false,
    this.borderRadius,
  });

  /// 快速创建主要填充标签
  factory NZTag.primary(
    String label, {
    NZTagSize size = NZTagSize.medium,
    VoidCallback? onTap,
  }) {
    return NZTag(
      label: label,
      style: NZTagStyle.filled,
      size: size,
      onTap: onTap,
    );
  }

  /// 快速创建描边标签
  factory NZTag.outline(
    String label, {
    NZTagSize size = NZTagSize.medium,
    Color? color,
    VoidCallback? onTap,
  }) {
    return NZTag(
      label: label,
      style: NZTagStyle.outline,
      size: size,
      color: color,
      onTap: onTap,
    );
  }

  /// 快速创建成功状态标签
  factory NZTag.success(String label, {NZTagSize size = NZTagSize.medium}) {
    return NZTag(
      label: label,
      color: Colors.green,
      style: NZTagStyle.soft,
      size: size,
    );
  }

  /// 快速创建警告状态标签
  factory NZTag.warning(String label, {NZTagSize size = NZTagSize.medium}) {
    return NZTag(
      label: label,
      color: Colors.orange,
      style: NZTagStyle.soft,
      size: size,
    );
  }

  /// 快速创建错误状态标签
  factory NZTag.error(String label, {NZTagSize size = NZTagSize.medium}) {
    return NZTag(
      label: label,
      color: Colors.redAccent,
      style: NZTagStyle.soft,
      size: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color themePrimary = color ?? NZColor.nezhaPrimary;

    // 计算背景和文字颜色
    Color bgColor;
    Color textColor;
    BorderSide border = BorderSide.none;

    switch (style) {
      case NZTagStyle.filled:
        bgColor = themePrimary;
        textColor = foregroundColor ?? Colors.white;
        break;
      case NZTagStyle.outline:
        bgColor = Colors.transparent;
        textColor = foregroundColor ?? themePrimary;
        border = BorderSide(color: themePrimary, width: 1);
        break;
      case NZTagStyle.soft:
        bgColor = themePrimary.withValues(alpha: isDark ? 0.15 : 0.08);
        textColor = foregroundColor ?? themePrimary;
        break;
    }

    // 计算尺寸相关的数值
    double height;
    double fontSize;
    double horizontalPadding;
    double iconSize;

    switch (size) {
      case NZTagSize.small:
        height = 24;
        fontSize = 11;
        horizontalPadding = 8;
        iconSize = 12;
        break;
      case NZTagSize.medium:
        height = 32;
        fontSize = 13;
        horizontalPadding = 12;
        iconSize = 16;
        break;
      case NZTagSize.large:
        height = 40;
        fontSize = 15;
        horizontalPadding = 16;
        iconSize = 20;
        break;
    }

    final double effectiveRadius = borderRadius ?? (round ? height / 2 : 8);

    Widget chip = Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(effectiveRadius),
        border: border != BorderSide.none
            ? Border.fromBorderSide(border)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            IconTheme.merge(
              data: IconThemeData(color: textColor, size: iconSize),
              child: leading!,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (trailing != null || onDeleted != null) ...[
            const SizedBox(width: 4),
            if (onDeleted != null)
              GestureDetector(
                onTap: onDeleted,
                child: Icon(
                  Icons.close_rounded,
                  size: iconSize,
                  color: textColor.withValues(alpha: 0.7),
                ),
              )
            else if (trailing != null)
              IconTheme.merge(
                data: IconThemeData(color: textColor, size: iconSize),
                child: trailing!,
              ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(effectiveRadius),
          child: chip,
        ),
      );
    }

    return chip;
  }
}
