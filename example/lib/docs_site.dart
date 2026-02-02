import 'package:flutter/material.dart';
import 'package:nezha_ui/nezha.dart';
import 'package:nezha_ui/components/code_view.dart';

/// [NZDocsSite] 是 NezhaUI 的官方文档站组件。
/// 它专为 Web 端设计，采用了响应式的三栏布局，包含侧边栏导航、内容展示区和实时预览区。
class NZDocsSite extends StatefulWidget {
  const NZDocsSite({super.key});

  @override
  State<NZDocsSite> createState() => _NZDocsSiteState();
}

class _NZDocsSiteState extends State<NZDocsSite> {
  int _themeModeIndex = 0; // 0: Auto, 1: Light, 2: Dark
  String _selectedSection = 'Home';

  Map<String, Map<String, dynamic>> get _sections => {
    'Home': {
      'title': 'NezhaUI',
      'subtitle': '轻量、优雅且专业的 Flutter 移动端组件库',
      'isLanding': true,
      'content': '''NezhaUI 是一套基于 Flutter 构建的移动端设计系统，致力于为现代应用开发提供丝滑、灵敏且高度可定制性。

### 核心理念
- **极致性能**：每个组件都经过细致的调优，确保在低端设备上也能保持流畅。
- **专业美学**：遵循现代设计规范，提供一致且高级的视觉体验。
- **高度定制**：深度集成 NZTheme 系统，轻松适配各种品牌风格。''',
      'github': 'https://github.com/ctkqiang/nezha_ui.git',
    },
    'About': {
      'title': '关于 NezhaUI',
      'subtitle': '轻量、优雅且专业的 Flutter 移动端组件库',
      'isLanding': true,
      'content': '''NezhaUI 不仅仅是一个组件库，它是我们对技术追求与工程实践的结合。

### 我们的愿景
让每一位开发者在编写代码时，都能感受到高效与便捷。每一个像素、每一行代码，都体现了我们对产品质量的极致追求。

### 贡献团队
- **核心团队**：负责核心架构与技术把关。
- **设计团队**：负责创意设计与视觉呈现。''',
    },
    'Text': {
      'title': 'Text 文本排版',
      'description': '高度规范化的排版组件，内置多种预设样式。',
      'usage': [
        ['data', 'String', '需要显示的文本内容'],
        ['color', 'Color?', '自定义文字颜色'],
        ['textAlign', 'TextAlign?', '对齐方式'],
        ['maxLines', 'int?', '最大行数限制'],
        ['overflow', 'TextOverflow?', '溢出处理方式'],
      ],
      'preview': Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          NZText.h1('H1 标题'),
          NZText.h2('H2 标题'),
          NZText.h3('H3 标题'),
          const SizedBox(height: 16),
          NZText.subtitle('这是一个副标题样式'),
          const SizedBox(height: 8),
          NZText.body('这是标准的正文内容，具有良好的阅读间距和行高设置。'),
          const SizedBox(height: 8),
          NZText.caption('说明文字，通常用于注脚或提示。'),
        ],
      ),
      'code': '''// 各种级别的标题
NZText.h1('大标题');
NZText.h2('中标题');

// 副标题和正文
NZText.subtitle('副标题');
NZText.body('这是一段正文内容');''',
    },
    'Drawer': {
      'title': 'Drawer 抽屉',
      'description': '灵活的抽屉组件，支持从左、上、右、下四个方向弹出。',
      'usage': [
        ['child', 'Widget', '抽屉显示的内容'],
        ['position', 'NZDrawerPosition', '弹出方向：left, top, right, bottom'],
        ['size', 'double?', '尺寸（宽或高）'],
        ['borderRadius', 'BorderRadius?', '圆角设置'],
      ],
      'preview': Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NZButton.primary(
            label: '打开左侧抽屉',
            onPressed: () => NZDrawer.show(
              context: context,
              position: NZDrawerPosition.left,
              child: _buildDrawerContent('左侧抽屉'),
            ),
          ),
          const SizedBox(width: 8),
          NZButton.secondary(
            label: '打开右侧抽屉',
            onPressed: () => NZDrawer.show(
              context: context,
              position: NZDrawerPosition.right,
              child: _buildDrawerContent('右侧抽屉'),
            ),
          ),
        ],
      ),
      'code': '''NZDrawer.show(
  context: context,
  position: NZDrawerPosition.left,
  child: MyMenuWidget(),
);''',
    },
    'BackToTop': {
      'title': 'BackToTop 回到顶部',
      'description': '自动监听滚动状态，点击后平滑滚动回顶部。',
      'usage': [
        ['controller', 'ScrollController', '需要监听的滚动控制器'],
        ['visibilityOffset', 'double', '滚动多少距离后显示按钮'],
        ['child', 'Widget?', '自定义按钮内容'],
      ],
      'preview': const Icon(
        Icons.vertical_align_top_rounded,
        size: 48,
        color: Colors.grey,
      ),
      'code': '''NZBackToTop(
  controller: _scrollController,
  visibilityOffset: 300,
);''',
    },
    'Buttons': {
      'title': 'Button 按钮',
      'description': '基础交互组件，支持多种样式、状态及自定义内容。',
      'usage': [
        ['onPressed', 'VoidCallback?', '点击回调，为 null 时按钮处于禁用状态'],
        ['label', 'String?', '按钮显示的文本内容'],
        [
          'style',
          'NZButtonStyle',
          '内置样式：primary (主色), secondary (次色), outline (描边), text (文字)',
        ],
        ['isLoading', 'bool', '是否显示加载动画，开启后按钮不可点击'],
        ['icon', 'Widget?', '按钮左侧显示的图标'],
      ],
      'preview': Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NZButton.primary(label: '主要按钮', onPressed: () {}),
          const SizedBox(height: 16),
          NZButton.secondary(label: '次要按钮', onPressed: () {}),
          const SizedBox(height: 16),
          NZButton.outline(label: '描边按钮', onPressed: () {}),
        ],
      ),
      'code': '''// 主要按钮示例
NZButton.primary(
  label: '主要按钮',
  onPressed: () => print('点击了主要按钮'),
);

// 带加载状态的按钮
NZButton.primary(
  label: '提交中',
  isLoading: true,
  onPressed: () {},
);''',
    },
    'FAB': {
      'title': 'FAB 悬浮按钮',
      'description': '支持随滚动隐藏、自由拖拽以及自动边缘吸附的高级悬浮按钮。',
      'usage': [
        ['onPressed', 'VoidCallback', '点击回调'],
        ['icon', 'Widget', '按钮图标'],
        ['label', 'String?', '扩展模式下的文字标签'],
        ['draggable', 'bool', '是否开启自由拖拽功能'],
        ['scrollController', 'ScrollController?', '关联滚动控制器以实现自动隐藏'],
      ],
      'preview': NZFloatingActionButton.standard(
        label: '发送消息',
        icon: const Icon(Icons.send_rounded),
        onPressed: () {},
      ),
      'code': '''// 标准扩展悬浮按钮
NZFloatingActionButton.standard(
  label: '发送消息',
  icon: Icon(Icons.send_rounded),
  onPressed: () {},
  draggable: true, // 开启拖拽
);''',
    },
    'CodeView': {
      'title': 'CodeView 代码预览',
      'description': '专业的语法高亮组件，支持行号显示、一键复制及多语言识别。',
      'usage': [
        ['code', 'String', '需要展示的源代码字符串'],
        ['theme', 'NZCodeTheme', 'githubLight 或 githubDark'],
        ['showLineNumbers', 'bool', '是否显示左侧行号'],
        ['showCopyButton', 'bool', '是否显示右上角复制按钮'],
      ],
      'preview': const NZCodeView(
        code: '''void main() {
  runApp(const MyApp());
}''',
        theme: NZCodeTheme.githubLight,
      ),
      'code': '''NZCodeView(
  code: codeString,
  theme: NZCodeTheme.githubLight,
  showLineNumbers: true,
  showCopyButton: true,
);''',
    },
    'Markdown': {
      'title': 'Markdown 渲染',
      'description': '纯原生实现的 Markdown 解析与渲染组件，无需任何第三方依赖。',
      'usage': [
        ['data', 'String', '需要渲染的 Markdown 文本内容'],
        ['style', 'NZMarkdownStyle?', '自定义样式配置，如字体大小、颜色等'],
      ],
      'preview': const NZMarkdown(
        data: '''### 快速开始
这是 NezhaUI 提供的原生 **Markdown** 渲染组件。
- 支持 **加粗**
- 支持 *斜体*
- 支持 `行内代码`

> 这是一个引用块，展示了优雅的排版效果。''',
      ),
      'code': '''NZMarkdown(
  data: """
### 标题
这是 **加粗** 文本。
- 列表项 1
- 列表项 2
""",
);''',
    },
  };

  @override
  Widget build(BuildContext context) {
    // 根据 _themeModeIndex 获取当前主题
    final isDark =
        _themeModeIndex == 2 ||
        (_themeModeIndex == 0 &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
    final theme = isDark ? NZTheme.darkTheme : NZTheme.lightTheme;

    return Theme(
      data: theme,
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: SelectionArea(
              child: Column(
                children: [
                  _buildNavbar(context, isDark),
                  Expanded(
                    child: Row(
                      children: [
                        // 固定侧边栏
                        Container(
                          width: 280,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E1E1E)
                                : const Color(0xFFF6F8FA),
                            border: Border(
                              right: BorderSide(
                                color: isDark
                                    ? Colors.white10
                                    : Colors.grey[200]!,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              _buildSidebarHeader(isDark),
                              Expanded(child: _buildSidebarMenu(isDark)),
                              _buildSidebarFooter(isDark),
                            ],
                          ),
                        ),
                        // 主内容区域
                        Expanded(
                          child:
                              _sections[_selectedSection]!['isLanding'] == true
                              ? _buildLandingPage(context, isDark)
                              : _buildDocContent(context, isDark),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// 构建顶部导航栏
  Widget _buildNavbar(BuildContext context, bool isDark) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.white10 : Colors.grey[200]!,
          ),
        ),
      ),
      child: Row(
        children: [
          // Banner Logo
          Image.asset(
            'docs/assets/banner.png',
            height: 32,
            errorBuilder: (context, error, stackTrace) => Row(
              children: [
                Icon(Icons.bolt_rounded, color: NZColor.nezhaPrimary, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'NezhaUI',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          const Spacer(),
          // 导航链接
          _buildNavLink(
            '首页',
            () => setState(() => _selectedSection = 'Home'),
            isDark,
          ),
          _buildNavLink(
            '关于',
            () => setState(() => _selectedSection = 'About'),
            isDark,
          ),
          _buildNavLink(
            'GitHub',
            () {}, // 这里可以添加跳转逻辑
            isDark,
            icon: Icons.open_in_new_rounded,
          ),
          const SizedBox(width: 24),
          // 主题切换
          _buildThemeToggle(isDark),
        ],
      ),
    );
  }

  Widget _buildNavLink(
    String title,
    VoidCallback onTap,
    bool isDark, {
    IconData? icon,
  }) {
    final isSelected =
        (_selectedSection == 'Home' && title == '首页') ||
        (_selectedSection == 'About' && title == '关于') ||
        (_selectedSection == title);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected
                      ? NZColor.nezhaPrimary
                      : (isDark ? Colors.white70 : Colors.black87),
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 4),
                Icon(
                  icon,
                  size: 14,
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(bool isDark) {
    final modes = [
      {'icon': Icons.brightness_auto_rounded, 'label': '自动'},
      {'icon': Icons.light_mode_rounded, 'label': '浅色'},
      {'icon': Icons.dark_mode_rounded, 'label': '深色'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: List.generate(3, (index) {
          final isSelected = _themeModeIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _themeModeIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark ? Colors.white24 : Colors.white)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isSelected && !isDark
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    modes[index]['icon'] as IconData,
                    size: 16,
                    color: isSelected
                        ? NZColor.nezhaPrimary
                        : (isDark ? Colors.white38 : Colors.black38),
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 6),
                    Text(
                      modes[index]['label'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  /// 构建侧边栏头部（Logo 和版本号）
  Widget _buildSidebarHeader(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(32),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/logo.png',
              width: 48,
              height: 48,
              errorBuilder: (context, error, stackTrace) => Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: NZColor.nezhaPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'NezhaUI',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          Text(
            '版本 v1.0.0',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white38 : Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建侧边栏菜单列表
  Widget _buildSidebarMenu(bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildMenuItem('Home', '概览首页', Icons.home_rounded, isDark),
        _buildMenuItem('About', '关于我们', Icons.info_outline_rounded, isDark),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            '核心组件',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white24 : Colors.grey,
            ),
          ),
        ),
        _buildMenuItem('Text', 'Text 文本排版', Icons.text_fields_rounded, isDark),
        _buildMenuItem(
          'Buttons',
          'Button 按钮',
          Icons.smart_button_rounded,
          isDark,
        ),
        _buildMenuItem('Drawer', 'Drawer 抽屉', Icons.menu_open_rounded, isDark),
        _buildMenuItem(
          'BackToTop',
          'BackToTop 回到顶部',
          Icons.vertical_align_top_rounded,
          isDark,
        ),
        _buildMenuItem('FAB', 'FAB 悬浮按钮', Icons.ads_click_rounded, isDark),
        _buildMenuItem('CodeView', 'CodeView 代码预览', Icons.code_rounded, isDark),
        _buildMenuItem(
          'Markdown',
          'Markdown 渲染',
          Icons.article_rounded,
          isDark,
        ),
      ],
    );
  }

  /// 构建单个菜单项
  Widget _buildMenuItem(String id, String title, IconData icon, bool isDark) {
    final isSelected = _selectedSection == id;
    return InkWell(
      onTap: () => setState(() => _selectedSection = id),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? NZColor.nezhaPrimary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? NZColor.nezhaPrimary
                  : (isDark ? Colors.white54 : Colors.black54),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? NZColor.nezhaPrimary
                    : (isDark ? Colors.white70 : Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建侧边栏页脚（版权信息和外链）
  Widget _buildSidebarFooter(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            '© 2026 钟智强',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white24 : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterLink(
                'GitHub 仓库',
                'https://github.com/ctkqiang/nezha_ui.git',
                isDark,
              ),
              Text(
                ' · ',
                style: TextStyle(color: isDark ? Colors.white10 : Colors.grey),
              ),
              _buildFooterLink('开源协议', '#', isDark),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建页脚辅助链接
  Widget _buildFooterLink(String text, String url, bool isDark) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: isDark ? Colors.blue[300] : Colors.blue,
        decoration: TextDecoration.underline,
      ),
    );
  }

  /// 构建产品落地页（Landing Page）
  Widget _buildLandingPage(BuildContext context, bool isDark) {
    final home = _sections[_selectedSection]!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: NZColor.nezhaPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '新版本发布 V1.0.0',
              style: TextStyle(
                fontSize: 12,
                color: NZColor.nezhaPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            home['title'],
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              letterSpacing: -2,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            home['subtitle'],
            style: TextStyle(
              fontSize: 24,
              color: isDark ? Colors.white54 : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 48),
          Row(
            children: [
              NZButton.primary(
                label: '开始使用',
                onPressed: () => setState(() => _selectedSection = 'Buttons'),
              ),
              const SizedBox(width: 16),
              NZButton.outline(
                label: 'GitHub 仓库',
                onPressed: () {}, // 处理外链跳转
              ),
            ],
          ),
          const SizedBox(height: 80),
          Divider(color: isDark ? Colors.white10 : Colors.grey[200]),
          const SizedBox(height: 80),
          NZMarkdown(
            data: home['content'],
            style: NZMarkdownStyle.defaultStyle(context).copyWith(
              p: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: isDark ? Colors.white70 : Colors.black87,
                height: 1.6,
              ),
              h1: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
                fontSize: 28,
              ),
              h2: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
                fontSize: 24,
              ),
              h3: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
                fontSize: 20,
              ),
              codeBackground: isDark ? Colors.white10 : const Color(0xFFF6F8FA),
              blockquoteBorderColor: isDark ? Colors.white24 : Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建具体的组件文档内容
  Widget _buildDocContent(BuildContext context, bool isDark) {
    final current = _sections[_selectedSection]!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 文档说明区
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  current['title'],
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  current['description'],
                  style: TextStyle(
                    fontSize: 18,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  'API 参数参考',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 24),
                _buildUsageTable(current['usage'], isDark),
              ],
            ),
          ),
        ),
        // 预览与代码展示区
        Expanded(
          flex: 2,
          child: Container(
            color: isDark ? const Color(0xFF141414) : const Color(0xFFFAFBFC),
            child: Column(
              children: [
                Expanded(
                  child: _buildPreviewSection(
                    '组件实时预览',
                    current['preview'],
                    isDark,
                  ),
                ),
                Expanded(
                  child: _buildPreviewSection(
                    '核心代码示例',
                    NZCodeView(
                      code: current['code'],
                      theme: isDark
                          ? NZCodeTheme.githubDark
                          : NZCodeTheme.githubLight,
                    ),
                    isDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 构建预览板块（包含标题和内容）
  Widget _buildPreviewSection(String title, Widget content, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white24 : Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(padding: const EdgeInsets.all(32), child: content),
          ),
        ),
      ],
    );
  }

  /// 构建参数说明表格
  Widget _buildUsageTable(List<List<String>> usage, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.02)
                    : const Color(0xFFF6F8FA),
              ),
              children: ['属性名称', '参数类型', '功能描述']
                  .map(
                    (h) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        h,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: isDark ? Colors.white70 : Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            ...usage.map(
              (row) => TableRow(
                children: row
                    .map(
                      (cell) => Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          cell,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white54 : Colors.black87,
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
    );
  }

  /// 构建抽屉内容的辅助方法
  Widget _buildDrawerContent(String title) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NZText.h3(title),
          const NZDivider(),
          const SizedBox(height: 16),
          NZText.body('这是一个高度可定制的抽屉内容示例。'),
          const SizedBox(height: 16),
          NZButton.primary(
            label: '点击关闭',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
