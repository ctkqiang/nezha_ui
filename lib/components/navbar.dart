import 'package:flutter/material.dart';
import 'package:nezha_ui/nezha.dart';

/// [NZNavBar] 的展现类型
enum NZNavBarType {
  /// 标准模式：包含标题、返回按钮和操作按钮
  normal,

  /// 搜索模式：点击搜索图标可展开搜索框
  search,

  /// Logo 模式：左侧显示 Logo 和品牌名称
  logo,

  /// 小程序模式：右侧显示类似微信小程序的“胶囊”控制按钮
  miniApp,
}

/// [NZNavBar] 是一个多功能、高度可定制的顶部导航栏组件。
///
/// 它基于 Flutter 的 [AppBar] 构建，提供了四种常见的业务场景模式：
/// 1. [NZNavBarType.normal] - 标准导航栏。
/// 2. [NZNavBarType.search] - 带有动画展开搜索功能的导航栏。
/// 3. [NZNavBarType.logo] - 品牌展示导航栏。
/// 4. [NZNavBarType.miniApp] - 微信小程序风格的导航栏。
///
/// 示例用法：
/// ```dart
/// // 标准模式
/// const NZNavBar(title: '首页')
///
/// // 搜索模式
/// NZNavBar.search(
///   title: '搜索文档',
///   onSearch: () => print('开始搜索'),
/// )
/// ```
class NZNavBar extends StatefulWidget implements PreferredSizeWidget {
  /// 导航栏标题文本
  final String? title;

  /// 自定义标题组件，优先级高于 [title]
  final Widget? titleWidget;

  /// 左侧领先组件（通常为返回按钮或菜单图标）
  final Widget? leading;

  /// 右侧操作按钮列表
  final List<Widget>? actions;

  /// 标题是否居中显示
  final bool centerTitle;

  /// 阴影高度
  final double elevation;

  /// 背景颜色
  final Color? backgroundColor;

  /// 前景颜色（影响文字和图标颜色）
  final Color? foregroundColor;

  /// 导航栏类型
  final NZNavBarType type;

  /// Logo 图片的 URL 地址（仅在 [NZNavBarType.logo] 模式下有效）
  final String? logoUrl;

  /// 点击搜索按钮或提交搜索时的回调
  final VoidCallback? onSearch;

  /// 搜索框内容变化时的回调
  final ValueChanged<String>? onSearchChanged;

  /// 小程序模式下的分享按钮点击回调
  final VoidCallback? onMiniAppShare;

  /// 小程序模式下的关闭按钮点击回调
  final VoidCallback? onMiniAppClose;

  /// 创建一个标准模式的导航栏
  const NZNavBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
  }) : type = NZNavBarType.normal,
       logoUrl = null,
       onSearch = null,
       onSearchChanged = null,
       onMiniAppShare = null,
       onMiniAppClose = null;

  /// 创建一个带有搜索功能的导航栏
  const NZNavBar.search({
    super.key,
    this.title,
    required this.onSearch,
    this.onSearchChanged,
    this.leading,
    this.actions,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
  }) : type = NZNavBarType.search,
       titleWidget = null,
       centerTitle = true,
       logoUrl = null,
       onMiniAppShare = null,
       onMiniAppClose = null;

  /// 创建一个带有 Logo 展示的导航栏
  const NZNavBar.logo({
    super.key,
    required this.logoUrl,
    this.title,
    this.leading,
    this.actions,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
  }) : type = NZNavBarType.logo,
       titleWidget = null,
       centerTitle = false,
       onSearch = null,
       onSearchChanged = null,
       onMiniAppShare = null,
       onMiniAppClose = null;

  /// 创建一个小程序风格的导航栏
  const NZNavBar.miniApp({
    super.key,
    this.title,
    this.onMiniAppShare,
    this.onMiniAppClose,
    this.leading,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
  }) : type = NZNavBarType.miniApp,
       titleWidget = null,
       actions = null,
       centerTitle = true,
       logoUrl = null,
       onSearch = null,
       onSearchChanged = null;

  @override
  State<NZNavBar> createState() => _NZNavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NZNavBarState extends State<NZNavBar>
    with SingleTickerProviderStateMixin {
  /// 是否处于搜索激活状态
  bool _isSearching = false;

  /// 搜索输入框控制器
  final TextEditingController _searchController = TextEditingController();

  /// 搜索框展开动画控制器
  late AnimationController _animationController;

  /// 搜索框展开动画
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  /// 切换搜索状态并执行动画
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        _searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // 默认颜色处理：暗色模式使用深灰，亮色模式使用纯白
    final bgColor =
        widget.backgroundColor ??
        (isDark ? const Color(0xFF1A1A1A) : Colors.white);
    final fgColor =
        widget.foregroundColor ?? (isDark ? Colors.white : Colors.black87);

    return AppBar(
      title: _buildTitle(fgColor),
      leading: _buildLeading(fgColor),
      actions: _buildActions(fgColor),
      centerTitle: widget.centerTitle,
      elevation: widget.elevation,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      surfaceTintColor: Colors.transparent,
      titleSpacing: widget.type == NZNavBarType.logo ? 0 : null,
    );
  }

  /// 构建左侧领先组件
  Widget? _buildLeading(Color fgColor) {
    // 搜索状态下显示返回按钮以退出搜索
    if (_isSearching) {
      return IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: fgColor),
        onPressed: _toggleSearch,
      );
    }
    return widget.leading;
  }

  /// 根据当前模式构建标题部分
  Widget _buildTitle(Color fgColor) {
    // 处理搜索模式下的输入框展示
    if (widget.type == NZNavBarType.search && _isSearching) {
      return FadeTransition(
        opacity: _animation,
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: fgColor.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            style: TextStyle(color: fgColor, fontSize: 14),
            decoration: InputDecoration(
              hintText: '搜索内容...',
              hintStyle: TextStyle(
                color: fgColor.withValues(alpha: 0.4),
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              isDense: true,
            ),
            onChanged: widget.onSearchChanged,
            onSubmitted: (_) => widget.onSearch?.call(),
          ),
        ),
      );
    }

    // 处理 Logo 模式下的展示
    if (widget.type == NZNavBarType.logo) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.logoUrl != null)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.logoUrl!,
                  width: 32,
                  height: 32,
                  // 图片加载失败时显示默认图标
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.bolt_rounded,
                    color: NZColor.nezhaPrimary,
                    size: 24,
                  ),
                ),
              ),
            ),
          Text(
            widget.title ?? '',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: fgColor,
              letterSpacing: -0.5,
            ),
          ),
        ],
      );
    }

    // 默认返回标题文本或自定义标题组件
    return widget.titleWidget ??
        Text(
          widget.title ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: fgColor,
            letterSpacing: -0.5,
          ),
        );
  }

  /// 构建右侧操作按钮
  List<Widget>? _buildActions(Color fgColor) {
    // 搜索状态下显示搜索确认按钮
    if (_isSearching) {
      return [
        IconButton(
          icon: Icon(Icons.search_rounded, color: fgColor),
          onPressed: () => widget.onSearch?.call(),
        ),
      ];
    }

    // 搜索模式下显示搜索切换按钮
    if (widget.type == NZNavBarType.search) {
      return [
        IconButton(
          icon: Icon(Icons.search_rounded, color: fgColor),
          onPressed: _toggleSearch,
        ),
        if (widget.actions != null) ...widget.actions!,
      ];
    }

    // 处理小程序胶囊样式
    if (widget.type == NZNavBarType.miniApp) {
      return [
        Container(
          margin: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: fgColor.withValues(alpha: 0.1)),
            borderRadius: BorderRadius.circular(100),
            color: fgColor.withValues(alpha: 0.02),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.more_horiz_rounded, size: 20, color: fgColor),
                onPressed: widget.onMiniAppShare,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                constraints: const BoxConstraints(),
              ),
              Container(
                width: 1,
                height: 16,
                color: fgColor.withValues(alpha: 0.1),
              ),
              IconButton(
                icon: Icon(
                  Icons.radio_button_checked_rounded,
                  size: 20,
                  color: fgColor,
                ),
                onPressed: widget.onMiniAppClose,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ];
    }

    return widget.actions;
  }
}
