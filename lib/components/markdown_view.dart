import 'package:flutter/material.dart';

/// NZMarkdownStyle 用于配置 [NZMarkdown] 组件的视觉样式。
///
/// 弟弟，通过这个类你可以自定义 Markdown 渲染时的标题颜色、字体大小、间距等。
class NZMarkdownStyle {
  /// 一级标题样式 (# Heading 1)
  final TextStyle? h1;

  /// 二级标题样式 (## Heading 2)
  final TextStyle? h2;

  /// 三级标题样式 (### Heading 3)
  final TextStyle? h3;

  /// 普通段落文本样式
  final TextStyle? p;

  /// 代码块及行内代码的字体样式
  final TextStyle? code;

  /// 引用块的文本样式 (> Blockquote)
  final TextStyle? blockquote;

  /// 代码块及行内代码的背景颜色
  final Color? codeBackground;

  /// 引用块左侧边框的颜色
  final Color? blockquoteBorderColor;

  /// 整个 Markdown 组件的内边距
  final EdgeInsets? padding;

  /// 创建一个自定义的 Markdown 样式配置。
  const NZMarkdownStyle({
    this.h1,
    this.h2,
    this.h3,
    this.p,
    this.code,
    this.blockquote,
    this.codeBackground,
    this.blockquoteBorderColor,
    this.padding,
  });

  /// 拷贝并生成新的样式
  NZMarkdownStyle copyWith({
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? p,
    TextStyle? code,
    TextStyle? blockquote,
    Color? codeBackground,
    Color? blockquoteBorderColor,
    EdgeInsets? padding,
  }) {
    return NZMarkdownStyle(
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      p: p ?? this.p,
      code: code ?? this.code,
      blockquote: blockquote ?? this.blockquote,
      codeBackground: codeBackground ?? this.codeBackground,
      blockquoteBorderColor:
          blockquoteBorderColor ?? this.blockquoteBorderColor,
      padding: padding ?? this.padding,
    );
  }

  /// 默认样式工厂方法，根据当前的 [BuildContext] 自动生成适配主题的样式。
  factory NZMarkdownStyle.defaultStyle(BuildContext context) {
    final theme = Theme.of(context);
    return NZMarkdownStyle(
      h1: theme.textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface,
        fontSize: 28,
      ),
      h2: theme.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface,
        fontSize: 24,
      ),
      h3: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface,
        fontSize: 20,
      ),
      p: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
        height: 1.6,
      ),
      code: TextStyle(
        fontFamily: 'monospace',
        fontSize: 14,
        color: theme.colorScheme.onSurface,
      ),
      codeBackground: theme.colorScheme.surfaceContainerHighest.withValues(
        alpha: 0.3,
      ),
      blockquote: theme.textTheme.bodyMedium?.copyWith(
        fontStyle: FontStyle.italic,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
      ),
      blockquoteBorderColor: theme.colorScheme.primary.withValues(alpha: 0.5),
      padding: const EdgeInsets.all(16),
    );
  }
}

/// [NZMarkdown] 是一个轻量级的 Markdown 渲染组件，完全使用 Flutter 原生组件实现。
///
/// 此组件不依赖任何第三方 Markdown 库，支持以下语法：
/// - 标题 (#, ##, ###)
/// - 加粗 (**text**)
/// - 斜体 (*text*)
/// - 行内代码 (`code`)
/// - 代码块 (```code```)
/// - 引用 (> quote)
/// - 无序列表 (- 或 *)
/// - 分割线 (--- 或 ***)
class NZMarkdown extends StatelessWidget {
  /// 需要渲染的 Markdown 原始文本数据。
  final String data;

  /// Markdown 的样式配置。如果为 null，将使用默认样式。
  final NZMarkdownStyle? style;

  /// 创建一个 NZMarkdown 组件。
  const NZMarkdown({super.key, required this.data, this.style});

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? NZMarkdownStyle.defaultStyle(context);
    final lines = data.split('\n');
    final List<Widget> widgets = [];

    String? codeBlock;
    List<String>? currentList;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      // 逻辑处理：优先检测代码块状态
      if (line.trim().startsWith('```')) {
        if (codeBlock == null) {
          codeBlock = ''; // 进入代码块采集模式
        } else {
          widgets.add(_buildCodeBlock(codeBlock, effectiveStyle));
          codeBlock = null; // 结束代码块采集模式
        }
        continue;
      }

      if (codeBlock != null) {
        codeBlock += '$line\n';
        continue;
      }

      // 逻辑处理：检测并采集列表项
      if (line.trim().startsWith('- ') || line.trim().startsWith('* ')) {
        currentList ??= [];
        currentList.add(line.trim().substring(2));
        continue;
      } else if (currentList != null) {
        // 如果当前行不是列表且采集器不为空，渲染之前采集的列表
        widgets.add(_buildList(currentList, effectiveStyle));
        currentList = null;
      }

      // 逻辑处理：处理空行（段落间距）
      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 12));
        continue;
      }

      // 逻辑处理：处理各种块级元素
      if (line.startsWith('# ')) {
        widgets.add(_buildHeading(line.substring(2), effectiveStyle.h1!));
      } else if (line.startsWith('## ')) {
        widgets.add(_buildHeading(line.substring(3), effectiveStyle.h2!));
      } else if (line.startsWith('### ')) {
        widgets.add(_buildHeading(line.substring(4), effectiveStyle.h3!));
      } else if (line.startsWith('> ')) {
        widgets.add(_buildBlockquote(line.substring(2), effectiveStyle));
      } else if (line.trim() == '---' || line.trim() == '***') {
        widgets.add(const Divider(height: 32));
      } else {
        // 默认为普通段落，支持行内样式解析
        widgets.add(_buildParagraph(line, effectiveStyle));
      }
    }

    // 处理文件末尾未闭合的列表项
    if (currentList != null) {
      widgets.add(_buildList(currentList, effectiveStyle));
    }

    return Padding(
      padding: effectiveStyle.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  /// 构建标题组件
  Widget _buildHeading(String text, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: style),
    );
  }

  /// 构建段落组件，支持通过 [_parseInlineStyles] 解析行内富文本
  Widget _buildParagraph(String text, NZMarkdownStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          children: _parseInlineStyles(text, style),
          style: style.p,
        ),
      ),
    );
  }

  /// 构建引用块组件
  Widget _buildBlockquote(String text, NZMarkdownStyle style) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: style.blockquoteBorderColor ?? Colors.blue,
            width: 4,
          ),
        ),
      ),
      child: Text(text, style: style.blockquote),
    );
  }

  /// 构建代码块组件
  Widget _buildCodeBlock(String code, NZMarkdownStyle style) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: style.codeBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(code.trim(), style: style.code),
    );
  }

  /// 构建无序列表组件
  Widget _buildList(List<String> items, NZMarkdownStyle style) {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• ', style: style.p?.copyWith(fontWeight: FontWeight.bold)),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: _parseInlineStyles(item, style),
                    style: style.p,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// 内部方法：利用正则表达式解析行内样式（加粗、斜体、行内代码）。
  ///
  /// 返回一个 [InlineSpan] 列表，用于 [RichText] 展示。
  List<InlineSpan> _parseInlineStyles(String text, NZMarkdownStyle style) {
    final List<InlineSpan> spans = [];
    // 正则表达式：匹配 **加粗**、*斜体*、`行内代码`
    final regExp = RegExp(r'(\*\*.*?\*\*)|(\*.*?\*)|(`.*?`)');

    int lastMatchEnd = 0;
    final matches = regExp.allMatches(text);

    for (final match in matches) {
      // 1. 添加匹配项之前的普通文本内容
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      final matchText = match.group(0)!;
      if (matchText.startsWith('**') && matchText.endsWith('**')) {
        // 解析加粗：**内容**
        spans.add(
          TextSpan(
            text: matchText.substring(2, matchText.length - 2),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      } else if (matchText.startsWith('*') && matchText.endsWith('*')) {
        // 解析斜体：*内容*
        spans.add(
          TextSpan(
            text: matchText.substring(1, matchText.length - 1),
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        );
      } else if (matchText.startsWith('`') && matchText.endsWith('`')) {
        // 解析行内代码：`内容`
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: style.codeBackground,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                matchText.substring(1, matchText.length - 1),
                style: style.code?.copyWith(fontSize: 12),
              ),
            ),
          ),
        );
      }

      lastMatchEnd = match.end;
    }

    // 2. 添加最后一次匹配之后剩余的普通文本内容
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return spans;
  }
}
