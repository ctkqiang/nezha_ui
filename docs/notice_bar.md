# NoticeBar 公告栏

用于循环播放重要的公告、新闻或提示信息。支持水平滚动和垂直翻页，内置多种主题样式。

## 代码演示

### 基础用法

水平滚动公告。

```dart
NZNoticeBar(
  text: ['这是一条标准的水平滚动公告，用于展示重要的通知信息。'],
  icon: Icon(Icons.campaign_rounded),
)
```

### 金融新闻风格

使用深色背景和加粗文字，模拟金融行情滚动。

```dart
NZNoticeBar(
  theme: NZNoticeBarTheme.finance,
  text: ['[行情] 沪深300指数今日上涨 1.25%，科技板块领涨市场。'],
  icon: Icon(Icons.trending_up_rounded),
  speed: 60,
)
```

### 垂直翻页

展示多条公告内容。

```dart
NZNoticeBar(
  theme: NZNoticeBarTheme.success,
  direction: NZNoticeBarDirection.vertical,
  text: [
    '恭喜！您的账户已成功通过实名认证。',
    '系统消息：新功能“智能选股”已上线。',
    '提醒：请及时领取您的周度交易报告。',
  ],
  icon: Icon(Icons.check_circle_outline_rounded),
)
```

### 带操作按钮

```dart
NZNoticeBar(
  theme: NZNoticeBarTheme.error,
  text: ['警告：检测到您的账户存在异地登录风险，请立即检查。'],
  icon: Icon(Icons.error_outline_rounded),
  suffix: Icon(Icons.close_rounded),
  onSuffixTap: () => print('关闭公告'),
)
```

## API

### NZNoticeBar 属性

| 参数 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| text | 公告内容列表 | `List<String>` | - |
| theme | 主题样式 (`warning`, `success`, `error`, `info`, `finance`) | `NZNoticeBarTheme` | `warning` |
| direction | 滚动方向 (`horizontal`, `vertical`) | `NZNoticeBarDirection` | `horizontal` |
| icon | 前置图标 | `Widget?` | - |
| suffix | 后置组件 (如关闭图标) | `Widget?` | - |
| speed | 滚动速度 (像素/秒)，仅水平模式有效 | `double` | `50.0` |
| duration | 垂直模式停留时间 (毫秒) | `int` | `3000` |
| onTap | 点击公告栏回调 | `VoidCallback?` | - |
| onSuffixTap | 点击后置组件回调 | `VoidCallback?` | - |
| backgroundColor | 自定义背景色 | `Color?` | - |
| textColor | 自定义文字颜色 | `Color?` | - |
