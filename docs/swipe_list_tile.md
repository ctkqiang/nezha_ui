# NZSwipeListTile 滑动操作组件

`NZSwipeListTile` 是一个支持左右（以及上下）滑动的列表单元格组件，常用于在列表项上执行快速操作，如编辑、删除、收藏等。其交互风格参考了微信小程序的经典设计。

## 代码演示

### 基础用法

最常见的用法是右滑显示操作按钮。

```dart
NZSwipeListTile(
  rightActions: [
    NZSwipeAction(
      label: '删除',
      backgroundColor: Colors.red,
      icon: Icon(Icons.delete),
      onTap: () => print('点击了删除'),
    ),
  ],
  child: ListTile(
    title: Text('左滑删除我'),
  ),
)
```

### 多方向滑动

支持 `leftActions` (右滑显示)、`rightActions` (左滑显示)、`topActions` (下滑显示) 和 `bottomActions` (上滑显示)。

```dart
NZSwipeListTile(
  leftActions: [
    NZSwipeAction(
      label: '收藏',
      backgroundColor: Colors.orange,
      icon: Icon(Icons.star),
      onTap: () => print('收藏成功'),
    ),
  ],
  rightActions: [
    NZSwipeAction(
      label: '更多',
      backgroundColor: Colors.grey,
      onTap: () => print('更多操作'),
    ),
  ],
  child: ListTile(
    title: Text('左右滑动试试'),
  ),
)
```

## API

### NZSwipeListTile Props

| 参数 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| child | 单元格主内容 | `Widget` | - |
| leftActions | 左侧滑出的按钮列表 (右滑显示) | `List<NZSwipeAction>` | `[]` |
| rightActions | 右侧滑出的按钮列表 (左滑显示) | `List<NZSwipeAction>` | `[]` |
| topActions | 顶部滑出的按钮列表 (下滑显示) | `List<NZSwipeAction>` | `[]` |
| bottomActions | 底部滑出的按钮列表 (上滑显示) | `List<NZSwipeAction>` | `[]` |
| disabled | 是否禁用滑动 | `bool` | `false` |
| backgroundColor | 背景颜色 | `Color` | `Colors.white` |
| onTap | 点击单元格回调 | `VoidCallback` | - |
| onLongPress | 长按单元格回调 | `VoidCallback` | - |

### NZSwipeAction Props

| 参数 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| label | 按钮文本 | `String` | - |
| icon | 按钮图标 | `Widget` | - |
| backgroundColor | 背景颜色 | `Color` | - |
| onTap | 点击回调 | `VoidCallback` | - |
| width | 按钮宽度 (水平滑动时) | `double` | `80.0` |
| height | 按钮高度 (垂直滑动时) | `double` | `80.0` |
