# NZButton 按钮系列组件

NezhaUI 提供了一套功能丰富、易于使用的按钮组件，旨在满足从基础点击到复杂交互（如进度显示、背景图、可拖拽悬浮）的各种场景。

---

## NZButton 基础按钮

`NZButton` 是最常用的核心组件。大姐为你设计了多种预设样式，并支持 `isLoading` 加载状态和 `block` 通栏布局。

### 1. 样式说明 (NZButtonStyle)

| 样式名 | 说明 | 视觉特征 |
| :--- | :--- | :--- |
| **primary** | 主要按钮 | 主色背景，白色文字。用于页面最主要的行动点。 |
| **secondary** | 次要按钮 | 浅灰色背景，绿色文字（微信风格）。用于次要的操作。 |
| **outline** | 描边按钮 | 透明背景，主色边框和文字。用于轻量级的操作。 |
| **text** | 文字按钮 | 无背景，无边框。仅保留文字或图标。 |

### 2. 参数说明

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| **onPressed** | `VoidCallback?` | **必填** | 点击回调。设为 `null` 时自动进入禁用状态。 |
| label | `String?` | `null` | 按钮文字简写。与 `child` 二选一必填。 |
| child | `Widget?` | `null` | 按钮内容。优先级高于 `label`。 |
| style | `NZButtonStyle` | `primary` | 按钮样式类型。 |
| isLoading | `bool` | `false` | 是否显示加载中动画。开启后按钮不可点击。 |
| block | `bool` | `false` | 是否通栏（占据父容器全部宽度）。 |
| icon | `Widget?` | `null` | 按钮图标。 |
| width | `double?` | `null` | 宽度（非 block 模式生效）。 |
| height | `double` | `48.0` | 高度。 |
| borderRadius | `double` | `12.0` | 圆角半径。 |

### 3. 使用方法

#### 推荐用法（使用命名构造函数）
```dart
// 主要按钮
NZButton.primary(
  label: '提交表单',
  onPressed: () => _submit(),
)

// 微信风格次要按钮
NZButton.secondary(
  label: '取消',
  onPressed: () => Navigator.pop(context),
)

// 加载中状态
NZButton.primary(
  label: '保存中',
  isLoading: true,
  onPressed: null,
)

// 通栏按钮
NZButton.primary(
  label: '确定',
  block: true,
  onPressed: () {},
)
```

---

## NZProgressButton 进度按钮

适用于文件下载、上传或长耗时任务，直接在按钮背景显示进度百分比。

### 1. 参数说明

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| **progress** | `double` | **必填** | 进度值（0.0 到 1.0）。 |
| label/child | - | **必填** | 按钮显示的文字或内容。 |
| progressColor | `Color?` | 主色 | 进度条填充颜色。 |
| backgroundColor | `Color?` | 浅灰 | 进度条底色。 |

### 2. 使用方法
```dart
NZProgressButton(
  progress: 0.6,
  label: '正在下载 60%',
  onPressed: () {},
)
```

---

## NZImageButton 图片按钮

支持使用背景图片的按钮，常用于精选分类、活动入口等需要视觉冲击力的场景。

### 1. 参数说明

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| **image** | `ImageProvider` | **必填** | 背景图片。 |
| opacity | `double` | `0.6` | 图片不透明度（0.0 ~ 1.0）。 |
| height | `double` | `120.0` | 默认高度。 |

### 2. 使用方法
```dart
NZImageButton(
  image: AssetImage('assets/banner.png'),
  label: '夏季新品上市',
  onPressed: () {},
)
```

---

## NZDraggableButton 悬浮拖拽按钮

可以随手势在屏幕上任意拖动的按钮，常用于客服入口、悬浮菜单等。

### 1. 参数说明

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| **child** | `Widget` | **必填** | 按钮的外观组件。 |
| initialPosition | `Offset` | `(20, 100)` | 初始位置。 |

### 2. 使用方法
```dart
NZDraggableButton(
  child: CircleAvatar(
    child: Icon(Icons.help),
  ),
  onTap: () => print('点击了悬浮球'),
)
```
