# NezhaUI

轻量、优雅且专业的 Flutter 移动端组件库。

[![pub package](https://img.shields.io/pub/v/nezha_ui.svg)](https://pub.dev/packages/nezha_ui)
[![license](https://img.shields.io/github/license/johnmelodyme/nezha_ui.svg)](https://github.com/johnmelodyme/nezha_ui/blob/master/LICENSE)

NezhaUI 是一套基于 Flutter 构建的移动端设计系统，致力于为现代应用开发提供丝滑、灵敏且高度可定制的 UI 组件。

## 特性

- **流畅交互**：每个组件都经过细致的性能调优，确保动画过渡自然顺滑。
- **品牌定制**：深度集成 NZTheme 系统，支持无缝切换主题与品牌色。
- **生产就绪**：提供包括按钮、分割线、下拉刷新和悬浮按钮在内的全套核心组件。
- **动态布局**：具备边缘吸附、滚动关联可见性等高级交互逻辑。
- **详尽文档**：为每个组件提供详细的 API 参考及实现示例。

## 安装

在 `pubspec.yaml` 文件中添加以下依赖：

```yaml
dependencies:
  nezha_ui: ^1.0.0
```

或者通过命令行安装：

```bash
flutter pub add nezha_ui
```

## 快速开始

使用 `NezhaApp` 初始化应用，即可接入该设计系统：

```dart
import 'package:flutter/material.dart';
import 'package:nezha_ui/nezha.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NezhaApp(
      title: 'NezhaUI 示例',
      theme: NZTheme.lightTheme,
      home: const MyHomePage(),
    );
  }
}
```

## 组件概览

### 按钮 (Buttons)
支持主要、次要、描边及文字样式，包含进度追踪和图片背景变体。

### 下拉刷新 (Pull to Refresh)
高度可定制的刷新交互，支持配置标签与加载动画。

### 悬浮按钮 (Floating Action Button)
具备滚动隐藏、自由拖拽及智能边缘吸附功能。

### 代码查看器 (Code View)
专业的语法高亮组件，内置 GitHub Light/Dark 主题，支持多语言识别。

## 文档

请参考 [docs/nezha_ui.md](docs/nezha_ui.md) 获取完整的组件指南。

- [颜色规范](docs/colors.md)
- [主题配置](docs/theme.md)
- [按钮组件](docs/button.md)
- [悬浮按钮](docs/floating_action_button.md)
- [下拉刷新](docs/pull_to_refresh.md)
- [代码查看器](docs/code_view.md)
- [分割线组件](docs/divider.md)

## 贡献

欢迎任何形式的贡献。如有改进建议，请提交 Issue 或 Pull Request。

## 开源协议

本项目基于 MIT 协议开源。
