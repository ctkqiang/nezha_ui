import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nezha_ui/nezha.dart';
import 'docs_data.dart';

class NZDocsSite extends StatefulWidget {
  const NZDocsSite({super.key});

  @override
  State<NZDocsSite> createState() => _NZDocsSiteState();
}

class _NZDocsSiteState extends State<NZDocsSite> {
  int _themeModeIndex = 0;
  String _selectedSectionId = 'Home';

  @override
  Widget build(BuildContext context) {
    final isDark = _calculateIsDark(context);
    final theme = isDark ? NZTheme.darkTheme : NZTheme.lightTheme;
    final sections = NZDocContent.getSections(context);
    final currentSection = sections.firstWhere(
      (s) => s.id == _selectedSectionId,
    );
    final githubUrl = sections.firstWhere((s) => s.id == 'Home').github;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Theme(
      data: theme,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: isDark
            ? const Color(0xFF111111)
            : const Color(0xFFFAFAFA),
        drawer: MediaQuery.of(context).size.width < 900
            ? NZDrawer(
                position: NZDrawerPosition.left,
                child: _Sidebar(
                  isDark: isDark,
                  sections: sections,
                  selectedId: _selectedSectionId,
                  onSectionSelected: (id) {
                    setState(() => _selectedSectionId = id);
                    Navigator.pop(context);
                  },
                ),
              )
            : null,
        floatingActionButton: NZFloatingActionButton(
          onPressed: () {},
          backgroundColor: NZColor.nezhaPrimary,
          type: NZFloatingActionButtonType.icon,
          icon: const Icon(Icons.feedback_rounded, color: Colors.white),
        ),
        body: SelectionArea(
          child: Column(
            children: [
              NZNavBar.logo(
                title: 'NezhaUI',
                logoUrl:
                    'https://raw.githubusercontent.com/ctkqiang/nezha_ui/master/docs/assets/banner.png',
                backgroundColor: isDark
                    ? const Color(0xFF111111).withValues(alpha: 0.7)
                    : Colors.white.withValues(alpha: 0.8),
                foregroundColor: isDark ? Colors.white : Colors.black,
                actions: [
                  if (MediaQuery.of(context).size.width >= 900) ...[
                    _NavLink(
                      title: '组件库',
                      isSelected:
                          _selectedSectionId != 'Home' &&
                          _selectedSectionId != 'About',
                      isDark: isDark,
                      onTap: () => setState(() => _selectedSectionId = 'Text'),
                    ),
                    _NavLink(
                      title: '设计规范',
                      isSelected: false,
                      isDark: isDark,
                      onTap: () {
                        NZToast.show(context, message: '设计规范建设中...');
                      },
                    ),
                  ],
                  // 搜索按钮
                  IconButton(
                    icon: const Icon(Icons.search_rounded),
                    tooltip: '搜索文档',
                    onPressed: () {
                      NZToast.show(context, message: '搜索功能开发中...');
                    },
                  ),
                  _ThemeToggle(
                    isDark: isDark,
                    currentIndex: _themeModeIndex,
                    onChanged: (idx) => setState(() => _themeModeIndex = idx),
                  ),
                  const SizedBox(width: 8),
                  if (githubUrl != null)
                    IconButton(
                      icon: const Icon(Icons.code_rounded),
                      tooltip: 'GitHub 仓库',
                      onPressed: () async {
                        final url = Uri.parse(githubUrl);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                    ),
                  const SizedBox(width: 12),
                ],
                leading: MediaQuery.of(context).size.width < 900
                    ? IconButton(
                        icon: const Icon(Icons.menu_rounded),
                        onPressed: () => scaffoldKey.currentState?.openDrawer(),
                      )
                    : null,
              ),
              Expanded(
                child: Row(
                  children: [
                    if (MediaQuery.of(context).size.width >= 900)
                      _Sidebar(
                        isDark: isDark,
                        sections: sections,
                        selectedId: _selectedSectionId,
                        onSectionSelected: (id) =>
                            setState(() => _selectedSectionId = id),
                      ),
                    if (MediaQuery.of(context).size.width >= 900)
                      Container(
                        width: 1,
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : const Color(0xFFF0F0F0),
                      ),
                    Expanded(
                      child: Container(
                        color: isDark ? const Color(0xFF111111) : Colors.white,
                        child: currentSection.isLanding
                            ? _LandingPage(
                                section: currentSection,
                                isDark: isDark,
                                onGetStarted: () =>
                                    setState(() => _selectedSectionId = 'Text'),
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

  bool _calculateIsDark(BuildContext context) {
    if (_themeModeIndex == 0) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeModeIndex == 2;
  }
}

class _Logo extends StatelessWidget {
  final bool isDark;
  final String? githubUrl;
  const _Logo({required this.isDark, this.githubUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (githubUrl != null) {
          final url = Uri.parse(githubUrl!);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    NZColor.nezhaPrimary,
                    NZColor.nezhaPrimary.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: NZColor.nezhaPrimary.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.bolt_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Text(
              'NezhaUI',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22,
                letterSpacing: -1.0,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
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
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: widget.isSelected || _isHovered
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: widget.isSelected
                      ? NZColor.nezhaPrimary
                      : (widget.isDark
                            ? (_isHovered ? Colors.white : Colors.white60)
                            : (_isHovered ? Colors.black : Colors.black54)),
                ),
                child: Text(widget.title),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                bottom: widget.isSelected ? 20 : 16,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: widget.isSelected ? 1 : 0,
                  child: Container(
                    width: 24,
                    height: 3,
                    decoration: BoxDecoration(
                      color: NZColor.nezhaPrimary,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: NZColor.nezhaPrimary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final bool isDark;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _isHovered
                ? (widget.isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.04))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            widget.icon,
            size: 20,
            color: widget.isDark
                ? (_isHovered ? Colors.white : Colors.white60)
                : (_isHovered ? Colors.black : Colors.black54),
          ),
        ),
      ),
    );
  }
}

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
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          final isSelected = currentIndex == index;
          final icons = [
            Icons.brightness_auto_rounded,
            Icons.light_mode_rounded,
            Icons.dark_mode_rounded,
          ];
          return GestureDetector(
            onTap: () => onChanged(index),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark ? const Color(0xFF333333) : Colors.white)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: isDark ? 0.2 : 0.06,
                            ),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  icons[index],
                  size: 16,
                  color: isSelected
                      ? NZColor.nezhaPrimary
                      : (isDark ? Colors.white38 : Colors.black38),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

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
      width: 280,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111111) : const Color(0xFFFAFAFA),
        border: Border(
          right: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : const Color(0xFFF0F0F0),
          ),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        children: [
          _SidebarHeader(title: '开始使用', isDark: isDark),
          ...sections
              .where((s) => s.isLanding)
              .map(
                (s) => _SidebarItem(
                  section: s,
                  isSelected: selectedId == s.id,
                  isDark: isDark,
                  onTap: () => onSectionSelected(s.id),
                ),
              ),
          const SizedBox(height: 32),
          _SidebarHeader(title: '组件列表', isDark: isDark),
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

class _SidebarHeader extends StatelessWidget {
  final String title;
  final bool isDark;
  const _SidebarHeader({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white24 : Colors.black26,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

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
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDark
                        ? NZColor.nezhaPrimary.withValues(alpha: 0.15)
                        : NZColor.nezhaPrimary.withValues(alpha: 0.08))
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(
                      color: NZColor.nezhaPrimary.withValues(alpha: 0.1),
                    )
                  : null,
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? NZColor.nezhaPrimary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    section.icon,
                    size: 18,
                    color: isSelected
                        ? NZColor.nezhaPrimary
                        : (isDark ? Colors.white24 : Colors.black26),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    section.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? NZColor.nezhaPrimary
                          : (isDark ? Colors.white70 : Colors.black87),
                      letterSpacing: isSelected ? 0.2 : 0,
                    ),
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: NZColor.nezhaPrimary,
                      shape: BoxShape.circle,
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

class _LandingPage extends StatelessWidget {
  final NZDocSection section;
  final bool isDark;
  final VoidCallback onGetStarted;

  const _LandingPage({
    required this.section,
    required this.isDark,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 120,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Version Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: NZColor.nezhaPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: NZColor.nezhaPrimary.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: NZColor.nezhaPrimary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    NZText.caption(
                      'v1.0.0 Stable',
                      color: NZColor.nezhaPrimary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Hero Title
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    isDark ? Colors.white : Colors.black,
                    isDark
                        ? Colors.white.withValues(alpha: 0.6)
                        : Colors.black.withValues(alpha: 0.5),
                  ],
                ).createShader(bounds),
                child: NZText.h1(
                  section.title,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 32),

              // Subtitle
              if (section.subtitle != null)
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: NZText.subtitle(
                    section.subtitle!,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),

              const SizedBox(height: 60),

              // CTA Buttons
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  NZButton.primary(
                    label: '立即开始',
                    onPressed: onGetStarted,
                    icon: const Icon(Icons.rocket_launch_rounded),
                    block: isMobile,
                  ),
                  NZButton.outline(
                    label: 'GitHub 仓库',
                    onPressed: () async {
                      if (section.github != null) {
                        final url = Uri.parse(section.github!);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.code_rounded),
                    block: isMobile,
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 60 : 100),

              // Features Grid
              const NZDivider(height: 1),
              SizedBox(height: isMobile ? 60 : 80),
              NZText.h2('核心优势'),
              const SizedBox(height: 48),
              _buildFeatureGrid(context),
              SizedBox(height: isMobile ? 60 : 100),

              // Markdown Content
              NZMarkdown(data: section.content),
              SizedBox(height: isMobile ? 60 : 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final features = [
      ('性能卓越', '基于原生渲染，确保丝滑流畅的交互体验。', Icons.bolt_rounded),
      ('主题定制', '强大的主题系统，支持深浅模式一键切换。', Icons.palette_rounded),
      ('开箱即用', '丰富的组件库，满足各种业务开发需求。', Icons.auto_awesome_rounded),
      ('文档详尽', '完善的 API 文档和代码示例。', Icons.menu_book_rounded),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 2,
        crossAxisSpacing: 32,
        mainAxisSpacing: 32,
        childAspectRatio: isMobile ? 2.8 : 2.5,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final f = features[index];
        return Container(
          padding: EdgeInsets.all(isMobile ? 20 : 32),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : const Color(0xFFF0F0F0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
                blurRadius: 40,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: NZColor.nezhaPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(f.$3, color: NZColor.nezhaPrimary, size: 28),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NZText.label(
                      f.$1,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    const SizedBox(height: 6),
                    NZText.caption(
                      f.$2,
                      color: isDark ? Colors.white38 : Colors.black45,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DocContentView extends StatefulWidget {
  final NZDocSection section;
  final bool isDark;

  const _DocContentView({required this.section, required this.isDark});

  @override
  State<_DocContentView> createState() => _DocContentViewState();
}

class _DocContentViewState extends State<_DocContentView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Stack(
      children: [
        NZPullToRefresh(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 80,
              vertical: isMobile ? 32 : 64,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Description
                    if (isMobile)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: NZText.h1(
                                  widget.section.title,
                                  color: widget.isDark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              if (widget.section.github != null)
                                IconButton(
                                  icon: const Icon(Icons.code_rounded),
                                  onPressed: () async {
                                    final url = Uri.parse(
                                      widget.section.github!,
                                    );
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(
                                        url,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    }
                                  },
                                ),
                            ],
                          ),
                          if (widget.section.description != null) ...[
                            const SizedBox(height: 16),
                            NZText.body(
                              widget.section.description!,
                              color: widget.isDark
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                          ],
                        ],
                      )
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NZText.h1(
                                  widget.section.title,
                                  color: widget.isDark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                if (widget.section.description != null) ...[
                                  const SizedBox(height: 16),
                                  NZText.body(
                                    widget.section.description!,
                                    color: widget.isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (widget.section.github != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: IconButton(
                                icon: const Icon(Icons.code_rounded),
                                onPressed: () async {
                                  final url = Uri.parse(widget.section.github!);
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                              ),
                            ),
                        ],
                      ),

                    SizedBox(height: isMobile ? 40 : 80),

                    // Preview Section
                    if (widget.section.preview != null) ...[
                      const _SectionHeader(title: '组件预览'),
                      const SizedBox(height: 32),
                      _PreviewCard(
                        child: widget.section.preview!,
                        isDark: widget.isDark,
                        isMobile: isMobile,
                      ),
                      SizedBox(height: isMobile ? 40 : 80),
                    ],

                    // Usage/API Table
                    if (widget.section.usage != null) ...[
                      const _SectionHeader(title: '参数说明'),
                      const SizedBox(height: 32),
                      _UsageTable(
                        usage: widget.section.usage!,
                        isDark: widget.isDark,
                      ),
                      SizedBox(height: isMobile ? 40 : 80),
                    ],

                    // Code View
                    if (widget.section.code != null) ...[
                      const _SectionHeader(title: '代码实现'),
                      const SizedBox(height: 32),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: widget.isDark ? 0.3 : 0.05,
                              ),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: NZCodeView(
                            code: widget.section.code!,
                            theme: widget.isDark
                                ? NZCodeTheme.githubDark
                                : NZCodeTheme.githubLight,
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 60 : 100),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: isMobile ? 20 : 40,
          bottom: isMobile ? 20 : 40,
          child: NZBackToTop(
            scrollController: _scrollController,
            child: const Icon(Icons.arrow_upward_rounded, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: NZColor.nezhaPrimary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

class _PreviewCard extends StatelessWidget {
  final Widget child;
  final bool isDark;
  final bool isMobile;
  const _PreviewCard({
    required this.child,
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : const Color(0xFFF0F0F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}

class _UsageTable extends StatelessWidget {
  final List<List<String>> usage;
  final bool isDark;

  const _UsageTable({required this.usage, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : const Color(0xFFF0F0F0),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 600),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1.2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(2.5),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.02)
                        : const Color(0xFFF9F9F9),
                  ),
                  children: ['Property', 'Type', 'Description']
                      .map(
                        (h) => Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            h,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                ...usage.map(
                  (row) => TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.05)
                              : const Color(0xFFF0F0F0),
                        ),
                      ),
                    ),
                    children: row
                        .map(
                          (cell) => Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              cell,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: cell == row[1] ? 'monospace' : null,
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          ),
                        )
                        .toList(),
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
