# NZButton 按钮系列组件

NezhaUI 提供了一套功能丰富、易于使用的按钮组件，旨在满足从基础点击到复杂交互（如进度显示、背景图、可拖拽悬浮）的各种场景。

---

## NZButton 基础按钮

`NZButton` 是最常用的核心组件。多种预设样式，并支持 `isLoading` 加载状态、`block` 通栏布局以及高度自定义的颜色配置。

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
| color | `Color?` | `null` | 自定义背景颜色。未指定则根据 `style` 回退。 |
| foregroundColor | `Color?` | `null` | 自定义文字/图标颜色。未指定则根据 `style` 回退。 |
| isLoading | `bool` | `false` | 是否显示加载中动画。开启后按钮不可点击。 |
| block | `bool` | `false` | 是否通栏（占据父容器全部宽度）。 |
| icon | `Widget?` | `null` | 按钮图标。 |
| width | `double?` | `null` | 宽度（非 block 模式生效）。 |
| height | `double` | `48.0` | 高度。 |
| borderRadius | `double` | `12.0` | 圆角半径。 |
| iconGap | `double` | `8.0` | 图标与文字之间的间距。 |
| padding | `EdgeInsets?` | `null` | 按钮内边距。默认水平 24。 |

### 3. 使用方法

#### 推荐用法（使用命名构造函数）
```dart
// 主要按钮
NZButton.primary(
  label: '提交表单',
  onPressed: () => _submit(),
)

// 自定义颜色的主要按钮
NZButton.primary(
  label: '危险操作',
  color: Colors.red,
  onPressed: () => _delete(),
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
```

---

## NZProgressButton 进度按钮

带背景进度显示的按钮，常用于下载、上传等长耗时操作场景。

### 1. 参数说明

| 参数 | 类型 | 必填 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| **progress** | `double` | 是 | - | 进度值 (0.0 - 1.0) |
| **onPressed** | `VoidCallback?` | 是 | - | 点击回调 |
| **label** | `String?` | 否 | `null` | 按钮文本 |
| **color** | `Color?` | 否 | Primary | 进度条填充颜色 |
| **backgroundColor** | `Color?` | 否 | #F2F2F2 | 按钮底色 |
| **foregroundColor** | `Color?` | 否 | 动态 | 文本颜色 (随进度自动切换黑/白) |
| **width** | `double?` | 否 | `null` | 宽度 |
| **height** | `double` | 否 | `48.0` | 高度 |
| **borderRadius** | `double` | 否 | `12.0` | 圆角半径 |
| **block** | `bool` | 否 | `false` | 是否撑满宽度 |

### 2. 使用方法

```dart
NZProgressButton(
  progress: 0.65,
  label: '系统更新中 65%',
  onPressed: () => print('点击了进度按钮'),
  block: true,
)
```

---

## NZImageButton 图片按钮

以图片作为背景的沉浸式按钮，适用于视觉引导、Banner 点击等场景。

### 1. 参数说明

| 参数 | 类型 | 必填 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| **image** | `ImageProvider` | 是 | - | 背景图片源 |
| **onPressed** | `VoidCallback?` | 是 | - | 点击回调 |
| **label** | `String?` | 否 | `null` | 按钮文本 |
| **opacity** | `double` | 否 | `0.8` | 图片透明度 (用于遮罩文字) |
| **color** | `Color?` | 否 | Transparent | 按钮底色 |
| **foregroundColor** | `Color?` | 否 | White | 文本和水波纹颜色 |
| **borderRadius** | `double` | 否 | `12.0` | 圆角半径 |

### 2. 使用方法

```dart
NZImageButton(
  image: AssetImage('assets/banner.png'),
  label: '探索新视界',
  onPressed: () {},
)
```

---

## NZDraggableButton 悬浮拖拽按钮

可以随手势在屏幕上任意拖动的按钮，支持自动贴边动画。常用于客服入口、悬浮菜单等。

### 1. 参数说明

| 参数 | 类型 | 必填 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| **child** | `Widget` | 是 | - | 按钮显示的组件 |
| **onTap** | `VoidCallback?` | 否 | `null` | 点击回调 |
| **initialPosition** | `Offset` | 否 | `(20, 100)` | 初始位置 |
| **padding** | `EdgeInsets` | 否 | `zero` | 拖动范围限制的内边距 |

### 2. 使用方法

```dart
NZDraggableButton(
  initialPosition: Offset(300, 500),
  onTap: () => print('点击了悬浮球'),
  child: Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    ),
    child: Icon(Icons.support_agent, color: Colors.white),
  ),
)
```
