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
          id: 'Home',
          title: 'NezhaUI',
          subtitle: '轻量、优雅且专业的 Flutter 移动端组件库',
          isLanding: true,
          icon: Icons.home_rounded,
          content: '''NezhaUI 是一套基于 Flutter 构建的移动端设计系统，致力于为现代应用开发提供丝滑、灵敏且高度可定制性。

### 核心理念
- **极致性能**：每个组件都经过细致的调优，确保在低端设备上也能保持流畅。
- **专业美学**：遵循现代设计规范，提供一致且高级的视觉体验。
- **高度定制**：深度集成 NZTheme 系统，轻松适配各种品牌风格。''',
          github: 'https://github.com/ctkqiang/nezha_ui.git',
        ),
        NZDocSection(
          id: 'About',
          title: '关于 NezhaUI',
          subtitle: '轻量、优雅且专业的 Flutter 移动端组件库',
          isLanding: true,
          icon: Icons.info_outline_rounded,
          content: '''NezhaUI 不仅仅是一个组件库，它是我们对技术追求与工程实践的结合。

### 我们的愿景
让每一位开发者在编写代码时，都能感受到高效与便捷。每一个像素、每一行代码，都体现了我们对产品质量的极致追求。

### 贡献团队
- **核心团队**：负责核心架构与技术把关。
- **设计团队**：负责创意设计与视觉呈现。''',
        ),
        NZDocSection(
          id: 'Text',
          title: 'Text 文本排版',
          icon: Icons.text_fields_rounded,
          description: '高度规范化的排版组件，内置多种预设样式。',
          usage: [
            ['data', 'String', '需要显示的文本内容'],
            ['color', 'Color?', '自定义文字颜色'],
            ['textAlign', 'TextAlign?', '对齐方式'],
            ['maxLines', 'int?', '最大行数限制'],
            ['overflow', 'TextOverflow?', '溢出处理方式'],
          ],
          preview: Column(
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
          content: 'NZText 是 NezhaUI 的核心排版组件，封装了 Material Design 的文字排版规范。',
          code: '''// 各种级别的标题
NZText.h1('大标题');
NZText.h2('中标题');

// 副标题和正文
NZText.subtitle('副标题');
NZText.body('这是一段正文内容');''',
        ),
        NZDocSection(
          id: 'Buttons',
          title: 'Button 按钮',
          icon: Icons.smart_button_rounded,
          description: '基础交互组件，支持多种样式、状态及自定义内容。',
          usage: [
            ['onPressed', 'VoidCallback?', '点击回调，为 null 时按钮处于禁用状态'],
            ['label', 'String?', '按钮显示的文本内容'],
            ['style', 'NZButtonStyle', '内置样式：primary, secondary, outline, text'],
            ['isLoading', 'bool', '是否显示加载动画'],
          ],
          preview: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NZButton.primary(label: '主要按钮', onPressed: () {}),
              const SizedBox(height: 16),
              NZButton.secondary(label: '次要按钮', onPressed: () {}),
              const SizedBox(height: 16),
              NZButton.outline(label: '描边按钮', onPressed: () {}),
            ],
          ),
          content: 'NZButton 提供了丰富的交互反馈和多种视觉预设。',
          code: '''NZButton.primary(
  label: '主要按钮',
  onPressed: () => print('点击了'),
);''',
        ),
        NZDocSection(
          id: 'Drawer',
          title: 'Drawer 抽屉',
          icon: Icons.menu_open_rounded,
          description: '灵活的抽屉组件，支持四个方向弹出。',
          usage: [
            ['child', 'Widget', '内容'],
            ['position', 'NZDrawerPosition', '方向'],
          ],
          preview: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NZButton.primary(
                label: '打开左侧抽屉',
                onPressed: () => NZDrawer.show(
                  context: context,
                  position: NZDrawerPosition.left,
                  child: const Center(child: Text('左侧抽屉')),
                ),
              ),
            ],
          ),
          content: 'NZDrawer 用于临时显示辅助内容或导航。',
          code: '''NZDrawer.show(
  context: context,
  position: NZDrawerPosition.left,
  child: MyWidget(),
);''',
        ),
        NZDocSection(
          id: 'Divider',
          title: 'Divider 分割线',
          icon: Icons.horizontal_rule_rounded,
          description: '用于分割内容的水平线，支持高度、厚度及缩进控制。',
          usage: [
            ['height', 'double', '分割线所占的垂直高度'],
            ['thickness', 'double', '分割线的粗细'],
            ['indent', 'double?', '左侧缩进距离'],
            ['endIndent', 'double?', '右侧缩进距离'],
            ['color', 'Color?', '自定义分割线颜色'],
          ],
          preview: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NZText.body('上方内容'),
              const NZDivider(),
              NZText.body('中间内容 (默认样式)'),
              const NZDivider(height: 32, thickness: 2, color: Colors.blue),
              NZText.body('下方内容 (自定义样式)'),
            ],
          ),
          content: 'NZDivider 是 NezhaUI 提供的基础视觉分割组件。',
          code: '''// 基础用法
const NZDivider()

// 自定义样式
NZDivider(
  height: 32,
  thickness: 2,
  color: Colors.blue,
  indent: 16,
  endIndent: 16,
)''',
        ),
        NZDocSection(
          id: 'BackToTop',
          title: 'BackToTop 回到顶部',
          icon: Icons.vertical_align_top_rounded,
          description: '当页面滚动到一定距离时出现，点击可快速返回顶部。',
          usage: [
            ['scrollController', 'ScrollController', '绑定的滚动控制器'],
            ['threshold', 'double', '显示按钮的滚动距离阈值'],
            ['duration', 'Duration', '滚动动画时长'],
          ],
          preview: Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text('由于文档环境限制，请在实际长页面中使用预览'),
            ),
          ),
          content: 'NZBackToTop 是提升长页面用户体验的必备组件。',
          code: '''NZBackToTop(
  scrollController: _scrollController,
  threshold: 200,
  child: Icon(Icons.arrow_upward),
)''',
        ),
        NZDocSection(
          id: 'FloatingActionButton',
          title: 'FAB 悬浮按钮',
          icon: Icons.add_circle_outline_rounded,
          description: '多功能悬浮按钮，支持图标、文字、图片背景及拖动功能。',
          usage: [
            ['type', 'NZFloatingActionButtonType', '按钮类型：standard, icon, image'],
            ['draggable', 'bool', '是否开启拖动'],
            ['scrollController', 'ScrollController?', '绑定后可实现滚动隐藏'],
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
                label: '写文章',
                onPressed: () {},
              ),
            ],
          ),
          content: 'NZFloatingActionButton 提供了比原生 FAB 更强大的定制能力。',
          code: '''// 图标样式
NZFloatingActionButton.icon(
  icon: Icon(Icons.add),
  onPressed: () {},
)

// 带文字样式
NZFloatingActionButton.standard(
  icon: Icon(Icons.add),
  label: '添加',
  onPressed: () {},
)''',
        ),
        NZDocSection(
          id: 'Markdown',
          title: 'Markdown 渲染',
          icon: Icons.description_rounded,
          description: '原生实现的轻量级 Markdown 渲染组件，支持基础语法解析。',
          usage: [
            ['data', 'String', 'Markdown 源码'],
            ['style', 'NZMarkdownStyle?', '自定义渲染样式'],
          ],
          preview: const NZMarkdown(
            data: '''### Markdown 示例
- 支持**加粗**和*斜体*
- 支持`行内代码`
- 支持引用块
> 这是一段引用文本''',
          ),
          content: 'NZMarkdown 无需第三方依赖，适用于简单的文档展示。',
          code: '''NZMarkdown(
  data: '# 标题\\n这是一段**加粗**文字',
)''',
        ),
        NZDocSection(
          id: 'PullToRefresh',
          title: 'PullToRefresh 下拉刷新',
          icon: Icons.refresh_rounded,
          description: '符合 NezhaUI 视觉风格的下拉刷新组件。',
          usage: [
            ['onRefresh', 'Future<void> Function()', '刷新回调'],
            ['showSpinner', 'bool', '是否显示加载圆圈'],
            ['label', 'String?', '自定义提示文本'],
          ],
          preview: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Text('下拉刷新演示（需实际滚动环境）')),
          ),
          content: 'NZPullToRefresh 封装了复杂的下拉逻辑，提供一致的交互体验。',
          code: '''NZPullToRefresh(
  onRefresh: () async {
    await Future.delayed(Duration(seconds: 2));
  },
  child: ListView(...),
)''',
        ),
        NZDocSection(
          id: 'CodeView',
          title: 'CodeView 代码预览',
          icon: Icons.code_rounded,
          description: '支持 GitHub 风格高亮的代码查看组件。',
          usage: [
            ['code', 'String', '需要显示的代码'],
            ['theme', 'NZCodeTheme', '主题：githubLight, githubDark'],
            ['showCopyButton', 'bool', '是否显示复制按钮'],
          ],
          preview: const NZCodeView(
            code: 'void main() {\n  print("Hello NezhaUI");\n}',
            theme: NZCodeTheme.githubLight,
          ),
          content: 'NZCodeView 内置了代码高亮逻辑，非常适合文档类应用。',
          code: '''NZCodeView(
  code: 'final x = 1;',
  theme: NZCodeTheme.githubDark,
)''',
        ),
      ];
}
