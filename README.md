# NezhaUI

轻量、优雅且专业的 Flutter 移动端组件库。

[![pub package](https://img.shields.io/pub/v/nezha_ui.svg)](https://pub.dev/packages/nezha_ui)
[![license](https://img.shields.io/github/license/ctkqiang/nezha_ui.svg)](https://github.com/ctkqiang/nezha_ui/blob/master/LICENSE)

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

### 文本排版 (Text)
高度规范化的排版组件，内置 H1-H3 标题、副标题、正文及说明文字样式。

### 抽屉组件 (Drawer)
灵活的抽屉导航，支持从左、上、右、下四个方向弹出，支持自定义圆角与尺寸。

### 回到顶部 (BackToTop)
自动监听滚动状态，点击后平滑滚动回顶部，提升长列表阅读体验。

### 按钮 (Buttons)
支持主要、次要、描边及文字样式，包含进度追踪和图片背景变体。

### 下拉刷新 (Pull to Refresh)
高度可定制的刷新交互，支持配置标签与加载动画。

### 悬浮按钮 (Floating Action Button)
具备滚动隐藏、自由拖拽及智能边缘吸附功能。

### 代码查看器 (Code View)
专业的语法高亮组件，内置 GitHub Light/Dark 主题，支持多语言识别。

### Markdown 渲染 (Markdown View)
纯原生实现的轻量级 Markdown 解析组件，支持基础语法及高度样式定制。

### 导航栏 (NavBar)
多功能顶栏，提供标准、搜索、Logo 及小程序胶囊控制四种模式，深度适配亮/暗色主题。

### 公告栏 (NoticeBar)
用于循环播放重要信息。支持水平/垂直滚动，内置金融新闻、成功、警告等多种专业样式。

### 弹窗 (PopUp)
微信风格的对话框组件，用于重要的交互提示或确认操作。支持横向/纵向按钮排列及警示操作样式。

### 滑动操作 (Swipe Action)
模拟原生移动端滑动交互，支持左/右/上/下四个方向滑出操作按钮，完美适配各类列表操作场景。

### 进度按钮 (Progress Button)
带有实时进度条背景的按钮，适用于下载、上传或耗时操作，提供直观的状态反馈。

### 轻提示 (Toast)
简洁的全局浮层提示，支持成功、失败、加载中等多种状态，自动处理堆栈与消失逻辑。

## 文档

请参考 [docs/nezha_ui.md](docs/nezha_ui.md) 获取完整的组件指南。

- [颜色规范](docs/colors.md)
- [主题配置](docs/theme.md)
- [按钮组件](docs/button.md)
- [文本组件](docs/text.md)
- [抽屉组件](docs/drawer.md)
- [回到顶部](docs/back_to_top.md)
- [悬浮按钮](docs/floating_action_button.md)
- [下拉刷新](docs/pull_to_refresh.md)
- [代码查看器](docs/code_view.md)
- [Markdown 渲染](docs/markdown_view.md)
- [导航栏组件](docs/navbar.md)
- [分割线组件](docs/divider.md)
- [公告栏组件](docs/notice_bar.md)
- [弹窗组件](docs/pop_up.md)
- [滑动操作](docs/swipe_list_tile.md)
- [轻提示](docs/toast.md)

## 贡献

欢迎任何形式的贡献。如有改进建议，请提交 Issue 或 Pull Request。

## 开源协议

本项目基于 MIT 协议开源。
