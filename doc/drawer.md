# NZDrawer 抽屉组件

`NZDrawer` 是一个高度可定制的导航/操作容器，可以从屏幕的任意一侧（上、下、左、右）弹出。它不仅支持传统的侧边导航，还可以作为 BottomSheet 或顶部通知区域使用。

---

## 核心特性

- **全方位支持**：支持 `left` (左侧)、`right` (右侧)、`top` (顶部)、`bottom` (底部) 四个弹出位置。
- **自动适配**：对于顶部和底部弹出，会自动调整宽度为全屏；对于侧边弹出，支持自定义宽度。
- **模态交互**：内置 `show` 静态方法，轻松以模态框形式唤起。
- **自定义手势**：支持点击背景遮罩自动关闭。

---

## 基础用法

### 1. 以模态框形式弹出

这是最推荐的使用方式，可以通过简单的函数调用展示抽屉。

```dart
// 从左侧弹出
NZDrawer.show(
  context: context,
  position: NZDrawerPosition.left,
  child: MyMenuWidget(),
);

// 从底部弹出 (类似 BottomSheet)
NZDrawer.show(
  context: context,
  position: NZDrawerPosition.bottom,
  child: MyActionSheet(),
);
```

---

## 参数说明

### 1. NZDrawerPosition 枚举

| 枚举值 | 说明 |
| :--- | :--- |
| `left` | 从屏幕左侧弹出 |
| `right` | 从屏幕右侧弹出 |
| `top` | 从屏幕顶部弹出 |
| `bottom` | 从屏幕底部弹出 |

### 2. NZDrawer.show 方法参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| **context** | `BuildContext` | 是 | 上下文环境 |
| **child** | `Widget` | 是 | 抽屉内显示的内容 |
| position | `NZDrawerPosition` | 否 | 弹出位置，默认 `left` |
| width | `double?` | 否 | 抽屉宽度（仅在 left/right 时生效） |
| height | `double?` | 否 | 抽屉高度（仅在 top/bottom 时生效） |

---

## 进阶使用：自定义侧边栏

你可以结合 `NZText` 和 `NZDivider` 构建一个专业的侧边导航栏：

```dart
NZDrawer.show(
  context: context,
  child: Container(
    padding: EdgeInsets.all(24),
    child: Column(
      children: [
        NZText.h3('应用菜单'),
        NZDivider(),
        ListTile(title: Text('首页')),
        ListTile(title: Text('设置')),
      ],
    ),
  ),
);
```

---

## 注意事项

- **状态管理**：抽屉内部的内容如果需要响应状态变化，建议在 `child` 中使用 `StatefulWidget`。
- **安全区域**：抽屉内容会自动考虑屏幕的安全区域（如刘海屏、底部操作条），建议通过 `SafeArea` 进行进一步包裹。
