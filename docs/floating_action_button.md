# NZFloatingActionButton 悬浮按钮

`NZFloatingActionButton` 是一个功能极其强大的悬浮按钮组件，不仅支持 Flutter 原生的各种 FAB 样式，还额外集成了拖拽、图片背景以及滚动隐藏等高级功能。

## 核心特性

- **多样式支持**：提供 Standard (Extended)、Icon-only、Image 三种内置模式。
- **智能拖拽 (Draggable)**：支持在屏幕上自由拖动，松手后自动吸附至屏幕边缘，交互丝滑。
- **图片背景 (Image)**：允许使用图片作为背景，并自动叠加优雅的渐变蒙层以增强对比度。
- **滚动隐藏 (Scroll to Hide)**：通过关联 `ScrollController`，在页面向下滚动时自动缩放隐藏，向上滚动时恢复显示。
- **高度定制**：背景色、前景色、英雄动画 (Hero) 等均可配置。

## 基础用法

### 1. 标准扩展样式 (Standard)

适用于需要显示“图标 + 文字”的场景。

```dart
NZFloatingActionButton.standard(
  label: '发布动态',
  icon: const Icon(Icons.add_rounded),
  onPressed: () => print('点击发布'),
)
```

### 2. 仅图标样式 (Icon)

经典的圆形图标按钮。

```dart
NZFloatingActionButton.icon(
  icon: const Icon(Icons.message_rounded),
  onPressed: () => print('点击消息'),
)
```

### 3. 图片背景样式 (Image)

使用图片作为按钮背景，非常适合头像悬浮或个性化入口。

```dart
NZFloatingActionButton.image(
  image: const NetworkImage('https://example.com/bg.jpg'),
  icon: const Icon(Icons.star_rounded), // 可选
  onPressed: () => print('点击图片按钮'),
)
```

## 进阶功能

### 1. 滚动自动隐藏

只需传入页面的 `ScrollController`，组件会自动处理显示逻辑。

```dart
NZFloatingActionButton.standard(
  label: '回到顶部',
  icon: const Icon(Icons.arrow_upward_rounded),
  scrollController: _myScrollController, // 关联控制器
  onPressed: () => _scrollToTop(),
)
```

### 2. 智能拖拽与边缘吸附

设置 `draggable: true` 即可开启拖拽功能。组件内置了边缘吸附逻辑，松手后会自动弹回最近的侧边。

```dart
NZFloatingActionButton.icon(
  icon: const Icon(Icons.support_agent_rounded),
  draggable: true,
  onPressed: () => print('呼叫助手'),
)
```

## 参数说明

| 参数 | 类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| `onPressed` | `VoidCallback` | **必填** | 点击回调函数 |
| `type` | `NZFloatingActionButtonType` | `standard` | 按钮类型 (`standard`, `icon`, `image`) |
| `icon` | `Widget?` | `null` | 显示的图标组件 |
| `label` | `String?` | `null` | 显示的文字（仅 standard 模式） |
| `image` | `ImageProvider?` | `null` | 背景图片（仅 image 模式） |
| `draggable` | `bool` | `false` | 是否开启拖拽功能 |
| `initialPosition` | `Offset` | `Offset(20, 20)` | 拖拽模式下的初始坐标 |
| `scrollController` | `ScrollController?` | `null` | 关联的滚动控制器，用于滚动隐藏 |
| `backgroundColor` | `Color?` | `NZColor.nezhaPrimary` | 按钮背景颜色 |
| `foregroundColor` | `Color?` | `Colors.white` | 图标和文字的颜色 |
| `heroTag` | `Object?` | `null` | Hero 动画标签 |
| `tooltip` | `String?` | `null` | 悬停提示文字 |

## 注意事项

- 在使用 `draggable` 模式时，建议将组件放在页面的 `Stack` 中，或者直接放在 `Scaffold` 的 `floatingActionButton` 槽位中（组件内部会自动处理 `Stack` 布局）。
- 如果同时开启了 `draggable` 和 `scrollController` 监听，请确保逻辑不会产生冲突。
