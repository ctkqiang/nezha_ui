# ProgressButton 进度按钮

带有实时进度条背景的按钮，适用于下载、上传或耗时操作。

## 代码演示

### 基础用法

设置 `progress` 值（0.0 到 1.0）来显示进度。

```dart
NZProgressButton(
  progress: 0.45,
  label: '下载中 45%',
  onPressed: () {},
)
```

### 自定义颜色和全宽

使用 `color` 改变进度条颜色，`block: true` 使按钮撑满宽度。

```dart
NZProgressButton(
  progress: 0.8,
  label: '上传中',
  color: Colors.orange,
  block: true,
  onPressed: () {},
)
```

### 完成状态

进度达到 1.0 时通常显示为完成。

```dart
NZProgressButton(
  progress: 1.0,
  label: '已完成',
  color: Colors.green,
  onPressed: () {},
)
```

## API

### 属性

| 参数 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| progress | 进度值 (0.0 到 1.0) | `double` | - |
| label | 按钮文本 | `String?` | - |
| onPressed | 点击回调 | `VoidCallback?` | - |
| child | 自定义按钮内容 | `Widget?` | - |
| color | 进度条填充颜色 | `Color?` | `NZColor.nezhaPrimary` |
| backgroundColor | 按钮背景底色 | `Color?` | - |
| foregroundColor | 文本/图标颜色 | `Color?` | - |
| width | 按钮宽度 | `double?` | - |
| height | 按钮高度 | `double` | `48.0` |
| borderRadius | 圆角半径 | `double` | `12.0` |
| block | 是否撑满宽度 | `bool` | `false` |
