import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nezha_ui/nezha.dart';
import 'docs_data.dart';

class NZDocsSite extends StatefulWidget {
  const NZDocsSite({super.key});

  @override
  State<NZDocsSite> createState() => _NZDocsSiteState();
}

class _NZDocsSiteState extends State<NZDocsSite> {
  int _themeModeIndex = 0; // 0: 自动, 1: 浅色, 2: 深色
  String _selectedSectionId = 'Home';

  @override
  Widget build(BuildContext context) {
    final isDark = _calculateIsDark(context);
    final theme = isDark ? NZTheme.darkTheme : NZTheme.lightTheme;
    final sections = NZDocContent.getSections(context);
    final currentSection = sections.firstWhere(
      (s) => s.id == _selectedSectionId,
    );

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF181818)
            : const Color(0xFFF3F3F3),
        body: SelectionArea(
          child: Column(
            children: [
              _Navbar(
                isDark: isDark,
                selectedId: _selectedSectionId,
                onSectionSelected: (id) =>
                    setState(() => _selectedSectionId = id),
                themeModeIndex: _themeModeIndex,
                onThemeModeChanged: (idx) =>
                    setState(() => _themeModeIndex = idx),
              ),
              Expanded(
                child: Row(
                  children: [
                    _Sidebar(
                      isDark: isDark,
                      sections: sections,
                      selectedId: _selectedSectionId,
                      onSectionSelected: (id) =>
                          setState(() => _selectedSectionId = id),
                    ),
                    Expanded(
                      child: Container(
                        color: isDark ? const Color(0xFF181818) : Colors.white,
                        child: currentSection.isLanding
                            ? _LandingPage(
                                section: currentSection,
                                isDark: isDark,
                              )
                            : _DocContentView(
                                section: currentSection,
                                isDark: isDark,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 计算当前是否应该使用深色模式
  bool _calculateIsDark(BuildContext context) {
    if (_themeModeIndex == 0) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeModeIndex == 2;
  }
}

/// 顶部导航栏组件 - TDesign 风格：高通透度与细腻边框
class _Navbar extends StatelessWidget {
  final bool isDark;
  final String selectedId;
  final Function(String) onSectionSelected;
  final int themeModeIndex;
  final Function(int) onThemeModeChanged;

  const _Navbar({
    required this.isDark,
    required this.selectedId,
    required this.onSectionSelected,
    required this.themeModeIndex,
    required this.onThemeModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF1A1A1A).withValues(alpha: 0.8)
                : Colors.white.withValues(alpha: 0.8),
            border: Border(
              bottom: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : const Color(0xFFE7E7E7),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              _Logo(),
              const SizedBox(width: 48),
              _NavLink(
                title: '组件',
                isSelected: selectedId != 'Home' && selectedId != 'About',
                isDark: isDark,
                onTap: () => onSectionSelected('Button'),
              ),
              _NavLink(
                title: '资源',
                isSelected: false,
                isDark: isDark,
                onTap: () {},
              ),
              const Spacer(),
              _ThemeToggle(
                isDark: isDark,
                currentIndex: themeModeIndex,
                onChanged: onThemeModeChanged,
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  Icons.language_rounded,
                  size: 20,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 品牌 Logo 组件
class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: NZColor.nezhaPrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.bolt_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'NezhaUI',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: -0.5,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 导航链接项组件 - TDesign 风格：底部激活条
class _NavLink extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _NavLink({
    required this.title,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? NZColor.nezhaPrimary
                    : (isDark
                          ? Colors.white.withValues(alpha: 0.9)
                          : const Color(0xFF000000).withValues(alpha: 0.9)),
              ),
            ),
            if (isSelected)
              Positioned(
                bottom: 0,
                child: Container(
                  width: 24,
                  height: 3,
                  decoration: BoxDecoration(
                    color: NZColor.nezhaPrimary,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(3),
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

/// 主题切换开关组件 - TDesign 风格：胶囊式切换
class _ThemeToggle extends StatelessWidget {
  final bool isDark;
  final int currentIndex;
  final Function(int) onChanged;

  const _ThemeToggle({
    required this.isDark,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(2),
      child: Row(
        children: List.generate(3, (index) {
          final isSelected = currentIndex == index;
          final icons = [
            Icons.brightness_auto_rounded,
            Icons.light_mode_rounded,
            Icons.dark_mode_rounded,
          ];
          return GestureDetector(
            onTap: () => onChanged(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark ? const Color(0xFF2C2C2C) : Colors.white)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                boxShadow: isSelected && !isDark
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icons[index],
                size: 14,
                color: isSelected
                    ? NZColor.nezhaPrimary
                    : (isDark ? Colors.white38 : Colors.black38),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// 侧边栏导航组件 - TDesign 风格：层级清晰
class _Sidebar extends StatelessWidget {
  final bool isDark;
  final List<NZDocSection> sections;
  final String selectedId;
  final Function(String) onSectionSelected;

  const _Sidebar({
    required this.isDark,
    required this.sections,
    required this.selectedId,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF3F3F3),
        border: Border(
          right: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : const Color(0xFFE7E7E7),
          ),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        children: [
          _SidebarGroupTitle(title: '基础组件', isDark: isDark),
          ...sections
              .where((s) => !s.isLanding)
              .map(
                (s) => _SidebarItem(
                  section: s,
                  isSelected: selectedId == s.id,
                  isDark: isDark,
                  onTap: () => onSectionSelected(s.id),
                ),
              ),
        ],
      ),
    );
  }
}

class _SidebarGroupTitle extends StatelessWidget {
  final String title;
  final bool isDark;
  const _SidebarGroupTitle({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8, top: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: isDark ? Colors.white38 : Colors.black38,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

/// 侧边栏菜单项组件 - TDesign 风格：高亮块与左侧指示条
class _SidebarItem extends StatelessWidget {
  final NZDocSection section;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.section,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          hoverColor: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.03),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDark
                        ? NZColor.nezhaPrimary.withValues(alpha: 0.15)
                        : Colors.white)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              boxShadow: isSelected && !isDark
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  section.icon,
                  size: 16,
                  color: isSelected
                      ? NZColor.nezhaPrimary
                      : (isDark ? Colors.white54 : Colors.black54),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    section.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected
                          ? NZColor.nezhaPrimary
                          : (isDark
                                ? Colors.white.withValues(alpha: 0.8)
                                : Colors.black.withValues(alpha: 0.8)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 落地页/展示页组件
class _LandingPage extends StatelessWidget {
  final NZDocSection section;
  final bool isDark;

  const _LandingPage({required this.section, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(80),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: NZColor.nezhaPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'V0.1.0 Alpha',
                  style: TextStyle(
                    color: NZColor.nezhaPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              NZText.h1(
                section.title,
                color: isDark ? Colors.white : Colors.black,
              ),
              if (section.subtitle != null) ...[
                const SizedBox(height: 16),
                Text(
                  section.subtitle!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: isDark ? Colors.white70 : Colors.black54,
                    height: 1.5,
                  ),
                ),
              ],
              const SizedBox(height: 64),
              NZMarkdown(data: section.content),
              const SizedBox(height: 64),
              Row(
                children: [
                  NZButton(label: '开始使用', onPressed: () {}),
                  const SizedBox(width: 16),
                  NZButton.outline(
                    label: 'GitHub',
                    onPressed: () {},
                    icon: const Icon(Icons.code_rounded, size: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 组件文档内容视图组件 - TDesign 风格：规范化的区块
class _DocContentView extends StatelessWidget {
  final NZDocSection section;
  final bool isDark;

  const _DocContentView({required this.section, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 48),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section.title,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              if (section.description != null) ...[
                const SizedBox(height: 12),
                Text(
                  section.description!,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white38 : Colors.black45,
                    height: 1.6,
                  ),
                ),
              ],
              const SizedBox(height: 48),
              if (section.preview != null) ...[
                const _SubHeader(title: '组件预览'),
                const SizedBox(height: 24),
                _PreviewContainer(child: section.preview!, isDark: isDark),
                const SizedBox(height: 48),
              ],
              if (section.code != null) ...[
                const _SubHeader(title: '示例代码'),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: NZCodeView(
                    code: section.code!,
                    theme: isDark
                        ? NZCodeTheme.githubDark
                        : NZCodeTheme.githubLight,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// 小标题组件 - TDesign 风格：带左侧装饰线
class _SubHeader extends StatelessWidget {
  final String title;
  const _SubHeader({required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: NZColor.nezhaPrimary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

/// 预览区域容器组件 - TDesign 风格：卡片化展示
class _PreviewContainer extends StatelessWidget {
  final Widget child;
  final bool isDark;
  const _PreviewContainer({required this.child, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF242424) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : const Color(0xFFE7E7E7),
        ),
        boxShadow: !isDark
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : const Color(0xFFF3F3F3),
                ),
              ),
            ),
            child: Row(
              children: [
                _Dot(color: Colors.red.withValues(alpha: 0.5)),
                const SizedBox(width: 6),
                _Dot(color: Colors.orange.withValues(alpha: 0.5)),
                const SizedBox(width: 6),
                _Dot(color: Colors.green.withValues(alpha: 0.5)),
                const Spacer(),
                Icon(
                  Icons.copy_rounded,
                  size: 14,
                  color: isDark ? Colors.white24 : Colors.black26,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
