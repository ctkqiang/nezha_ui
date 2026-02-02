# Markdown 渲染 (Markdown View)

`NZMarkdown` 是一个纯 Flutter 原生实现的轻量级 Markdown 解析与渲染组件。它不依赖任何第三方 Markdown 库，确保了库的纯净性与极小的体积占用。

## 特性

- **零依赖**：完全基于 Flutter 原生组件（`RichText`, `Column`, `Row` 等）构建。
- **性能卓越**：采用简单的线性扫描与正则匹配算法，渲染速度极快。
- **高度定制**：支持通过 `NZMarkdownStyle` 深度定制所有元素的视觉样式。
- **核心语法支持**：
    - 多级标题 (#, ##, ###)
    - 文本格式化（加粗、斜体）
    - 行内代码与围栏式代码块
    - 块引用 (> )
    - 无序列表 (- 或 *)
    - 水平分割线 (---)

## 基本用法

```dart
import 'package:nezha_ui/nezha.dart';

NZMarkdown(
  data: '''
# 标题
这是 **加粗** 和 *斜体*。
- 列表项 1
- 列表项 2

> 这是一个引用块。
''',
)
```

## API 参考

### NZMarkdown 属性

| 参数 | 类型 | 默认值 | 描述 |
| --- | --- | --- | --- |
| data | String | 必填 | 需要渲染的 Markdown 原始文本字符串。 |
| style | NZMarkdownStyle? | null | 样式配置对象。为 null 时使用默认主题。 |

### NZMarkdownStyle 属性

| 参数 | 类型 | 描述 |
| --- | --- | --- |
| h1 | TextStyle? | 一级标题样式。 |
| h2 | TextStyle? | 二级标题样式。 |
| h3 | TextStyle? | 三级标题样式。 |
| p | TextStyle? | 正文段落样式。 |
| code | TextStyle? | 代码字体样式。 |
| blockquote | TextStyle? | 引用块文本样式。 |
| codeBackground | Color? | 代码背景颜色。 |
| blockquoteBorderColor | Color? | 引用块左侧边框颜色。 |
| padding | EdgeInsets? | 组件整体内边距。 |

## 样式自定义示例

```dart
NZMarkdown(
  data: '# 自定义样式',
  style: NZMarkdownStyle(
    h1: TextStyle(color: Colors.blue, fontSize: 32, fontWeight: FontWeight.bold),
    codeBackground: Colors.grey[200],
    padding: EdgeInsets.all(24),
  ),
)
```
