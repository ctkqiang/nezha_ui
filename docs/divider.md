# NZDivider 分割线组件

用于在内容之间绘制细线的简单组件。

### 参数说明

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| height | double | 16.0 | 分割线占据的总高度（包含上下间距） |
| thickness | double | 1.0 | 线条本身的厚度 |
| indent | double? | null | 线条左侧的缩进距离 |
| endIndent | double? | null | 线条右侧的缩进距离 |
| color | Color? | 浅灰色 | 线条的颜色 |

### 使用方法

```dart

NZDivider()

NZDivider(
  thickness: 2.0,
  indent: 20.0,
  endIndent: 20.0,
  color: Colors.red,
)
```
