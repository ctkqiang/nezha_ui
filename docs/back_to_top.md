# NZBackToTop 回到顶部组件

`NZBackToTop` 是一个智能的导航辅助组件。它会自动监听滚动进度，并在用户向下滚动一定距离后平滑显示，点击后可一键回到页面顶部。

---

## 核心特性

- **智能监听**：自动绑定 `ScrollController`，无需手动处理显示逻辑。
- **平滑滚动**：点击后使用预设的动画曲线平滑返回顶部，体验优雅。
- **自定义阈值**：支持自定义显示的时机（滚动像素值）。
- **多种样式**：支持图标、文字或自定义组件。

---

## 基础用法

### 1. 结合 ScrollController 使用

这是最基础的用法，需要将页面中的 `ScrollController` 传递给组件。

```dart
final _scrollController = ScrollController();

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: ListView(
      controller: _scrollController,
      children: [...],
    ),
    floatingActionButton: NZBackToTop(
      controller: _scrollController,
    ),
  );
}
```

---

## 参数说明

| 参数名 | 类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| **controller** | `ScrollController` | **必填** | 绑定的滚动控制器 |
| threshold | `double` | `400.0` | 滚动超过多少像素后显示按钮 |
| duration | `Duration` | `500ms` | 回到顶部的动画时长 |
| curve | `Curve` | `easeInOut` | 回到顶部的动画曲线 |
| child | `Widget?` | `Icon(Icons.arrow_upward)` | 按钮内部展示的组件 |

---

## 进阶使用：自定义按钮外观

你可以将 `NZBackToTop` 包装成任何你喜欢的样式：

```dart
NZBackToTop(
  controller: _scrollController,
  threshold: 200, // 更早显示
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.arrow_upward, color: Colors.white, size: 16),
        Text(' 返回顶部', style: TextStyle(color: Colors.white)),
      ],
    ),
  ),
)
```

---

## 注意事项

- **控制器一致性**：请确保传递给 `NZBackToTop` 的 `ScrollController` 与 `ListView` / `SingleChildScrollView` 使用的是同一个实例。
- **层级位置**：建议作为 `Scaffold` 的 `floatingActionButton` 使用，以获得最佳的层叠效果。
