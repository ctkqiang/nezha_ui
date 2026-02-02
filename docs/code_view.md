# NZCodeView 代码查看器

`NZCodeView` 是一个轻量级且高性能的代码高亮查看组件，支持 GitHub Light 和 GitHub Dark 两种经典配色。它能够自动识别并高亮多种编程语言的通用语法，非常适合用于示例展示、文档说明或代码片段分享。

## 核心特性

- **双主题支持**：内置 GitHub Light (浅色) 和 GitHub Dark (深色) 主题。
- **多语言通用**：通过精密的正则引擎，支持 Dart, Java, C, C++, Python, JavaScript 等多种语言的关键字、字符串、注释和数字高亮。
- **自动滚动**：支持水平和垂直方向的自动溢出滚动，确保长代码行也能完美展示。
- **高性能渲染**：基于 `RichText` 优化，在大段代码下依然保持流畅。

## 基础用法

### 1. GitHub Light 主题 (默认)

最适合在白色或浅色背景的文档中使用。

```dart
NZCodeView(
  code: '''
void main() {
  print("Hello, NezhaUI!");
}
''',
  theme: NZCodeTheme.githubLight,
)
```

### 2. GitHub Dark 主题

适合深色模式或沉浸式代码展示。

```dart
NZCodeView(
  code: '''
@override
Widget build(BuildContext context) {
  return Container(
    color: Colors.blue,
  );
}
''',
  theme: NZCodeTheme.githubDark,
)
```

## 参数说明

| 参数 | 类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| `code` | `String` | **必填** | 需要高亮显示的代码文本 |
| `theme` | `NZCodeTheme` | `githubLight` | 主题模式 (`githubLight`, `githubDark`) |
| `fontSize` | `double` | `13.0` | 字体大小 |
| `padding` | `EdgeInsets` | `EdgeInsets.all(16.0)` | 内部边距 |

## 进阶示例：支持多种语言

`NZCodeView` 的高亮引擎经过特别设计，可以自动处理多种语言的通用语法，无需手动指定语言类型：

```dart
// Java 示例
const javaCode = '''
public class HelloWorld {
    public static void main(String[] args) {
        // 输出内容
        System.out.println("Hello World");
    }
}
''';

NZCodeView(code: javaCode, theme: NZCodeTheme.githubDark);
```

## 注意事项

- **等宽字体**：组件默认使用 `monospace` 字体族，建议确保运行环境下有良好的等宽字体支持。
- **性能建议**：虽然组件渲染很快，但对于超过数千行的超长代码，建议配合懒加载或分页处理。
