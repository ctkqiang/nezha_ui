# ImageButton 图片按钮

使用图片作为背景的交互按钮，支持透明度遮罩和文字标签。适合用于画廊、卡片入口或需要强视觉吸引力的点击区域。

## 代码演示

### 基础用法

最简单的图片按钮。

```dart
NZImageButton(
  image: NetworkImage('https://picsum.photos/800/400'),
  label: '点击探索',
  block: true,
  onPressed: () {},
)
```

### 自定义透明度和高度

通过 `opacity` 调整背景图透明度，`height` 调整按钮高度。

```dart
NZImageButton(
  image: NetworkImage('https://picsum.photos/800/400'),
  label: '立即开启',
  opacity: 0.6,
  height: 120,
  block: true,
  onPressed: () {},
)
```

## API

### 属性

| 参数 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| image | 背景图片资源 | `ImageProvider` | - |
| label | 按钮中心显示的文本 | `String?` | - |
| onPressed | 点击回调 | `VoidCallback?` | - |
| opacity | 图片不透明度 | `double` | `0.8` |
| height | 按钮高度 | `double` | `180.0` |
| borderRadius | 圆角半径 | `double` | `12.0` |
| block | 是否撑满宽度 | `bool` | `false` |
