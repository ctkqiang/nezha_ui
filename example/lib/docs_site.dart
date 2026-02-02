import 'package:flutter/material.dart';
import 'package:nezha_ui/nezha.dart';
import 'package:nezha_ui/components/code_view.dart';

class NZDocsSite extends StatefulWidget {
  const NZDocsSite({super.key});

  @override
  State<NZDocsSite> createState() => _NZDocsSiteState();
}

class _NZDocsSiteState extends State<NZDocsSite> {
  String _selectedSection = 'Buttons';

  final Map<String, Map<String, dynamic>> _sections = {
    'Buttons': {
      'title': 'Button 组件',
      'description': 'NezhaUI 提供了一套功能丰富、易于使用的按钮组件，满足从基础点击到复杂交互的各种场景。',
      'usage': [
        ['onPressed', 'VoidCallback?', '点击回调'],
        ['label', 'String?', '按钮文字'],
        ['style', 'NZButtonStyle', '按钮样式 (primary, secondary, outline, text)'],
        ['isLoading', 'bool', '是否显示加载状态'],
      ],
      'preview': Column(
        children: [
          NZButton.primary(label: 'Primary Button', onPressed: () {}),
          const SizedBox(height: 12),
          NZButton.secondary(label: 'Secondary Button', onPressed: () {}),
        ],
      ),
      'code': '''NZButton.primary(
  label: 'Primary Button',
  onPressed: () {},
);

NZButton.secondary(
  label: 'Secondary Button',
  onPressed: () {},
);''',
    },
    'FAB': {
      'title': 'Floating Action Button',
      'description': '悬浮按钮支持随滚动隐藏、自由拖拽以及自动边缘吸附功能。',
      'usage': [
        ['onPressed', 'VoidCallback', '点击回调'],
        ['type', 'NZFloatingActionButtonType', '按钮类型'],
        ['draggable', 'bool', '是否开启拖拽'],
        ['scrollController', 'ScrollController?', '关联滚动控制器'],
      ],
      'preview': Center(
        child: NZFloatingActionButton.standard(
          label: 'Action',
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
      'code': '''NZFloatingActionButton.standard(
  label: 'Action',
  icon: const Icon(Icons.add),
  onPressed: () {},
);''',
    },
    'CodeView': {
      'title': 'Code View',
      'description': '专业的语法高亮组件，内置 GitHub Light/Dark 主题，支持多语言识别。',
      'usage': [
        ['code', 'String', '需要显示的代码'],
        ['theme', 'NZCodeTheme', '主题模式 (light, dark)'],
        ['showLineNumbers', 'bool', '是否显示行号'],
      ],
      'preview': const NZCodeView(
        code: 'void main() {\n  print("Hello World");\n}',
        theme: NZCodeTheme.githubLight,
      ),
      'code': '''NZCodeView(
  code: 'void main() {\\n  print("Hello World");\\n}',
  theme: NZCodeTheme.githubLight,
);''',
    },
  };

  @override
  Widget build(BuildContext context) {
    final current = _sections[_selectedSection]!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'NezhaUI Documentation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey[200], height: 1),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFF6F8FA)),
              child: Center(
                child: Text(
                  'NezhaUI',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ..._sections.keys.map(
              (key) => ListTile(
                title: Text(key),
                selected: _selectedSection == key,
                onTap: () {
                  setState(() => _selectedSection = key);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Main Content (Description + Usage Table)
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    current['title'],
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    current['description'],
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '参数说明',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildUsageTable(current['usage']),
                ],
              ),
            ),
          ),
          // Vertical Divider
          Container(width: 1, color: Colors.grey[200]),
          // Right: Preview + Code
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFFFAFBFC),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            '预览',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(child: Center(child: current['preview'])),
                      ],
                    ),
                  ),
                  Container(height: 1, color: Colors.grey[200]),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            '代码示例',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                            child: NZCodeView(
                              code: current['code'],
                              theme: NZCodeTheme.githubDark,
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
        ],
      ),
    );
  }

  Widget _buildUsageTable(List<List<String>> usage) {
    return Table(
      border: TableBorder.all(color: Colors.grey[300]!, width: 1),
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFFF6F8FA)),
          children: ['参数', '类型', '说明']
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    h,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                    padding: const EdgeInsets.all(12),
                    child: Text(cell),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
