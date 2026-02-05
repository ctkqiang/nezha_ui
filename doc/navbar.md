# NZNavBar 导航栏组件

`NZNavBar` 是一个基于 Flutter `AppBar` 封装的多功能导航栏组件，旨在为移动端应用提供一致且高效的顶部导航体验。它支持多种业务场景，包括标准导航、搜索模式、品牌 Logo 展示以及微信小程序风格的控制胶囊。

---

## 展现类型 (NZNavBarType)

`NZNavBar` 通过不同的构造函数或 `type` 参数支持以下四种模式：

| 模式 | 说明 | 适用场景 |
| :--- | :--- | :--- |
| **normal** | 标准模式 | 最常见的页面导航，包含标题和操作按钮。 |
| **search** | 搜索模式 | 带有展开动画的搜索框，适用于列表搜索。 |
| **logo** | Logo 模式 | 侧重于品牌展示，左对齐 Logo 和标题。 |
| **miniApp** | 小程序模式 | 仿微信小程序右侧控制胶囊（分享/关闭）。 |

---

## 参数说明

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| **title** | `String?` | `null` | 标题文本内容。 |
| **titleWidget** | `Widget?` | `null` | 自定义标题组件，优先级高于 `title`。 |
| **leading** | `Widget?` | `null` | 左侧领先组件（通常为返回按钮或菜单图标）。 |
| **actions** | `List<Widget>?` | `null` | 右侧操作按钮列表。 |
| **centerTitle** | `bool` | `true` | 标题是否居中显示。 |
| **elevation** | `double` | `0` | 阴影高度。 |
| **backgroundColor** | `Color?` | `null` | 背景颜色。 |
| **foregroundColor** | `Color?` | `null` | 前景颜色（影响文字和图标颜色）。 |
| **type** | `NZNavBarType` | `normal` | 导航栏类型：`normal`, `search`, `logo`, `miniApp`。 |
| **logoUrl** | `String?` | `null` | Logo 图片的 URL 地址（仅在 `logo` 模式下有效）。 |
| **onSearch** | `VoidCallback?` | `null` | 点击搜索按钮或提交搜索时的回调。 |
| **onSearchChanged** | `ValueChanged<String>?` | `null` | 搜索框内容变化时的回调。 |
| **onMiniAppShare** | `VoidCallback?` | `null` | 小程序模式下的分享按钮点击回调。 |
| **onMiniAppClose** | `VoidCallback?` | `null` | 小程序模式下的关闭按钮点击回调。 |
| **height** | `double` | `56.0` | 导航栏高度。 |

---

## 使用方法

### 1. 标准导航栏
最基础的使用方式，自动适配亮/暗色模式。
```dart
const NZNavBar(
  title: '设置',
  centerTitle: true,
)
```

### 2. 搜索导航栏
支持点击图标动态展开搜索框，并伴有平滑的淡入淡出动画。
```dart
NZNavBar.search(
  title: '搜索用户',
  onSearch: () => print('执行搜索'),
  onSearchChanged: (val) => print('当前输入: $val'),
)
```

### 3. Logo 品牌导航栏
常用于应用首页，左侧展示品牌图标和名称。
```dart
NZNavBar.logo(
  title: 'Nezha UI',
  logoUrl: 'https://example.com/logo.png',
  actions: [
    IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
  ],
)
```

### 4. 小程序风格导航栏
右侧集成了微信风格的控制胶囊，非常适合嵌入式 Web 容器或小程序场景。
```dart
NZNavBar.miniApp(
  title: '详情页面',
  onMiniAppShare: () => _handleShare(),
  onMiniAppClose: () => Navigator.pop(context),
)
```

---

## 主题适配
`NZNavBar` 默认会根据全局 `Theme` 的 `brightness` 自动选择背景色和前景文字颜色：
- **亮色模式**：背景 `#FFFFFF`，文字 `#1A1A1A`。
- **暗色模式**：背景 `#1A1A1A`，文字 `#FFFFFF`。
你也可以通过 `backgroundColor` 和 `foregroundColor` 进行手动覆盖。
