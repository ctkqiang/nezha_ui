import 'package:flutter/material.dart';
import 'package:nezha_ui/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

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

  /// 自定义背景颜色
  final Color? color;

  /// 自定义前景（文字和图标）颜色
  final Color? foregroundColor;

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
    this.color,
    this.foregroundColor,
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
    Color? color,
    Color? foregroundColor,
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
    color: color,
    foregroundColor: foregroundColor,
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
    Color? color,
    Color? foregroundColor,
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
    color: color,
    foregroundColor: foregroundColor,
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
    Color? color,
    Color? foregroundColor,
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
    color: color,
    foregroundColor: foregroundColor,
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
    Color? color,
    Color? foregroundColor,
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
    color: color,
    foregroundColor: foregroundColor,
    child: child,
  );

  @override
  Widget build(BuildContext context) {
    Color defaultBackgroundColor;
    Color defaultForegroundColor;
    BorderSide borderSide = BorderSide.none;

    switch (style) {
      case NZButtonStyle.primary:
        defaultBackgroundColor = NZColor.nezhaPrimary;
        defaultForegroundColor = Colors.white;
        break;
      case NZButtonStyle.secondary:
        defaultBackgroundColor = const Color(0xFFF2F2F2);
        defaultForegroundColor = const Color(0xFF07C160);
        break;
      case NZButtonStyle.outline:
        defaultBackgroundColor = Colors.transparent;
        defaultForegroundColor = NZColor.nezhaPrimary;
        borderSide = const BorderSide(color: NZColor.nezhaPrimary, width: 1.0);
        break;
      case NZButtonStyle.text:
        defaultBackgroundColor = Colors.transparent;
        defaultForegroundColor = NZColor.nezhaPrimary;
        break;
    }

    final Color effectiveBackgroundColor = color ?? defaultBackgroundColor;
    final Color effectiveForegroundColor =
        foregroundColor ?? defaultForegroundColor;

    final bool isEnabled = onPressed != null && !isLoading;
    final Color finalForegroundColor = isEnabled
        ? effectiveForegroundColor
        : effectiveForegroundColor.withValues(alpha: 0.5);
    final Color finalBackgroundColor = isEnabled
        ? effectiveBackgroundColor
        : effectiveBackgroundColor.withValues(alpha: 0.5);

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
              valueColor: AlwaysStoppedAnimation<Color>(finalForegroundColor),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          IconTheme.merge(
            data: IconThemeData(color: finalForegroundColor, size: 18),
            child: icon!,
          ),
          SizedBox(width: iconGap),
        ],
        Flexible(
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: finalForegroundColor,
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
        color: finalBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          splashColor: finalForegroundColor.withValues(alpha: 0.1),
          highlightColor: finalForegroundColor.withValues(alpha: 0.05),
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: BoxDecoration(
              border: borderSide != BorderSide.none
                  ? Border.fromBorderSide(
                      borderSide.copyWith(color: effectiveForegroundColor),
                    )
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

  /// 进度条颜色 (默认为 [NZColor.nezhaPrimary])
  final Color? color;

  /// 按钮背景颜色 (默认为 #F2F2F2)
  final Color? backgroundColor;

  /// 文本和图标颜色
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
    this.color,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height = 48.0,
    this.borderRadius = 12.0,
    this.block = false,
  }) : assert(child != null || label != null, '必须提供 child 或 label');

  @override
  Widget build(BuildContext context) {
    final Color effectiveProgressColor = color ?? NZColor.nezhaPrimary;
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

  /// 跳转链接 (如果提供，点击时将尝试打开该 URL)
  final String? url;

  /// 按钮背景颜色 (如果不提供，则显示图片本身)
  final Color? color;

  /// 文本颜色 (默认为白色)
  final Color? foregroundColor;

  const NZImageButton({
    super.key,
    required this.image,
    this.onPressed,
    this.child,
    this.label,
    this.width,
    this.height = 180.0,
    this.borderRadius = 12.0,
    this.block = false,
    this.opacity = 0.8,
    this.color,
    this.foregroundColor,
    this.url,
  });

  /// 快速创建 GitHub 按钮
  factory NZImageButton.github({
    required String githubUrl,
    double height = 48.0,
    double? width,
    String? label = 'GitHub',
  }) {
    return NZImageButton(
      image: const AssetImage('assets/example/assets/github.png'),
      url: githubUrl,
      height: height,
      width: width,
      label: label,
      opacity: 1.0,
    );
  }

  Future<void> _handleTap() async {
    if (onPressed != null) {
      onPressed!();
    }
    if (url != null) {
      final Uri uri = Uri.parse(url!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: block ? double.infinity : width,
      height: height,
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: Clip.antiAlias,
        color: color ?? Colors.transparent,
        child: InkWell(
          onTap: _handleTap,
          splashColor: (foregroundColor ?? Colors.white).withValues(alpha: 0.2),
          highlightColor: (foregroundColor ?? Colors.white).withValues(
            alpha: 0.1,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Ink.image(
                  image: image,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 1 - opacity),
                    BlendMode.darken,
                  ),
                ),
              ),
              if (child != null || label != null)
                Center(
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      color: foregroundColor ?? Colors.white,
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

class _NZDraggableButtonState extends State<NZDraggableButton>
    with SingleTickerProviderStateMixin {
  late Offset _position;
  late AnimationController _controller;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();
    _position = widget.initialPosition;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.addListener(() {
      if (_animation != null) {
        setState(() {
          _position = _animation!.value;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _snapToEdge(Size size, EdgeInsets padding) {
    final double centerX = size.width / 2;
    double targetX;
    // 自动吸附到最近的左右边缘，留出 16 像素间距
    if (_position.dx + 30 < centerX) {
      targetX = 16.0;
    } else {
      targetX = size.width - 60 - 16.0;
    }

    final double targetY = _position.dy.clamp(
      padding.top + 16,
      size.height - padding.bottom - 60 - 16,
    );

    _animation = Tween<Offset>(
      begin: _position,
      end: Offset(targetX, targetY),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return AnimatedPositioned(
      duration: _controller.isAnimating
          ? Duration.zero
          : const Duration(milliseconds: 50),
      left: _position.dx,
      top: _position.dy,
      child: Draggable(
        feedback: Material(
          color: Colors.transparent,
          child: Opacity(opacity: 0.8, child: widget.child),
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
        child: GestureDetector(
          onTap: widget.onTap,
          child: MouseRegion(
            cursor: SystemMouseCursors.grab,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
