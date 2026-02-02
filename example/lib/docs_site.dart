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
  // 当前选中的文档章节
  String _selectedSection = 'Home';

  // 所有文档章节的数据源
  final Map<String, Map<String, dynamic>> _sections = {
    'Home': {
      'title': 'NezhaUI',
      'subtitle': '轻量、优雅且专业的 Flutter 移动端组件库',
      'isLanding': true,
      'content':
          '''NezhaUI 是一套基于 Flutter 构建的移动端设计系统，致力于为现代应用开发提供丝滑、灵敏且高度可定制的 UI 组件。

### 核心理念
- **极致性能**：每个组件都经过细致的调优，确保在低端设备上也能保持流畅。
- **专业美学**：遵循现代设计规范，提供一致且高级的视觉体验。
- **高度定制**：深度集成 NZTheme 系统，轻松适配各种品牌风格。''',
      'github': 'https://github.com/ctkqiang/nezha_ui',
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
        data: '''### 弟弟快看！
这是大姐为你写的 **Markdown** 组件。
- 支持 **加粗**
- 支持 *斜体*
- 支持 `行内代码`

> 这是一个引用块，是不是很优雅？''',
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // 固定侧边栏：在 Web 端始终保持展开状态
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8FA),
              border: Border(right: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Column(
              children: [
                _buildSidebarHeader(),
                Expanded(child: _buildSidebarMenu()),
                _buildSidebarFooter(),
              ],
            ),
          ),
          // 主内容区域：根据当前选中的章节显示不同的内容
          Expanded(
            child: _sections[_selectedSection]!['isLanding'] == true
                ? _buildLandingPage()
                : _buildDocContent(),
          ),
        ],
      ),
    );
  }

  /// 构建侧边栏头部（Logo 和版本号）
  Widget _buildSidebarHeader() {
    return Container(
      padding: const EdgeInsets.all(32),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
          const SizedBox(height: 16),
          const Text(
            'NezhaUI',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            '版本 v1.0.0',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建侧边栏菜单列表
  Widget _buildSidebarMenu() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildMenuItem('Home', '概览首页', Icons.home_rounded),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            '核心组件',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        _buildMenuItem('Buttons', 'Button 按钮', Icons.smart_button_rounded),
        _buildMenuItem('FAB', 'FAB 悬浮按钮', Icons.ads_click_rounded),
        _buildMenuItem('CodeView', 'CodeView 代码预览', Icons.code_rounded),
        _buildMenuItem('Markdown', 'Markdown 渲染', Icons.article_rounded),
      ],
    );
  }

  /// 构建单个菜单项
  Widget _buildMenuItem(String id, String title, IconData icon) {
    final isSelected = _selectedSection == id;
    return InkWell(
      onTap: () => setState(() => _selectedSection = id),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? NZColor.nezhaPrimary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? NZColor.nezhaPrimary : Colors.black54,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? NZColor.nezhaPrimary : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建侧边栏页脚（版权信息和外链）
  Widget _buildSidebarFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            '© 2026 钟智强',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterLink(
                'GitHub 仓库',
                'https://github.com/ctkqiang/nezha_ui',
              ),
              const Text(' · ', style: TextStyle(color: Colors.grey)),
              _buildFooterLink('开源协议', '#'),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建页脚辅助链接
  Widget _buildFooterLink(String text, String url) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
    );
  }

  /// 构建产品落地页（Landing Page）
  Widget _buildLandingPage() {
    final home = _sections['Home']!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: NZColor.nezhaPrimary.withValues(alpha: 0.1),
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
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              letterSpacing: -2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            home['subtitle'],
            style: TextStyle(fontSize: 24, color: Colors.grey[600]),
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
          const Divider(),
          const SizedBox(height: 80),
          NZMarkdown(data: home['content']),
        ],
      ),
    );
  }

  /// 构建具体的组件文档内容
  Widget _buildDocContent() {
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
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  current['description'],
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 48),
                const Text(
                  'API 参数参考',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                _buildUsageTable(current['usage']),
              ],
            ),
          ),
        ),
        // 预览与代码展示区
        Expanded(
          flex: 2,
          child: Container(
            color: const Color(0xFFFAFBFC),
            child: Column(
              children: [
                Expanded(
                  child: _buildPreviewSection('组件实时预览', current['preview']),
                ),
                Expanded(
                  child: _buildPreviewSection(
                    '核心代码示例',
                    NZCodeView(
                      code: current['code'],
                      theme: NZCodeTheme.githubDark,
                    ),
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
  Widget _buildPreviewSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
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
  Widget _buildUsageTable(List<List<String>> usage) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
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
              decoration: const BoxDecoration(color: Color(0xFFF6F8FA)),
              children: ['属性名称', '参数类型', '功能描述']
                  .map(
                    (h) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        h,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
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
}
