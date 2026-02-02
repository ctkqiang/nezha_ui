# NZButton & NZProgressButton 按钮组件

NezhaUI 提供的高性能按钮系列，包含基础按钮和进度条按钮。

## NZButton 基础按钮

### 参数说明

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| child | Widget | 必填 | 按钮显示的文字或内容 |
| onPressed | VoidCallback? | 必填 | 点击后的动作，设为 null 则禁用按钮 |
| style | NZButtonStyle | primary | 样式：primary(主色), secondary(次色), outline(边框), text(纯文字) |
| width | double? | null | 宽度，不填则随内容自适应 |
| height | double | 48.0 | 高度 |
| borderRadius | double | 12.0 | 圆角大小 |
| icon | Widget? | null | 按钮上的图标 |
| iconGap | double | 8.0 | 图标和文字的间距 |

### 使用方法

```dart

NZButton(
  onPressed: () => print('点击了'),
  child: Text('提交'),
)


NZButton(
  style: NZButtonStyle.secondary,
  onPressed: () {},
  child: Text('取消'),
)


NZButton(
  style: NZButtonStyle.text,
  onPressed: () {},
  icon: Icon(Icons.share),
  child: Text('分享'),
)
```

---

## NZProgressButton 进度按钮

支持显示任务进度的特殊按钮。

### 参数说明

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| progress | double | 必填 | 进度值，范围 0.0 到 1.0 |
| child | Widget | 必填 | 按钮上显示的文字 |
| onPressed | VoidCallback? | 必填 | 点击动作 |
| progressColor | Color? | 主色 | 进度条填充颜色 |
| backgroundColor | Color? | 浅灰色 | 按钮未填充部分的背景色 |
| width | double? | null | 宽度 |
| height | double | 48.0 | 高度 |
| borderRadius | double | 12.0 | 圆角大小 |

### 使用方法

```dart
NZProgressButton(
  progress: 0.5, // 显示 50% 进度
  onPressed: () {},
  child: Text('正在下载...'),
)
```
