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
/// 提供了命名构造函数（如 [NZButton.primary]）以简化代码编写，
/// 并支持 [label] 简写、加载状态 [isLoading] 和通栏布局 [block]。
class NZButton extends StatelessWidget {
  /// 点击回调
  final VoidCallback? onPressed;

  /// 按钮内容组件，优先级高于 [label]
  final Widget? child;

  /// 按钮文字简写
  final String? label;

  /// 按钮样式
  final NZButtonStyle style;

  /// 按钮宽度，设置 [block] 为 true 时失效
  final double? width;

  /// 按钮高度，默认为 48.0
  final double height;

  /// 内部边距
  final EdgeInsetsGeometry? padding;

  /// 圆角半径，默认为 12.0
  final double borderRadius;

  /// 按钮图标
  final Widget? icon;

  /// 图标与文字之间的间距
  final double iconGap;

  /// 是否处于加载状态
  final bool isLoading;

  /// 是否通栏（全宽）显示
  final bool block;

  const NZButton({
    super.key,
    required this.onPressed,
    this.child,
    this.label,
    this.style = NZButtonStyle.primary,
    this.width,
    this.height = 48.0,
    this.padding,
    this.borderRadius = 12.0,
    this.icon,
    this.iconGap = 8.0,
    this.isLoading = false,
    this.block = false,
  }) : assert(child != null || label != null, '必须提供 child 或 label');

  /// 快速创建主要按钮 (背景色为主色，文字为白色)
  factory NZButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    String? label,
    Widget? child,
    double? width,
    double height = 48.0,
    double borderRadius = 12.0,
    Widget? icon,
    double iconGap = 8.0,
    bool isLoading = false,
    bool block = false,
  }) => NZButton(
    key: key,
    onPressed: onPressed,
    label: label,
    style: NZButtonStyle.primary,
    width: width,
    height: height,
    borderRadius: borderRadius,
    icon: icon,
    iconGap: iconGap,
    isLoading: isLoading,
    block: block,
    child: child,
  );

  /// 快速创建次要按钮 (微信风格：灰色背景，绿色文字)
  factory NZButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    String? label,
    Widget? child,
    double? width,
    double height = 48.0,
    double borderRadius = 12.0,
    Widget? icon,
    double iconGap = 8.0,
    bool isLoading = false,
    bool block = false,
  }) => NZButton(
    key: key,
    onPressed: onPressed,
    label: label,
    style: NZButtonStyle.secondary,
    width: width,
    height: height,
    borderRadius: borderRadius,
    icon: icon,
    iconGap: iconGap,
    isLoading: isLoading,
    block: block,
    child: child,
  );

  /// 快速创建描边按钮 (透明背景，主色边框)
  factory NZButton.outline({
    Key? key,
    required VoidCallback? onPressed,
    String? label,
    Widget? child,
    double? width,
    double height = 48.0,
    double borderRadius = 12.0,
    Widget? icon,
    double iconGap = 8.0,
    bool isLoading = false,
    bool block = false,
  }) => NZButton(
    key: key,
    onPressed: onPressed,
    label: label,
    style: NZButtonStyle.outline,
    width: width,
    height: height,
    borderRadius: borderRadius,
    icon: icon,
    iconGap: iconGap,
    isLoading: isLoading,
    block: block,
    child: child,
  );

  /// 快速创建文字按钮 (无背景，无边框)
  factory NZButton.text({
    Key? key,
    required VoidCallback? onPressed,
    String? label,
    Widget? child,
    double? width,
    double height = 48.0,
    double borderRadius = 12.0,
    Widget? icon,
    double iconGap = 8.0,
    bool isLoading = false,
    bool block = false,
  }) => NZButton(
    key: key,
    onPressed: onPressed,
    label: label,
    style: NZButtonStyle.text,
    width: width,
    height: height,
    borderRadius: borderRadius,
    icon: icon,
    iconGap: iconGap,
    isLoading: isLoading,
    block: block,
    child: child,
  );

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

    final bool isEnabled = onPressed != null && !isLoading;
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
        if (isLoading) ...[
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                effectiveForegroundColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          IconTheme.merge(
            data: IconThemeData(color: effectiveForegroundColor, size: 18),
            child: icon!,
          ),
          SizedBox(width: iconGap),
        ],
        Flexible(
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: effectiveForegroundColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              overflow: TextOverflow.ellipsis,
            ),
            child: child ?? Text(label!),
          ),
        ),
      ],
    );

    return SizedBox(
      width: block ? double.infinity : width,
      height: height,
      child: Material(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          splashColor: effectiveForegroundColor.withValues(alpha: 0.1),
          highlightColor: effectiveForegroundColor.withValues(alpha: 0.05),
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24.0),
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
class NZProgressButton extends StatelessWidget {
  final double progress;
  final VoidCallback? onPressed;
  final Widget? child;
  final String? label;
  final Color? progressColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double height;
  final double borderRadius;
  final bool block;

  const NZProgressButton({
    super.key,
    required this.progress,
    required this.onPressed,
    this.child,
    this.label,
    this.progressColor,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height = 48.0,
    this.borderRadius = 12.0,
    this.block = false,
  }) : assert(child != null || label != null, '必须提供 child 或 label');

  @override
  Widget build(BuildContext context) {
    final Color effectiveProgressColor = progressColor ?? NZColor.nezhaPrimary;
    final Color effectiveBackgroundColor =
        backgroundColor ?? const Color(0xFFF2F2F2);
    final Color effectiveForegroundColor =
        foregroundColor ?? (progress > 0.5 ? Colors.white : Colors.black87);

    return SizedBox(
      width: block ? double.infinity : width,
      height: height,
      child: Material(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(color: effectiveProgressColor),
              ),
            ),
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
                    child: child ?? Text(label!),
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

/// NZImageButton 是一个带有背景图片的按钮。
class NZImageButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final String? label;
  final ImageProvider image;
  final double? width;
  final double height;
  final double borderRadius;
  final double opacity;
  final bool block;

  const NZImageButton({
    super.key,
    required this.onPressed,
    required this.image,
    this.child,
    this.label,
    this.width,
    this.height = 120.0,
    this.borderRadius = 16.0,
    this.opacity = 0.6,
    this.block = false,
  }) : assert(child != null || label != null, '必须提供 child 或 label');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: block ? double.infinity : width,
      height: height,
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image(
                  image: image,
                  fit: BoxFit.cover,
                  color: Colors.black.withValues(alpha: 1 - opacity),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
              Center(
                child: DefaultTextStyle.merge(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  child: child ?? Text(label!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// NZDraggableButton 是一个可以拖动的悬浮按钮。
class NZDraggableButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Offset initialPosition;

  const NZDraggableButton({
    super.key,
    required this.child,
    this.onTap,
    this.initialPosition = const Offset(20, 100),
  });

  @override
  State<NZDraggableButton> createState() => _NZDraggableButtonState();
}

class _NZDraggableButtonState extends State<NZDraggableButton> {
  late Offset _position;

  @override
  void initState() {
    super.initState();
    _position = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: Draggable(
        feedback: Material(
          color: Colors.transparent,
          child: Opacity(opacity: 0.8, child: widget.child),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) {
          setState(() {
            _position = details.offset;
          });
        },
        child: GestureDetector(onTap: widget.onTap, child: widget.child),
      ),
    );
  }
}
