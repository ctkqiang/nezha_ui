# 金融图表 (NZTradingView)

`NZTradingView` 是一个基于 `trading_view_flutter` 封装的高性能行情图表组件。它能够无缝集成到 NezhaUI 的应用中，并支持自动适配深色模式。

## 基础用法

标准高级图表：

```dart
NZTradingView(
  symbol: 'HKEX:1810',
  height: 300,
)
```

## 轻量级视图 (Light View)

如果你需要更简洁、占用资源更少的图表（例如在列表或概览中使用），可以使用 `isLightWeightChart: true` 参数：

```dart
NZTradingView(
  symbol: 'BINANCE:BTCUSDT',
  height: 200,
  isLightWeightChart: true,
)
```

## 进阶配置

支持设置周期、主题以及工具栏显示。

```dart
NZTradingView(
  symbol: 'BINANCE:ETHUSDT',
  interval: '1H',
  theme: 'dark',
  height: 400,
  enableToolbar: true,
)
```

## 参数说明

| 参数 | 类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| symbol | String | **必填** | 交易对名称，如 "HKEX:1810" |
| interval | String | '1D' | 行情周期，如 "1D", "1H", "15", "5", "1" |
| theme | String? | null | 图表主题，"light" 或 "dark"，不填则跟随系统 |
| style | String? | '1' | 图表样式：'1' (蜡烛图), '2' (线图) 等 |
| enableToolbar | bool | true | 是否显示顶部工具栏 |
| height | double? | 400 | 图表容器高度 |
| width | double? | double.infinity | 图表容器宽度 |
| id | int? | symbol.hashCode | 组件唯一 ID，用于区分多个图表实例 |
| isLightWeightChart | bool | false | 是否使用轻量级视图模式 |

## 注意事项

1. **网络连接**：由于 TradingView 图表依赖其官方 JS 库，请确保应用运行环境能够访问 `tradingview.com`。
2. **WebView 支持**：该组件在移动端依赖 `webview_flutter`，请确保已正确配置原生平台的权限。
3. **性能**：在同一页面显示过多图表实例可能会影响性能，建议合理控制数量。
