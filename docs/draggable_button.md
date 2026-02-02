# DraggableButton 拖拽按钮

可以在屏幕范围内自由拖动的悬浮组件。支持平滑的拖拽交互，并会自动吸附到屏幕边缘（如果需要）。

## 代码演示

### 基础用法

最简单的拖拽按钮。

```dart
NZDraggableButton(
  initialPosition: Offset(20, 100),
  onTap: () => print('点击'),
  child: Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    ),
    child: Icon(Icons.add, color: Colors.white),
  ),
)
```

## API

### 属性

| 参数 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| child | 要拖动的子组件 | `Widget` | - |
| onTap | 点击回调 | `VoidCallback?` | - |
| initialPosition | 初始位置偏移量 | `Offset` | `Offset(20, 100)` |
