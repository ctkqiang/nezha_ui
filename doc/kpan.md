# K线盘面 (KPan)

专业级金融 K 线图表组件，支持多种蜡烛样式、技术指标和高度交互。

## 特性

- **多样式切换**：支持实心、空心、线图、OHLC 等多种蜡烛样式。
- **技术指标**：内置 MA, EMA, MACD, RSI, KDJ, BOLL, VOL 等 10+ 种专业指标。
- **流畅交互**：支持平滑缩放、惯性滚动及十字光标定位。
- **高度定制**：可自定义配色风格（红涨绿跌/绿涨红跌）、网格颜色及图表高度。

## 基础用法

```dart
NZKPan(
  symbol: 'XIAOMI',
  data: klineDataList, // List<KLineData>
)
```

## 属性参考 (API)

| 参数 | 类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| data | `List<KLineData>` | 必填 | K线数据列表 |
| symbol | `String` | `'BTC/USDT'` | 交易对/标的名称 |
| isChinaStyle | `bool` | `true` | 配色风格：true (红涨绿跌), false (绿涨红跌) |
| style | `KLineStyle` | `KLineStyle.solid` | 蜡烛样式：solid, hollow, line, ohlc |
| indicators | `Set<KLineIndicator>` | `{MA, VOL}` | 开启的技术指标列表 |
| height | `double` | `400.0` | 图表容器高度 |
| gridColor | `Color?` | `null` | 背景网格颜色 |
| onCrosshairChanged | `ValueChanged<KLineData?>?` | `null` | 十字光标移动时的回调 |

## 技术指标 (KLineIndicator)

支持以下技术指标：

- **趋势型**：`ma`, `ema`, `macd`, `sar`
- **动量/震荡**：`rsi`, `kdj`, `bias`, `dmi`
- **波动率与成交量**：`boll`, `vol`, `atr`, `obv`, `vwap`
- **支撑与阻力**：`fib`

## 示例代码

```dart
NZKPan(
  symbol: 'XIAOMI',
  style: KLineStyle.hollow,
  isChinaStyle: false, // 国际配色
  indicators: {
    KLineIndicator.ma,
    KLineIndicator.vol,
    KLineIndicator.macd,
  },
  height: 450,
  data: klineDataList,
)
```
