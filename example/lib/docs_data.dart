import 'dart:math';
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
      id: 'Tag',
      title: '标签 (NZTag)',
      icon: Icons.label_important_outline_rounded,
      description: '精致、灵活的标签组件，支持多种样式、尺寸和交互。',
      usage: [
        ['label', 'String', '标签文本内容'],
        ['style', 'NZTagStyle', '样式类型：filled (填充), outline (描边), soft (浅色填充)'],
        ['size', 'NZTagSize', '尺寸：small, medium, large'],
        ['color', 'Color?', '标签主题颜色'],
        ['leading', 'Widget?', '左侧图标或组件'],
        ['trailing', 'Widget?', '右侧图标或组件'],
        ['onTap', 'VoidCallback?', '点击回调'],
        ['onDeleted', 'VoidCallback?', '删除回调，若提供则显示删除图标'],
        ['round', 'bool', '是否为胶囊形状'],
      ],
      preview: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              const NZTag(label: '默认标签'),
              NZTag(
                label: '主要标签',
                color: NZColor.nezhaPrimary,
                style: NZTagStyle.filled,
              ),
              NZTag(label: '成功状态', color: Colors.green, style: NZTagStyle.soft),
              const NZTag(label: '描边样式', style: NZTagStyle.outline),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              const NZTag(label: '小号', size: NZTagSize.small),
              const NZTag(label: '中号', size: NZTagSize.medium),
              const NZTag(label: '大号', size: NZTagSize.large),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              NZTag(
                label: '带图标',
                leading: const Icon(
                  Icons.star_rounded,
                  size: 14,
                  color: Colors.amber,
                ),
                onTap: () {},
              ),
              NZTag(label: '可删除', color: Colors.red, onDeleted: () {}),
              const NZTag(label: '胶囊形', round: true),
            ],
          ),
        ],
      ),
      content: 'NZTag 提供了丰富的视觉反馈，适用于商品标签、筛选项、状态标记等场景。',
      code: '''// 基础用法
NZTag(label: '标签内容')

// 填充样式
NZTag(
  label: '主要',
  style: NZTagStyle.filled,
  color: Colors.blue,
)

// 带删除功能
NZTag(
  label: '可删除',
  onDeleted: () => debugPrint('deleted'),
)''',
    ),
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
- **金融级组件**：内置专业 K 线图、行情公告栏等金融业务核心组件。
- **品牌定制**：深度集成 `NZTheme` 系统，支持无缝切换主题与品牌色。
- **生产就绪**：提供包括按钮、抽屉、下拉刷新在内的全套核心组件。

### 为什么选择哪吒 UI？
我们不仅仅是提供组件，更是在提供一套完整的工程解决方案。所有的组件都遵循统一的设计语言，确保你的应用在视觉 and 交互上保持高度一致。''',
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
      title: '文本排版 (NZText)',
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
      title: '按钮 (NZButton)',
      icon: Icons.smart_button_rounded,
      description: '支持多种视觉状态、进度展示及配置的交互式按钮组件。',
      usage: [
        ['onPressed', 'VoidCallback?', '点击时触发的操作。为 null 时禁用按钮'],
        ['label', 'String?', '主要文本标签'],
        ['style', 'NZButtonStyle', '视觉变体：primary, secondary, outline, text'],
        ['isLoading', 'bool', '激活时显示加载指示器'],
        ['progress', 'double?', '可选的进度值 (0.0 到 1.0)'],
        ['progressColor', 'Color?', '进度条填充颜色'],
        ['block', 'bool', '强制按钮占据全宽'],
        ['icon', 'Widget?', '可选的前置图标'],
        ['borderRadius', 'double', '圆角半径（默认 12.0）'],
        ['height', 'double', '按钮高度（默认 48.0）'],
      ],
      preview: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: NZButton.primary(label: '主要按钮', onPressed: () {}),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: NZButton.secondary(label: '次要按钮', onPressed: () {}),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              NZButton.primary(
                label: '系统更新中 65%',
                progress: 0.65,
                block: true,
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: NZButton.outline(
                      label: '资源同步',
                      progress: 0.3,
                      progressColor: Colors.orange.withValues(alpha: 0.2),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: NZButton.primary(
                      label: '完成',
                      progress: 1.0,
                      progressColor: Colors.green.withValues(alpha: 0.3),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              NZButton.primary(
                label: '加载中状态',
                isLoading: true,
                block: true,
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              NZButton.primary(
                label: '带图标按钮',
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                block: true,
                onPressed: () {},
              ),
            ],
          );
        },
      ),
      content: 'NZButton 为主要和次要操作提供了统一的接口，并内置了反馈机制及进度展示功能。',
      code: '''// 基础用法
NZButton.primary(
  label: '立即开始',
  onPressed: () {},
);

// 进度按钮模式
NZButton.primary(
  label: '下载中 65%',
  progress: 0.65,
  onPressed: () {},
);

// 加载中状态
NZButton.primary(
  label: '处理中',
  isLoading: true,
  onPressed: () {},
);''',
    ),
    NZDocSection(
      id: 'Drawer',
      title: '抽屉 (NZDrawer)',
      icon: Icons.menu_open_rounded,
      description: '用于辅助导航 or 内容显示的覆盖层组件。',
      usage: [
        ['child', 'Widget', '要在抽屉内渲染的内容'],
        ['position', 'NZDrawerPosition', '显示位置：left, right, top, bottom'],
        ['size', 'double?', '尺寸（宽度或高度）'],
        ['showDragHandle', 'bool', '显示拖拽手柄（仅 bottom）'],
        ['borderRadius', 'double', '圆角半径（默认 16.0）'],
      ],
      preview: Builder(
        builder: (context) => Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            NZButton.outline(
              label: '底部抽屉',
              onPressed: () => NZDrawer.show(
                context: context,
                position: NZDrawerPosition.bottom,
                child: _buildDrawerContent(context, '底部抽屉'),
              ),
            ),
            NZButton.outline(
              label: '顶部抽屉',
              onPressed: () => NZDrawer.show(
                context: context,
                position: NZDrawerPosition.top,
                child: _buildDrawerContent(context, '顶部抽屉'),
              ),
            ),
            NZButton.outline(
              label: '左侧抽屉',
              onPressed: () => NZDrawer.show(
                context: context,
                position: NZDrawerPosition.left,
                child: _buildDrawerContent(context, '左侧抽屉'),
              ),
            ),
            NZButton.outline(
              label: '右侧抽屉',
              onPressed: () => NZDrawer.show(
                context: context,
                position: NZDrawerPosition.right,
                child: _buildDrawerContent(context, '右侧抽屉'),
              ),
            ),
          ],
        ),
      ),
      content: 'NZDrawer 使用模态方式呈现临时信息，而不会丢失主上下文。',
      code: '''// 底部显示 (默认)
NZDrawer.show(
  context: context,
  position: NZDrawerPosition.bottom,
  child: MyWidget(),
);

// 顶部显示
NZDrawer.show(
  context: context,
  position: NZDrawerPosition.top,
  size: 300,
  child: MyWidget(),
);

// 侧边显示
NZDrawer.show(
  context: context,
  position: NZDrawerPosition.left,
  child: MyWidget(),
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
      content: 'NZDivider 有助于在复杂布局中保持视觉层级 and 组织。',
      code: '''const NZDivider();

NZDivider(
  height: 32,
  thickness: 1,
  color: Colors.grey,
);''',
    ),
    NZDocSection(
      id: 'Calendar',
      title: '日历 (Candar)',
      icon: Icons.calendar_month_rounded,
      description: '专业级日历组件，支持多样式切换、农历显示、事件标记、平滑动画及自定义主题。',
      usage: [
        ['initialDate', 'DateTime?', '初始选中的日期，默认为今天'],
        ['firstDate', 'DateTime?', '最小可选日期'],
        ['lastDate', 'DateTime?', '最大可选日期'],
        ['onDateSelected', 'ValueChanged<DateTime>?', '日期选中回调'],
        ['events', 'Map<DateTime, List<Color>>?', '日期事件标记，Key 为日期，Value 为颜色列表'],
        ['weekDayLabels', 'List<String>', '自定义周几标签（默认：[日, 一, ..., 六]）'],
        ['showHeader', 'bool', '是否显示头部导航（默认 true）'],
        ['showLunar', 'bool', '是否显示农历（默认 true）'],
        [
          'style',
          'NZCalendarStyle',
          '样式类型：classic (经典), card (卡片), compact (紧凑)',
        ],
        ['primaryColor', 'Color?', '自定义主色调'],
        ['backgroundColor', 'Color?', '背景颜色'],
        ['borderRadius', 'double', '容器圆角（默认 16.0）'],
        ['usePrompt', 'bool', '是否开启点击日期显示选项弹窗（默认 false）'],
        ['promptOptions', 'List<String>?', '弹窗中的选项列表'],
        ['onOptionSelected', 'Function?', '选中选项时的回调'],
      ],
      preview: Column(
        children: [
          NZCalendar(
            events: {
              DateTime.now(): [Colors.red, Colors.blue],
              DateTime.now().add(const Duration(days: 1)): [Colors.green],
              DateTime.now().subtract(const Duration(days: 2)): [
                Colors.orange,
                Colors.purple,
                Colors.cyan,
              ],
            },
          ),
          const SizedBox(height: 24),
          const NZCalendar(style: NZCalendarStyle.card, showLunar: true),
          const SizedBox(height: 24),
          NZCalendar(
            style: NZCalendarStyle.compact,
            usePrompt: true,
            onOptionSelected: (date, option) {
              debugPrint('Selected $option for $date');
            },
          ),
        ],
      ),
      content:
          'NZCalendar 采用了 PageView 实现无限月份滚动，并配合 AnimatedSwitcher 和 AnimatedContainer 提供丝滑的视觉过渡效果。内置的高精度农历转换算法及事件标记功能，确保了在各种场景下的实用性。',
      code: '''// 基础用法
const NZCalendar()

// 带事件标记
NZCalendar(
  events: {
    DateTime(2024, 3, 20): [Colors.red, Colors.blue],
  },
)

// 自定义周标签
NZCalendar(
  weekDayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
)''',
    ),
    NZDocSection(
      id: 'BackToTop',
      title: '回到顶部 (BackTop)',
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
      description: '高级悬浮触发器，支持图标、标签 and 拖拽交互。',
      usage: [
        ['type', 'NZFloatingActionButtonType', '变体：standard, icon, image'],
        ['draggable', 'bool', '启用用户驱动的定位'],
        ['scrollController', 'ScrollController?', '滚动时自动隐藏功能'],
      ],
      preview: Wrap(
        alignment: WrapAlignment.center,
        spacing: 16,
        runSpacing: 16,
        children: [
          NZFloatingActionButton.icon(
            icon: const Icon(Icons.message_rounded),
            onPressed: () {},
          ),
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
        ['leading', 'Widget?', '左侧自定义组件'],
        ['actions', 'List<Widget>?', '右侧动作组件列表'],
        ['height', 'double', '导航栏高度（默认 56.0）'],
      ],
      preview: Column(
        children: [
          const NZNavBar(title: '标准模式', centerTitle: true),
          const SizedBox(height: 16),
          const NZNavBar.logo(
            title: 'Nezha UI',
            logoUrl:
                'https://raw.githubusercontent.com/ctkqiang/nezha_ui/master/docs/assets/banner.png',
          ),
          const SizedBox(height: 16),
          NZNavBar.search(
            title: '搜索文档...',
            onSearch: () {},
            onSearchChanged: (v) {},
          ),
          const SizedBox(height: 16),
          Builder(
            builder: (context) => NZNavBar.miniApp(
              title: '小程序模式',
              onMiniAppShare: () => NZToast.show(context, message: '分享点击'),
              onMiniAppClose: () => NZToast.show(context, message: '关闭点击'),
            ),
          ),
          const SizedBox(height: 16),
          NZNavBar(
            title: '自定义动作',
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      content: 'NZNavBar 是一个高度可定制的导航栏组件，提供了多种内置模式，完美适配各种业务场景。',
      code: '''// 1. 标准模式
const NZNavBar(title: '标题');

// 2. Logo 模式
const NZNavBar.logo(
  title: '品牌名称',
  logoUrl: 'https://...',
);

// 3. 搜索模式
NZNavBar.search(
  title: '搜索内容',
  onSearch: () {
    // 触发搜索
  },
  onSearchChanged: (value) {
    // 监听输入变化
  },
);

// 4. 小程序胶囊模式
NZNavBar.miniApp(
  title: '小程序标题',
  onMiniAppShare: () => print('分享'),
  onMiniAppClose: () => print('关闭'),
);

// 5. 自定义动作
NZNavBar(
  title: '设置',
  actions: [
    IconButton(icon: Icon(Icons.save), onPressed: () {}),
  ],
);''',
    ),
    NZDocSection(
      id: 'ProgressButton',
      title: '进度按钮 (ProgressButton)',
      icon: Icons.hourglass_top_rounded,
      description: '带有实时进度条背景的按钮，适用于下载、上传或耗时操作。',
      usage: [
        ['progress', 'double', '进度值 (0.0 到 1.0)'],
        ['onPressed', 'VoidCallback?', '点击回调'],
        ['label', 'String?', '按钮文本'],
        ['child', 'Widget?', '自定义按钮内容'],
        ['color', 'Color?', '进度条填充颜色'],
        ['backgroundColor', 'Color?', '按钮背景底色'],
        ['foregroundColor', 'Color?', '文本/图标颜色'],
        ['width', 'double?', '按钮宽度'],
        ['height', 'double', '按钮高度 (默认 48.0)'],
        ['borderRadius', 'double', '圆角半径 (默认 12.0)'],
        ['block', 'bool', '是否撑满宽度'],
      ],
      preview: StatefulBuilder(
        builder: (context, setState) {
          double p = 0.65;
          return Column(
            children: [
              NZProgressButton(
                progress: p,
                label: '系统更新中 ${(p * 100).toInt()}%',
                onPressed: () {
                  NZToast.show(context, message: '正在检查更新...');
                },
                block: true,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: NZProgressButton(
                      progress: 0.3,
                      label: '上传资源',
                      color: Colors.orange,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: NZProgressButton(
                      progress: 1.0,
                      label: '同步完成',
                      color: Colors.green,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              NZProgressButton(
                progress: 0.4,
                backgroundColor: Colors.blueGrey.shade50,
                color: Colors.blueGrey.shade300,
                onPressed: () {},
                block: true,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_download_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text('自定义内容按钮'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              NZText.caption('提示：进度按钮常用于显示耗时操作的即时状态反馈。'),
            ],
          );
        },
      ),
      content: 'NZProgressButton 通过 Stack 实现，底层是进度填充层，顶层是交互层，提供直观的状态反馈。',
      code: '''// 基础用法
NZProgressButton(
  progress: 0.45,
  label: '下载中 45%',
  onPressed: () {},
);

// 自定义颜色和全宽
NZProgressButton(
  progress: 0.8,
  label: '上传中',
  color: Colors.orange,
  block: true,
  onPressed: () {},
);

// 自定义内容 (Child Widget)
NZProgressButton(
  progress: 0.3,
  color: Colors.blue,
  onPressed: () {},
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Icon(Icons.download, color: Colors.white),
      SizedBox(width: 8),
      Text('自定义内容'),
    ],
  ),
);

// 完成状态
NZProgressButton(
  progress: 1.0,
  label: '已完成',
  color: Colors.green,
  onPressed: () {},
);''',
    ),
    NZDocSection(
      id: 'ImageButton',
      title: '图片按钮 (ImageButton)',
      icon: Icons.image_rounded,
      description: '使用图片作为背景的交互按钮，支持透明度遮罩和文字标签。',
      usage: [
        ['image', 'ImageProvider', '背景图片资源'],
        ['label', 'String?', '按钮中心显示的文本'],
        ['onPressed', 'VoidCallback?', '点击回调'],
        ['opacity', 'double', '图片不透明度 (默认 0.8)'],
        ['height', 'double', '按钮高度 (默认 180.0)'],
        ['borderRadius', 'double', '圆角半径 (默认 12.0)'],
        ['block', 'bool', '是否撑满宽度'],
      ],
      preview: Column(
        children: [
          NZImageButton(
            image: const NetworkImage(
              'https://picsum.photos/seed/nezha/800/400',
            ),
            label: '点击探索',
            block: true,
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          NZImageButton(
            image: const NetworkImage('https://picsum.photos/seed/ui/800/400'),
            label: '立即开启',
            opacity: 0.6,
            height: 120,
            block: true,
            onPressed: () {},
          ),
        ],
      ),
      content: 'NZImageButton 适合用于画廊、卡片入口或需要强视觉吸引力的点击区域。',
      code: '''NZImageButton(
  image: NetworkImage('https://...'),
  label: '探索更多',
  onPressed: () {},
  block: true,
);''',
    ),
    NZDocSection(
      id: 'DraggableButton',
      title: '拖拽按钮 (DraggableButton)',
      icon: Icons.drag_indicator_rounded,
      description: '可以在屏幕范围内自由拖动的悬浮组件。',
      usage: [
        ['child', 'Widget', '要拖动的子组件'],
        ['onTap', 'VoidCallback?', '点击回调'],
        ['initialPosition', 'Offset', '初始位置偏移量'],
      ],
      preview: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Stack(
          children: [
            Center(child: NZText.caption('在此区域内尝试拖拽下方按钮')),
            NZDraggableButton(
              initialPosition: const Offset(20, 120),
              onTap: () => NZToast.show(context, message: '点击了悬浮球'),
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: NZColor.nezhaPrimary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.ads_click_rounded, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      content: 'NZDraggableButton 支持平滑的拖拽交互，并会自动吸附到屏幕边缘（如果需要）。',
      code: '''NZDraggableButton(
  initialPosition: Offset(20, 100),
  onTap: () => print('点击'),
  child: MyFloatingWidget(),
);''',
    ),
    NZDocSection(
      id: 'Toast',
      title: '提示 (Toast)',
      icon: Icons.notifications_active_rounded,
      description: '轻量级的全局反馈组件，支持多种类型，模仿微信小程序风格设计。',
      usage: [
        ['message', 'String', '提示文本内容'],
        ['type', 'NZToastType', '类型：success, error, loading, info, text'],
        ['duration', 'Duration', '显示时长（默认 2 秒，loading 模式需手动关闭）'],
        ['mask', 'bool', '是否显示透明遮罩，防止穿透点击'],
      ],
      preview: Builder(
        builder: (context) => Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            NZButton.primary(
              label: '成功提示',
              onPressed: () => NZToast.success(context, '操作成功'),
            ),
            NZButton.outline(
              label: '加载中',
              onPressed: () {
                NZToast.loading(context, '正在加载');
                Future.delayed(const Duration(seconds: 2), () {
                  NZToast.hide();
                });
              },
            ),
            NZButton.outline(
              label: '错误提示',
              onPressed: () => NZToast.error(context, '提交失败'),
            ),
            NZButton.outline(
              label: '纯文字',
              onPressed: () => NZToast.show(context, message: '这是一条普通消息'),
            ),
          ],
        ),
      ),
      content: 'NZToast 通过 Overlay 实现全局显示，支持多种交互状态反馈。',
      code: '''// 成功提示
NZToast.success(context, '操作成功');

// 加载中提示（需手动 hide）
NZToast.loading(context, '正在加载');
// ... 执行异步操作
NZToast.hide();

// 错误提示
NZToast.error(context, '提交失败');

// 自定义配置
NZToast.show(
  context,
  message: '自定义消息',
  type: NZToastType.info,
  duration: Duration(seconds: 3),
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
    NZDocSection(
      id: 'SwipeListTile',
      title: '滑动单元格 (SwipeListTile)',
      icon: Icons.swipe_rounded,
      description: '支持多方向滑动的列表项操作组件，提供丝滑的交互体验。',
      usage: [
        ['child', 'Widget', '单元格内容'],
        ['leftActions', 'List<NZSwipeAction>', '右滑显示的按钮列表'],
        ['rightActions', 'List<NZSwipeAction>', '左滑显示的按钮列表'],
        ['topActions', 'List<NZSwipeAction>', '下滑显示的按钮列表'],
        ['bottomActions', 'List<NZSwipeAction>', '上滑显示的按钮列表'],
        ['onTap', 'VoidCallback?', '点击单元格回调'],
        ['onLongPress', 'VoidCallback?', '长按单元格回调'],
        ['disabled', 'bool', '是否禁用滑动交互'],
      ],
      preview: Column(
        children: [
          NZSwipeListTile(
            rightActions: [
              NZSwipeAction(
                label: '删除',
                backgroundColor: Colors.red,
                icon: const Icon(Icons.delete_outline_rounded),
                onTap: () {},
              ),
            ],
            child: const ListTile(
              title: Text('左滑试试'),
              subtitle: Text('可以滑出删除按钮'),
            ),
          ),
          const Divider(height: 1),
          NZSwipeListTile(
            leftActions: [
              NZSwipeAction(
                label: '收藏',
                backgroundColor: Colors.orange,
                icon: const Icon(Icons.star_rounded),
                onTap: () {},
              ),
            ],
            child: const ListTile(
              title: Text('右滑试试'),
              subtitle: Text('可以滑出收藏按钮'),
            ),
          ),
        ],
      ),
      content:
          'NZSwipeListTile 模拟了原生移动端和微信小程序的滑动交互逻辑。它能够自动处理手势冲突，并支持在四个方向上配置独立的操作按钮。每个操作按钮都可以自定义图标、文字和背景色。',
      code: '''NZSwipeListTile(
   rightActions: [
     NZSwipeAction(
       label: '删除',
       backgroundColor: Colors.red,
       icon: Icon(Icons.delete),
       onTap: () => debugPrint('Delete'),
     ),
   ],
   child: ListTile(title: Text('滑动操作')),
 )''',
    ),
    NZDocSection(
      id: 'PopUp',
      title: '弹窗 (PopUp)',
      icon: Icons.chat_bubble_outline_rounded,
      description: '微信风格的对话框组件，用于重要的交互提示或确认操作。',
      usage: [
        ['title', 'String?', '弹窗标题'],
        ['content', 'String?', '弹窗内容描述'],
        ['actions', 'List<NZPopUpAction>', '操作按钮列表'],
        ['actionsAxis', 'Axis', '按钮排列方向'],
      ],
      preview: Builder(
        builder: (context) => Column(
          children: [
            NZButton.primary(
              label: '显示确认弹窗',
              block: true,
              onPressed: () {
                NZPopUp.confirm(
                  context,
                  title: '确认提交',
                  content: '提交后将无法修改，是否确认继续？',
                  onConfirm: () => NZToast.show(context, message: '已确认提交'),
                );
              },
            ),
            const SizedBox(height: 12),
            NZButton.secondary(
              label: '显示警示弹窗',
              block: true,
              onPressed: () {
                NZPopUp.confirm(
                  context,
                  title: '删除提示',
                  content: '确定要删除这条重要数据吗？此操作不可撤销。',
                  confirmLabel: '删除',
                  isDestructive: true,
                  onConfirm: () => NZToast.show(context, message: '数据已删除'),
                );
              },
            ),
          ],
        ),
      ),
      content:
          'NZPopUp 遵循微信小程序的视觉设计规范，提供一致的确认和提示体验。它支持横向和纵向的按钮排列，并能自动处理圆角和边框细节。',
      code: '''NZPopUp.confirm(
   context,
   title: '确认提交',
   content: '提交后将无法修改，是否确认继续？',
   onConfirm: () => print('已确认'),
 );''',
    ),
    NZDocSection(
      id: 'NoticeBar',
      title: '公告栏 (NoticeBar)',
      icon: Icons.campaign_rounded,
      description: '用于循环播放重要信息。支持水平/垂直滚动，内置金融新闻等多种专业样式。',
      usage: [
        ['text', 'List<String>', '公告内容列表'],
        [
          'theme',
          'NZNoticeBarTheme',
          '样式主题：warning, success, error, info, finance',
        ],
        ['direction', 'NZNoticeBarDirection', '滚动方向：horizontal, vertical'],
        ['speed', 'double', '滚动速度 (仅水平模式)'],
        ['icon', 'Widget?', '前置图标'],
      ],
      preview: const Column(
        children: [
          NZNoticeBar(
            text: ['这是一条标准的水平滚动公告，用于展示重要的通知信息。'],
            icon: Icon(Icons.campaign_rounded),
          ),
          SizedBox(height: 12),
          NZNoticeBar(
            theme: NZNoticeBarTheme.finance,
            text: ['[行情] 沪深300指数今日上涨 1.25%，科技板块领涨市场。'],
            icon: Icon(Icons.trending_up_rounded),
          ),
        ],
      ),
      content:
          'NZNoticeBar 提供了丰富的配置项，能够满足从简单的通知提醒到专业的金融行情展示等多种场景。它支持平滑的水平滚动和带有动画效果的垂直翻页。',
      code: '''NZNoticeBar(
   theme: NZNoticeBarTheme.finance,
   text: ['沪深300指数今日上涨 1.25%'],
   icon: Icon(Icons.trending_up),
 )''',
    ),
    NZDocSection(
      id: 'KPan',
      title: 'K线盘面 (KPan)',
      icon: Icons.candlestick_chart_rounded,
      description: '专业级金融 K 线图表组件，支持多种蜡烛样式、技术指标和高度交互。',
      usage: [
        ['data', 'List<KLineData>', 'K线数据列表'],
        ['symbol', 'String', '交易对/标的名称'],
        ['isChinaStyle', 'bool', '配色风格：true (红涨绿跌), false (绿涨红跌)'],
        [
          'style',
          'KLineStyle',
          '蜡烛样式：solid (实心), hollow (空心), line (线图), ohlc (美国线)',
        ],
        ['indicators', 'Set<KLineIndicator>', '开启的技术指标：ma, ema, vol, macd 等'],
        ['height', 'double', '图表容器高度'],
        ['gridColor', 'Color?', '背景网格颜色'],
        ['onCrosshairChanged', 'ValueChanged<KLineData?>?', '十字光标移动时的回调'],
      ],
      preview: NZKPan(
        symbol: 'XIAOMI',
        style: KLineStyle.hollow,
        height: 350,
        data: () {
          final List<KLineData> result = [];
          double lastClose = 150.0;
          final random = Random();
          for (int i = 0; i < 100; i++) {
            final double open = lastClose;
            final double change = (random.nextDouble() - 0.48) * 4.0;
            final double close = open + change;
            final double high = max(open, close) + random.nextDouble() * 2.0;
            final double low = min(open, close) - random.nextDouble() * 2.0;
            final double vol = 10000 + random.nextDouble() * 20000;
            result.add(
              KLineData(
                time: DateTime.now().subtract(Duration(minutes: 100 - i)),
                open: open,
                high: high,
                low: low,
                close: close,
                volume: vol,
              ),
            );
            lastClose = close;
          }
          return result;
        }(),
      ),
      content:
          'NZKPan 是为金融应用量身定制的高性能图表组件。它内置了十字光标交互、缩放平移以及多种专业技术指标，能够完美适配行情分析场景。',
      code: '''// 基础用法
NZKPan(
  symbol: 'BTC/USDT',
  data: klineDataList,
)

// 高级配置
NZKPan(
  symbol: 'ETH/USDT',
  style: KLineStyle.hollow,
  isChinaStyle: false, // 国际配色
  indicators: {
    KLineIndicator.ma,
    KLineIndicator.vol,
  },
  height: 450,
  data: klineDataList,
)''',
    ),
    NZDocSection(
      id: 'DropDownMenu',
      title: '下拉菜单 (DropDownMenu)',
      icon: Icons.arrow_drop_down_circle_rounded,
      description: '微信风格的下拉选择菜单，使用项目主色调作为强调色。',
      usage: [
        ['items', 'List<NZDropDownMenuItem<T>>', '菜单选项列表'],
        ['value', 'T?', '当前选中的值'],
        ['onChanged', 'ValueChanged<T?>?', '选中项改变时的回调'],
        ['hint', 'String', '占位文本（默认“请选择”）'],
        ['type', 'NZDropDownMenuType', '样式类型（outline, filled, borderless）'],
        ['size', 'NZDropDownMenuSize', '尺寸（small, medium, large）'],
        ['isExpanded', 'bool', '是否强制占据父容器宽度'],
        ['activeColor', 'Color?', '激活状态的颜色'],
      ],
      preview: StatefulBuilder(
        builder: (context, setState) {
          String? selectedValue;
          String? selectedValue2;
          String? selectedValue3;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NZText.caption('基础用法 (Medium Outline)'),
              const SizedBox(height: 8),
              NZDropDownMenu<String>(
                value: selectedValue,
                hint: '选择操作',
                items: const [
                  NZDropDownMenuItem(
                    value: 'edit',
                    label: '编辑资料',
                    icon: Icons.edit_outlined,
                  ),
                  NZDropDownMenuItem(
                    value: 'share',
                    label: '分享好友',
                    icon: Icons.share_outlined,
                  ),
                ],
                onChanged: (val) => setState(() => selectedValue = val),
              ),
              const SizedBox(height: 24),
              NZText.caption('填充样式 (Small Filled)'),
              const SizedBox(height: 8),
              NZDropDownMenu<String>(
                value: selectedValue2,
                type: NZDropDownMenuType.filled,
                size: NZDropDownMenuSize.small,
                hint: '排序方式',
                items: const [
                  NZDropDownMenuItem(value: 'new', label: '最新优先'),
                  NZDropDownMenuItem(value: 'hot', label: '最热优先'),
                ],
                onChanged: (val) => setState(() => selectedValue2 = val),
              ),
              const SizedBox(height: 24),
              NZText.caption('通栏展示 (Large Outline)'),
              const SizedBox(height: 8),
              NZDropDownMenu<String>(
                value: selectedValue3,
                isExpanded: true,
                size: NZDropDownMenuSize.large,
                hint: '选择收货地址',
                items: const [
                  NZDropDownMenuItem(value: 'home', label: '我的家'),
                  NZDropDownMenuItem(value: 'company', label: '公司地址'),
                ],
                onChanged: (val) => setState(() => selectedValue3 = val),
              ),
            ],
          );
        },
      ),
      content: 'NZDropDownMenu 模拟了微信原生的下拉交互体验，通过 Overlay 实现浮层显示，确保不会被父容器裁剪。',
      code: '''NZDropDownMenu<String>(
  value: _selected,
  hint: '请选择',
  items: const [
    NZDropDownMenuItem(value: '1', label: '选项一', icon: Icons.star),
    NZDropDownMenuItem(value: '2', label: '选项二', icon: Icons.settings),
  ],
  onChanged: (val) => setState(() => _selected = val),
)''',
    ),
    NZDocSection(
      id: 'Dialog',
      title: '对话框 (NZDialog)',
      icon: Icons.picture_in_picture_alt_rounded,
      description: '多功能、多样式的对话框组件，支持超过 10 种内置类型。',
      usage: [
        [
          'type',
          'NZDialogType',
          '内置样式类型：basic, confirm, success, error, warning, info, input, loading, progress, image, status',
        ],
        ['title', 'String?', '对话框标题'],
        ['message', 'String?', '对话框正文消息'],
        ['actions', 'List<NZDialogAction>?', '自定义按钮列表'],
        ['icon', 'IconData?', '顶部图标'],
        ['progress', 'double?', '进度条数值 (0.0 - 1.0)'],
      ],
      preview: Builder(
        builder: (context) => Column(
          children: [
            NZButton.primary(
              label: '显示确认对话框',
              block: true,
              onPressed: () => NZDialog.confirm(context, '这是一个专业的确认对话框，感觉如何？'),
            ),
            const SizedBox(height: 12),
            NZButton.outline(
              label: '显示输入对话框',
              block: true,
              onPressed: () =>
                  NZDialog.input(context, title: '设置昵称', hintText: '请输入你的温柔昵称'),
            ),
          ],
        ),
      ),
      content:
          'NZDialog 是 NezhaUI 中最强大的反馈组件之一。它集成了各种常见的交互场景，从基础的消息提示到复杂的表单输入、进度展示，都能通过简单的静态方法调用。',
      code: '''// 1. 成功提示
NZDialog.success(context, '操作已完成');

// 2. 确认操作
bool? ok = await NZDialog.confirm(context, '确认删除吗？');

// 3. 输入内容
String? text = await NZDialog.input(context, title: '反馈');

// 4. 进度展示
NZDialog.progress(context, 0.5, title: '上传中');''',
    ),
    NZDocSection(
      id: 'Steps',
      title: '步骤条 (Steps)',
      icon: Icons.linear_scale_rounded,
      description: '专业步骤条组件，用于展示任务进度或引导用户完成流程。',
      usage: [
        ['steps', 'List<NZStep>', '步骤配置列表'],
        ['current', 'int', '当前进行的步骤索引 (从 0 开始)'],
        ['direction', 'Axis', '排列方向：horizontal, vertical'],
        ['color', 'Color?', '激活步骤的主色调'],
      ],
      preview: Column(
        children: [
          const NZSteps(
            current: 1,
            steps: [
              NZStep(title: '第一步', description: '填写基本信息'),
              NZStep(title: '第二步', description: '上传身份证明'),
              NZStep(title: '第三步', description: '审核通过'),
            ],
          ),
          const SizedBox(height: 32),
          const NZSteps(
            direction: Axis.vertical,
            current: 0,
            steps: [
              NZStep(title: '订单提交', description: '2024-03-20 10:00'),
              NZStep(title: '仓库打包', description: '预计 1 小时内完成'),
              NZStep(title: '等待揽收'),
            ],
          ),
        ],
      ),
      content: 'NZSteps 支持水平和垂直两种展示模式，能够清晰地传达复杂任务的当前状态和后续步骤。',
      code: '''// 水平步骤条
NZSteps(
  current: 1,
  steps: [
    NZStep(title: '步骤1'),
    NZStep(title: '步骤2'),
  ],
)

// 垂直步骤条
NZSteps(
  direction: Axis.vertical,
  current: 0,
  steps: [
    NZStep(title: '已完成'),
    NZStep(title: '进行中'),
  ],
)''',
    ),
    NZDocSection(
      id: 'Pagination',
      title: '分页器 (Pagination)',
      icon: Icons.last_page_rounded,
      description: '将大量数据分割成多页展示，支持直接跳转、上一页/下一页、多种形状和样式、滚动模式等。',
      usage: [
        ['total', 'int', '总条目数'],
        ['pageSize', 'int', '每页条数 (默认 10)'],
        ['current', 'int', '当前页码 (从 1 开始)'],
        ['onPageChanged', 'ValueChanged<int>?', '页码切换回调'],
        ['shape', 'NZPaginationShape', '形状: square, circle'],
        ['type', 'NZPaginationType', '类型: filled, outline, light'],
        ['showQuickJumper', 'bool', '是否显示快速跳转'],
        ['scrollable', 'bool', '是否开启滚动模式'],
        ['disabled', 'bool', '是否禁用'],
      ],
      preview: Column(
        children: [
          NZPagination(total: 100, current: 1, onPageChanged: (p) {}),
          const SizedBox(height: 12),
          NZPagination(
            total: 100,
            current: 2,
            shape: NZPaginationShape.circle,
            type: NZPaginationType.outline,
            onPageChanged: (p) {},
          ),
          const SizedBox(height: 12),
          NZPagination(
            total: 100,
            current: 3,
            type: NZPaginationType.light,
            showQuickJumper: true,
            onPageChanged: (p) {},
          ),
        ],
      ),
      content:
          'NZPagination 提供了丰富的配置项，能够满足移动端各种分页场景的需求。推荐在页码较多时开启 scrollable 模式或使用默认的省略号逻辑。',
      code: '''// 基础用法
NZPagination(
  total: 100,
  current: 1,
  onPageChanged: (page) => debugPrint(page.toString()),
)

// 圆形描边 + 快速跳转
NZPagination(
  total: 100,
  shape: NZPaginationShape.circle,
  type: NZPaginationType.outline,
  showQuickJumper: true,
  onPageChanged: (page) => debugPrint(page.toString()),
)''',
    ),
    NZDocSection(
      id: 'Masonry',
      title: '瀑布流布局 (NZMasonry)',
      icon: Icons.dashboard_customize_rounded,
      description:
          '专业级瀑布流布局组件，支持多列等宽不等高排列、交错入场动画、Builder 模式以及滚动监听。完美适配图片墙、商品流等高度动态变化的场景。',
      usage: [
        ['children', 'List<Widget>?', '子组件列表 (基础模式，适用于静态少量数据)'],
        ['itemBuilder', 'IndexedWidgetBuilder?', '子组件构建器 (推荐模式，支持海量数据和动画)'],
        ['itemCount', 'int?', '组件总数 (Builder 模式必填)'],
        ['crossAxisCount', 'int', '排列列数 (默认: 2)'],
        ['mainAxisSpacing', 'double', '垂直方向（主轴）间距 (默认: 8.0)'],
        ['crossAxisSpacing', 'double', '水平方向（交叉轴）间距 (默认: 8.0)'],
        ['padding', 'EdgeInsetsGeometry?', '容器内边距'],
        ['animate', 'bool', '是否启用交错入场渐显动画 (默认: true)'],
        ['animationDuration', 'Duration', '入场动画持续时间 (默认: 300ms)'],
        ['shrinkWrap', 'bool', '是否根据内容自动调整容器高度'],
        ['physics', 'ScrollPhysics?', '滚动物理效果配置'],
        ['controller', 'ScrollController?', '滚动控制器，用于监听滚动或控制跳转'],
      ],
      preview: Container(
        height: 450,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: NZMasonry.builder(
            itemCount: 12,
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            padding: const EdgeInsets.all(12),
            animate: true,
            itemBuilder: (context, index) {
              final heights = [120.0, 180.0, 140.0, 200.0, 160.0, 130.0];
              final colors = [
                Colors.blue,
                Colors.indigo,
                Colors.purple,
                Colors.teal,
                Colors.orange,
                Colors.pink,
              ];
              final color = colors[index % colors.length];
              final height = heights[index % heights.length];

              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: color.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: height,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.05),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.auto_awesome_mosaic_rounded,
                          color: color.withValues(alpha: 0.3),
                          size: 32,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NZText.subtitle('发现精彩 #$index'),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              NZTag(
                                label: '推荐',
                                size: NZTagSize.small,
                                color: color,
                                style: NZTagStyle.soft,
                              ),
                              const Spacer(),
                              Icon(
                                Icons.favorite_border_rounded,
                                size: 14,
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      content:
          'NZMasonry 是 NezhaUI 提供的核心布局组件。它通过智能算法将子组件分配到高度最小的列中，从而实现瀑布流效果。与传统的 GridView 不同，它允许每个子组件拥有不同的高度，非常适合用于展示内容丰富、形式多样的信息流。',
      code: '''// 1. 高级用法 (Builder 模式 + 动画)
NZMasonry.builder(
  itemCount: items.length,
  crossAxisCount: 2, // 两列显示
  mainAxisSpacing: 12.0,
  crossAxisSpacing: 12.0,
  animate: true, // 开启入场动画
  itemBuilder: (context, index) {
    return MyMasonryCard(item: items[index]);
  },
)

// 2. 基础用法 (列表模式)
NZMasonry(
  crossAxisCount: 3,
  children: [
    ImageCard(height: 200),
    ImageCard(height: 150),
    ImageCard(height: 250),
  ],
)''',
    ),
  ];

  static Widget _buildDrawerContent(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NZText.h3(title),
          const SizedBox(height: 16),
          NZText.body('此处放置上下文相关内容。'),
          const SizedBox(height: 32),
          NZButton.primary(
            label: '确认并关闭',
            block: true,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
