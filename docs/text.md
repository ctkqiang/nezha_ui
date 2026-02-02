# NZText 文本排版组件

`NZText` 是一套高度规范化的排版组件，旨在为应用程序提供一致且专业的文字视觉体验。它基于 NezhaUI 的设计规范，内置了从标题到正文的多种预设样式。

---

## 核心特性

- **多级标题**：支持 `h1` 到 `h6` 六个级别的标题样式。
- **语义化**：支持 `subtitle`（副标题）、`body`（正文）、`caption`（说明文字）等语义化样式。
- **高度集成**：自动继承 `NZTheme` 的色彩方案，并支持手动覆盖颜色。
- **简洁 API**：通过命名工厂方法快速创建，代码结构优雅。

---

## 基础用法

### 1. 标题系列 (Heading)

适用于页面标题、模块标题等场景。

```dart
NZText.h1('一级标题'),
NZText.h2('二级标题'),
NZText.h3('三级标题'),
```

### 2. 正文与副标题 (Body & Subtitle)

适用于描述文字、信息展示等。

```dart
NZText.subtitle('这是一个副标题'),
NZText.body('这是标准的正文内容，具有良好的阅读间距。'),
NZText.caption('说明文字，通常用于注脚或提示。'),
```

---

## 参数说明

| 参数名 | 类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| **data** | `String` | **必填** | 需要显示的文本内容 |
| color | `Color?` | `null` | 自定义文字颜色 |
| textAlign | `TextAlign?` | `null` | 对齐方式 |
| maxLines | `int?` | `null` | 最大行数限制 |
| overflow | `TextOverflow?` | `null` | 溢出处理方式 |

---

## 工厂方法参考

| 方法名 | 字体大小 | 字重 | 说明 |
| :--- | :--- | :--- | :--- |
| `NZText.h1` | 32.0 | Bold | 页面大标题 |
| `NZText.h2` | 24.0 | Bold | 模块主标题 |
| `NZText.h3` | 20.0 | Bold | 模块次标题 |
| `NZText.h4` | 18.0 | Bold | 列表组标题 |
| `NZText.h5` | 16.0 | Bold | 小节标题 |
| `NZText.h6` | 14.0 | Bold | 极小标题 |
| `NZText.subtitle` | 16.0 | Medium | 副标题/引导语 |
| `NZText.body` | 14.0 | Normal | 标准正文 |
| `NZText.caption` | 12.0 | Normal | 辅助说明文字 |
| `NZText.overline` | 10.0 | Normal | 极细说明/标签文字 |

---

## 使用示例

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    NZText.h2('文章标题'),
    SizedBox(height: 8),
    NZText.subtitle('作者：NezhaUI', color: Colors.grey),
    SizedBox(height: 16),
    NZText.body('NezhaUI 的文本组件非常易用，能够帮助开发者快速构建美观的界面。'),
  ],
)
```
