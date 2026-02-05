# NezhaApp 应用入口组件

`NezhaApp` 是 NezhaUI 的核心入口，它封装了主题切换、路由管理和国际化功能，使用方法与 Flutter 原生的 `MaterialApp` 非常相似。

### 参数说明

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| home | Widget? | null | 应用程序的主界面 |
| title | String | '' | 应用程序的标题（在任务管理器中显示） |
| theme | ThemeData? | null | 浅色模式下的主题配置 |
| darkTheme | ThemeData? | null | 深色模式下的主题配置 |
| themeMode | ThemeMode | system | 主题模式：system(跟随系统), light(强制浅色), dark(强制深色) |
| routes | Map<String, WidgetBuilder> | {} | 静态路由表配置 |
| initialRoute | String? | null | 应用启动时的初始路由名称 |
| onGenerateRoute | RouteFactory? | null | 动态路由生成回调 |
| localizationsDelegates | Iterable<LocalizationsDelegate>? | null | 国际化资源代理列表 |
| supportedLocales | Iterable<Locale> | [Locale('en', 'US')] | 应用支持的语言列表 |
| navigatorKey | GlobalKey<NavigatorState>? | null | 导航管理键，用于在无 Context 情况下进行导航 |
| debugShowCheckedModeBanner | bool | true | 是否在右上角显示 "Debug" 标志 |

### 使用方法

你可以像使用 `MaterialApp` 一样使用 `NezhaApp`，它会自动帮你集成 NezhaUI 的设计风格。

```dart
import 'package:nezha_ui/nezha_ui.dart';
import 'package:nezha_ui/theme/theme.dart';

void main() {
  runApp(
    NezhaApp(
      title: '我的 Nezha 应用',

      theme: NZTheme.lightTheme,
      darkTheme: NZTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    ),
  );
}
```

### 路由模式 (Router)

如果你使用的是 GoRouter 或其他路由库，可以使用 `.router` 构造函数：

```dart
NezhaApp.router(
  routerDelegate: myRouterDelegate,
  routeInformationParser: myRouteInformationParser,
  theme: NZTheme.lightTheme,
)
```

---

## 核心组件概览

NezhaUI 提供了一系列精心设计的组件，你可以点击下方链接查看详细的 API 说明：

- [NZButton 按钮系列](button.md): 包含基础按钮、进度按钮、图片按钮和悬浮拖拽按钮。
- [NZPopUp 弹窗](pop_up.md): 微信风格的对话框，支持多种交互模式。
- [NZSwipeListTile 滑动操作](swipe_list_tile.md): 列表项侧滑操作组件，支持 4 个滑动方向。
- [NZToast 轻提示](toast.md): 全局浮层提示，支持成功、失败、加载等状态。
- [NZNavBar 导航栏](navbar.md): 多功能顶部导航，支持搜索、Logo 和小程序模式。
- [NZDivider 分割线](divider.md): 支持自定义间距、粗细和颜色的水平分割线。
- [NZColor 色彩体系](colors.md): 预设了 10 种主色调及其梯度，满足各种品牌色需求。
- [NZTheme 主题配置](theme.md): 快速集成浅色与深色模式，保持全局视觉一致性。
- [NZDrawer 抽屉](drawer.md): 多方向滑出的覆盖层组件。
- [NZPullToRefresh 下拉刷新](pull_to_refresh.md): 高度可定制的列表刷新组件。
- [NZBackToTop 回到顶部](back_to_top.md): 自动监听滚动状态的快速返回组件。
- [NZMarkdownView Markdown 渲染](markdown_view.md): 原生 Flutter 实现的轻量级渲染组件。
- [NZCodeView 代码查看器](code_view.md): 带有语法高亮的专业代码展示组件。
- [NZCalendar 日历](calendar.md): 专业级日历组件，支持多样式、农历和过渡动画。
