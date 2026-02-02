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

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF111111)
            : const Color(0xFFFAFAFA),
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
                githubUrl: githubUrl,
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

class _Navbar extends StatelessWidget {
  final bool isDark;
  final String selectedId;
  final Function(String) onSectionSelected;
  final int themeModeIndex;
  final Function(int) onThemeModeChanged;
  final String? githubUrl;

  const _Navbar({
    required this.isDark,
    required this.selectedId,
    required this.onSectionSelected,
    required this.themeModeIndex,
    required this.onThemeModeChanged,
    this.githubUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF111111).withValues(alpha: 0.7)
                : Colors.white.withValues(alpha: 0.8),
            border: Border(
              bottom: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : const Color(0xFFF0F0F0),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              _Logo(isDark: isDark, githubUrl: githubUrl),
              const SizedBox(width: 80),
              _NavLink(
                title: '组件库',
                isSelected: selectedId != 'Home' && selectedId != 'About',
                isDark: isDark,
                onTap: () => onSectionSelected('Text'),
              ),
              _NavLink(
                title: '设计规范',
                isSelected: false,
                isDark: isDark,
                onTap: () {},
              ),
              _NavLink(
                title: '开发指南',
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
              const SizedBox(width: 24),
              _ActionButton(
                icon: Icons.language_rounded,
                isDark: isDark,
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _ActionButton(
                icon: Icons.search_rounded,
                isDark: isDark,
                onTap: () {},
              ),
              if (githubUrl != null) ...[
                const SizedBox(width: 8),
                _ActionButton(
                  icon: Icons.code_rounded,
                  isDark: isDark,
                  onTap: () async {
                    final url = Uri.parse(githubUrl!);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
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
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDark
                        ? NZColor.nezhaPrimary.withValues(alpha: 0.1)
                        : NZColor.nezhaPrimary.withValues(alpha: 0.05))
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  section.icon,
                  size: 18,
                  color: isSelected
                      ? NZColor.nezhaPrimary
                      : (isDark ? Colors.white38 : Colors.black38),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    section.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isSelected
                          ? NZColor.nezhaPrimary
                          : (isDark ? Colors.white70 : Colors.black87),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 120),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: NZColor.nezhaPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'v0.1.0-alpha',
                  style: TextStyle(
                    color: NZColor.nezhaPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                section.title,
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -2,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              if (section.subtitle != null) ...[
                const SizedBox(height: 24),
                Text(
                  section.subtitle!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white60 : Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
              const SizedBox(height: 64),
              NZMarkdown(data: section.content),
              const SizedBox(height: 64),
              Row(
                children: [
                  NZButton.primary(
                    label: '立即开始',
                    onPressed: onGetStarted,
                    width: 160,
                  ),
                  const SizedBox(width: 16),
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
                    width: 160,
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

class _DocContentView extends StatelessWidget {
  final NZDocSection section;
  final bool isDark;

  const _DocContentView({required this.section, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 64),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      section.title,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  if (section.github != null)
                    _ActionButton(
                      icon: Icons.code_rounded,
                      isDark: isDark,
                      onTap: () async {
                        final url = Uri.parse(section.github!);
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
              if (section.description != null) ...[
                const SizedBox(height: 16),
                Text(
                  section.description!,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white38 : Colors.black45,
                    height: 1.6,
                  ),
                ),
              ],
              const SizedBox(height: 64),
              if (section.preview != null) ...[
                const _SectionHeader(title: '组件预览'),
                const SizedBox(height: 24),
                _PreviewCard(child: section.preview!, isDark: isDark),
                const SizedBox(height: 64),
              ],
              if (section.usage != null) ...[
                const _SectionHeader(title: '参数说明'),
                const SizedBox(height: 24),
                _UsageTable(usage: section.usage!, isDark: isDark),
                const SizedBox(height: 64),
              ],
              if (section.code != null) ...[
                const _SectionHeader(title: '代码实现'),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
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
  const _PreviewCard({required this.child, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(48),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : const Color(0xFFF0F0F0),
        ),
      ),
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
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
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
    );
  }
}
