import 'package:flutter/material.dart';
import 'package:nezha_ui/nezha.dart';

class NZDocSection {
  final String id;
  final String title;
  final String? subtitle;
  final String? description;
  final String content;
  final Widget? preview;
  final String? code;
  final List<List<String>>? usage;
  final bool isLanding;
  final String? github;
  final IconData icon;

  const NZDocSection({
    required this.id,
    required this.title,
    this.subtitle,
    this.description,
    required this.content,
    this.preview,
    this.code,
    this.usage,
    this.isLanding = false,
    this.github,
    required this.icon,
  });
}

class NZDocContent {
  static List<NZDocSection> getSections(BuildContext context) => [
    NZDocSection(
      id: 'NezhaApp',
      title: '应用入口 (NezhaApp)',
      icon: Icons.apps_rounded,
      description: '基于 Material 设计语言的定制化应用入口组件，深度集成 NezhaUI 主题系统。',
      usage: [
        ['home', 'Widget?', '应用程序的主页入口'],
        ['theme', 'ThemeData?', '亮色模式下的主题配置'],
        ['darkTheme', 'ThemeData?', '暗色模式下的主题配置'],
        [
          'themeMode',
          'ThemeMode',
          '主题切换模式：system (跟随系统), light (亮色), dark (暗色)',
        ],
        ['title', 'String', '应用程序在操作系统任务管理器中显示的标题'],
        ['routes', 'Map<String, WidgetBuilder>?', '应用程序的静态路由表'],
        ['initialRoute', 'String?', '应用程序启动时的初始路由'],
        ['onGenerateRoute', 'RouteFactory?', '动态生成路由的回调函数'],
        ['navigatorObservers', 'List<NavigatorObserver>', '用于监听导航事件的观察者列表'],
        [
          'localizationsDelegates',
          'Iterable<LocalizationsDelegate>?',
          '国际化资源代理列表',
        ],
        ['supportedLocales', 'Iterable<Locale>', '应用程序支持的语言区域列表'],
        ['debugShowCheckedModeBanner', 'bool', '是否在右上角显示 "Debug" 标志'],
        ['builder', 'TransitionBuilder?', '用于在导航器之上构建组件的回调（如全局 Loading）'],
      ],
      preview: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.auto_awesome_motion_rounded,
              size: 48,
              color: NZColor.nezhaPrimary,
            ),
            const SizedBox(height: 12),
            NZText.body('NezhaApp 是应用程序的灵魂容器。'),
            const SizedBox(height: 8),
            NZText.caption('它统一管理了主题、路由、国际化以及全局交互。'),
          ],
        ),
      ),
      content:
          'NezhaApp 是 NezhaUI 的核心入口组件。它不仅封装了标准的 MaterialApp 功能，还自动处理了 NezhaUI 特有的颜色系统和响应式布局适配。通过使用 NezhaApp，你可以轻松实现全局主题切换、精细的 UI 控制以及丝滑的英雄 (Hero) 动画支持。',
      code: '''import 'package:flutter/material.dart';
import 'package:nezha_ui/nezha.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NezhaApp(
      title: 'Nezha UI Demo',
      // 配置亮色主题
      theme: NZTheme.lightTheme,
      // 配置暗色主题
      darkTheme: NZTheme.darkTheme,
      // 设置主题模式为跟随系统
      themeMode: ThemeMode.system,
      // 应用程序主页
      home: const MyHomePage(),
      // 路由配置
      routes: {
        '/settings': (context) => const SettingsPage(),
      },
      // 国际化配置
      supportedLocales: const [
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}''',
    ),
    NZDocSection(
      id: 'Home',
      title: '哪吒 UI (NezhaUI)',
      subtitle: '为 Flutter 开发者提供优雅且精准的开发体验。',
      isLanding: true,
      icon: Icons.home_rounded,
      content: '''哪吒 UI 是一个为 Flutter 打造的高级设计系统，旨在提供流畅、响应式且高度可定制的移动端体验。

### 核心特性
- **流畅交互**：每个组件都经过细致的性能调优，确保动画过渡自然顺滑。
- **品牌定制**：深度集成 `NZTheme` 系统，支持无缝切换主题与品牌色。
- **生产就绪**：提供包括按钮、抽屉、下拉刷新在内的全套核心组件。

### 为什么选择哪吒 UI？
我们不仅仅是提供组件，更是在提供一套完整的工程解决方案。所有的组件都遵循统一的设计语言，确保你的应用在视觉和交互上保持高度一致。

### 快速开始
1. **安装依赖**：
   在 `pubspec.yaml` 中添加：
   ```yaml
   dependencies:
     nezha_ui: ^1.0.0
   ```
   或者运行：`flutter pub add nezha_ui`

2. **引入库**：
   ```dart
   import 'package:nezha_ui/nezha.dart';
   ```

3. **配置主题**：
   使用 `NZTheme` 包裹你的应用根组件，或使用 `NezhaApp`。''',
      github: 'https://github.com/ctkqiang/nezha_ui.git',
    ),
    NZDocSection(
      id: 'About',
      title: '关于哪吒 UI',
      subtitle: '框架背后的愿景。',
      isLanding: true,
      icon: Icons.info_outline_rounded,
      github: 'https://github.com/ctkqiang/nezha_ui.git',
      content: '''哪吒 UI 代表了工程卓越与创意设计的融合。

### 我们的愿景
架起复杂功能与轻松用户交互之间的桥梁。每一像素都经过计算，每一行代码都带有使命。

### 核心支柱
- **可扩展性**：专为小型原型和大型企业级应用设计。
- **无障碍性**：内置对包容性设计标准的支持。''',
    ),
    NZDocSection(
      id: 'Text',
      title: '文本排版 (Text)',
      icon: Icons.text_fields_rounded,
      description: '具有预定义层级样式的标准化排版组件。',
      usage: [
        ['data', 'String', '要显示的文本字符串'],
        ['style', 'TextStyle?', '可选的文本样式覆盖'],
        ['textAlign', 'TextAlign?', '文本对齐方式'],
        ['maxLines', 'int?', '允许的最大行数'],
        ['overflow', 'TextOverflow?', '视觉溢出处理策略'],
      ],
      preview: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          NZText.h1('H1 标题'),
          NZText.h2('H2 标题'),
          NZText.h3('H3 标题'),
          const SizedBox(height: 16),
          NZText.subtitle('副标题样式'),
          const SizedBox(height: 8),
          NZText.body('标准正文文本，具有优化的行高和字符间距。'),
          const SizedBox(height: 8),
          NZText.caption('用于补充信息的说明文字。'),
        ],
      ),
      content: 'NZText 封装了 Material Design 排版，同时为常见用例提供了简化的接口。',
      code: '''NZText.h1('标题');
NZText.subtitle('副标题');
NZText.body('正文内容');''',
    ),
    NZDocSection(
      id: 'Button',
      title: '按钮 (Button)',
      icon: Icons.smart_button_rounded,
      description: '支持多种视觉状态和配置的交互式按钮组件。',
      usage: [
        ['onPressed', 'VoidCallback?', '点击时触发的操作。为 null 时禁用按钮'],
        ['label', 'String?', '主要文本标签'],
        ['style', 'NZButtonStyle', '视觉变体：primary, secondary, outline, text'],
        ['isLoading', 'bool', '激活时显示加载指示器'],
        ['block', 'bool', '强制按钮占据全宽'],
        ['icon', 'Widget?', '可选的前置图标'],
      ],
      preview: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NZButton.primary(label: '主要按钮', onPressed: () {}),
          const SizedBox(height: 12),
          NZButton.secondary(label: '次要按钮', onPressed: () {}),
          const SizedBox(height: 12),
          NZButton.outline(label: '边框按钮', onPressed: () {}),
          const SizedBox(height: 12),
          NZButton.text(label: '文字按钮', onPressed: () {}),
        ],
      ),
      content: 'NZButton 为主要和次要操作提供了统一的接口，并内置了反馈机制。',
      code: '''NZButton.primary(
  label: '立即开始',
  onPressed: () {},
);

NZButton.primary(
  label: '处理中',
  isLoading: true,
  onPressed: () {},
);''',
    ),
    NZDocSection(
      id: 'Drawer',
      title: '抽屉 (Drawer)',
      icon: Icons.menu_open_rounded,
      description: '用于辅助导航或内容显示的覆盖层组件。',
      usage: [
        ['child', 'Widget', '要在抽屉内渲染的内容'],
        ['position', 'NZDrawerPosition', '入口点：left, right, top, bottom'],
        ['size', 'double?', '取决于位置的宽度或高度'],
        ['showDragHandle', 'bool', '交互式拖拽手柄的可见性'],
      ],
      preview: Center(
        child: NZButton.primary(
          label: '打开底部抽屉',
          onPressed: () => NZDrawer.show(
            context: context,
            position: NZDrawerPosition.bottom,
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NZText.h3('抽屉标题'),
                  const SizedBox(height: 16),
                  NZText.body('此处放置上下文相关内容。'),
                  const SizedBox(height: 32),
                  NZButton.primary(
                    label: '确认',
                    block: true,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      content: 'NZDrawer 使用模态方式呈现临时信息，而不会丢失主上下文。',
      code: '''NZDrawer.show(
  context: context,
  position: NZDrawerPosition.bottom,
  child: ContentWidget(),
);''',
    ),
    NZDocSection(
      id: 'Divider',
      title: '分割线 (Divider)',
      icon: Icons.horizontal_rule_rounded,
      description: '用于视觉分离内容的结构组件。',
      usage: [
        ['height', 'double', '组件占用的垂直空间'],
        ['thickness', 'double', '线条的笔触宽度'],
        ['indent', 'double?', '前置缩进'],
        ['endIndent', 'double?', '后置缩进'],
        ['color', 'Color?', '线条颜色的覆盖'],
      ],
      preview: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NZText.body('上部区域'),
          const NZDivider(),
          NZText.body('中部区域'),
          const NZDivider(height: 32, thickness: 2, color: Colors.blue),
          NZText.body('下部区域'),
        ],
      ),
      content: 'NZDivider 有助于在复杂布局中保持视觉层级和组织。',
      code: '''const NZDivider();

NZDivider(
  height: 32,
  thickness: 1,
  color: Colors.grey,
);''',
    ),
    NZDocSection(
      id: 'BackToTop',
      title: '回到顶部 (BackToTop)',
      icon: Icons.vertical_align_top_rounded,
      description: '用于返回可滚动内容开头的导航快捷方式。',
      usage: [
        ['scrollController', 'ScrollController', '跟踪滚动进度的控制器'],
        ['threshold', 'double', '显示按钮所需的偏移量'],
        ['duration', 'Duration', '滚动操作的动画持续时间'],
      ],
      preview: Container(
        height: 160,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Center(child: NZText.caption('滚动可见性演示区域')),
      ),
      content: 'NZBackToTop 增强了长列表或文章视图的易用性。',
      code: '''NZBackToTop(
  scrollController: _controller,
  threshold: 300,
  child: Icon(Icons.arrow_upward),
);''',
    ),
    NZDocSection(
      id: 'FloatingActionButton',
      title: '悬浮按钮 (FAB)',
      icon: Icons.add_circle_outline_rounded,
      description: '高级悬浮触发器，支持图标、标签和拖拽交互。',
      usage: [
        ['type', 'NZFloatingActionButtonType', '变体：standard, icon, image'],
        ['draggable', 'bool', '启用用户驱动的定位'],
        ['scrollController', 'ScrollController?', '滚动时自动隐藏功能'],
      ],
      preview: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NZFloatingActionButton.icon(
            icon: const Icon(Icons.message_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
          NZFloatingActionButton.standard(
            icon: const Icon(Icons.edit_rounded),
            label: '撰写',
            onPressed: () {},
          ),
        ],
      ),
      content: '一个多功能的 FAB 实现，超越了基础的 Material FAB 功能。',
      code: '''NZFloatingActionButton.icon(
  icon: Icon(Icons.add),
  onPressed: () {},
);''',
    ),
    NZDocSection(
      id: 'Markdown',
      title: 'Markdown 视图',
      icon: Icons.description_rounded,
      description: '使用原生 Flutter 组件实现的高性能 Markdown 渲染。',
      usage: [
        ['data', 'String', 'Markdown 源字符串'],
        ['style', 'NZMarkdownStyle?', '渲染的主题配置'],
      ],
      preview: const NZMarkdown(
        data: '''### Markdown 支持
- 标准 **加粗** 和 *斜体*
- 行内 `代码` 块
- 引用和列表''',
      ),
      content: 'NZMarkdown 提供了一种轻量级的方式来渲染结构化文本，无需外部依赖。',
      code: '''NZMarkdown(
  data: '# 标题\\n内容',
);''',
    ),
    NZDocSection(
      id: 'PullToRefresh',
      title: '下拉刷新 (PullToRefresh)',
      icon: Icons.refresh_rounded,
      description: '带有主题化反馈的无缝下拉刷新集成。',
      usage: [
        ['onRefresh', 'Future<void> Function()', '异步任务触发器'],
        ['showSpinner', 'bool', '加载指示器的可见性'],
        ['label', 'String?', '状态消息文本'],
      ],
      preview: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: NZText.caption('交互式刷新区域')),
      ),
      content: 'NZPullToRefresh 抽象了手动处理刷新的复杂性。',
      code: '''NZPullToRefresh(
  onRefresh: () async => await fetchData(),
  child: ListView(...),
);''',
    ),
    NZDocSection(
      id: 'NavBar',
      title: '导航栏 (NavBar)',
      icon: Icons.view_headline_rounded,
      description: '多功能顶栏，支持搜索模式、Logo 展示及小程序胶囊风格。',
      usage: [
        ['title', 'String?', '标题文本内容'],
        ['titleWidget', 'Widget?', '自定义标题组件（优先级高于 title）'],
        ['type', 'NZNavBarType', '类型：normal, search, logo, miniApp'],
        ['logoUrl', 'String?', 'Logo 图片地址（仅 logo 模式）'],
        ['centerTitle', 'bool', '标题是否居中显示（默认 true）'],
        ['backgroundColor', 'Color?', '背景颜色（默认适配主题）'],
        ['foregroundColor', 'Color?', '前景文字/图标颜色'],
        ['onSearch', 'VoidCallback?', '搜索触发回调'],
        ['onSearchChanged', 'ValueChanged<String>?', '输入内容变化回调'],
        ['onMiniAppShare', 'VoidCallback?', '小程序模式分享回调'],
        ['onMiniAppClose', 'VoidCallback?', '小程序模式关闭回调'],
      ],
      preview: Column(
        children: [
          const NZNavBar(title: '标准导航栏', centerTitle: true),
          const SizedBox(height: 16),
          const NZNavBar.logo(
            title: 'Nezha UI',
            logoUrl:
                'https://raw.githubusercontent.com/ctkqiang/nezha_ui/master/docs/assets/banner.png',
          ),
          const SizedBox(height: 16),
          NZNavBar.search(title: '搜索文档', onSearch: () {}),
          const SizedBox(height: 16),
          const NZNavBar.miniApp(title: '小程序模式'),
        ],
      ),
      content:
          'NZNavBar 是一个多功能顶部导航组件，支持平滑的搜索框展开动画、品牌展示以及符合微信小程序规范的胶囊控制按钮。它会自动处理亮/暗色主题适配，确保在任何背景下都有良好的可读性。',
      code: '''// 标准模式
const NZNavBar(title: '标题');

// 搜索模式
NZNavBar.search(
  title: '搜索',
  onSearch: () => print('Searching...'),
);

// 小程序胶囊模式
NZNavBar.miniApp(
  title: '小程序',
  onMiniAppClose: () => Navigator.pop(context),
);''',
    ),
    NZDocSection(
      id: 'CodeView',
      title: '代码视图 (CodeView)',
      icon: Icons.code_rounded,
      description: '具有 GitHub 风格主题的语法高亮查看器。',
      usage: [
        ['code', 'String', '要高亮的源代码'],
        ['theme', 'NZCodeTheme', '主题变体：light 或 dark'],
        ['showCopyButton', 'bool', '将代码复制到剪贴板的工具'],
      ],
      preview: const NZCodeView(
        code: 'void main() {\n  runApp(const MyApp());\n}',
        theme: NZCodeTheme.githubLight,
      ),
      content: 'NZCodeView 专为技术文档和教育应用而优化。',
      code: '''NZCodeView(
  code: 'const pi = 3.14;',
  theme: NZCodeTheme.githubDark,
);''',
    ),
  ];
}
