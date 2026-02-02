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
      ];
}
