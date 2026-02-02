# NZPullToRefresh 下拉刷新

符合 NezhaUI 设计规范的下拉刷新组件，支持自定义加载状态、提示文本、成功反馈以及震动交互。

## NZPullToRefresh

### 1. 参数说明

| 参数 | 类型 | 必填 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| child | Widget | 是 | - | 刷新时展示的内容（通常是一个 ScrollView） |
| onRefresh | Future<void> Function() | 是 | - | 刷新时的回调函数 |
| showSpinner | bool | 否 | true | 是否显示默认的加载圆圈。设置为 false 时显示自定义 Label 模式。 |
| label | String | 否 | '下拉刷新' | 自定义初始提示文本 |
| readyLabel | String | 否 | '释放立即刷新' | 释放即可刷新的提示文本 |
| refreshingLabel | String | 否 | '正在刷新...' | 正在刷新时的提示文本 |
| successLabel | String | 否 | '刷新成功' | 刷新成功后的提示文本 |
| labelStyle | TextStyle | 否 | - | 提示文本的样式 |
| showIcon | bool | 否 | true | 是否显示指示图标 |
| successIcon | IconData | 否 | Icons.check_circle_outline_rounded | 刷新成功后的图标 |
| color | Color | 否 | Primary | 刷新指示器的颜色（包括图标和文本） |
| backgroundColor | Color | 否 | White | 刷新指示器的背景颜色 |
| displacement | double | 否 | 40.0 | 刷新指示器出现的位置偏移 |
| triggerDistance | double | 否 | 60.0 | 触发刷新的拉动距离 |
| refreshDelay | Duration | 否 | Duration.zero | 刷新结束后的停留延迟时间 |
| enableHaptic | bool | 否 | true | 是否开启震动反馈（包含拉动触发、开始刷新和成功的不同反馈） |

### 2. 使用方法

#### 基础用法 (带 Spinner)
```dart
NZPullToRefresh(
  onRefresh: () async {
    await Future.delayed(Duration(seconds: 2));
  },
  child: ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
  ),
)
```

#### 高级自定义模式 (成功反馈与震动)
```dart
NZPullToRefresh(
  showSpinner: false,
  label: '下拉即可刷新...',
  readyLabel: '松开小手刷新',
  refreshingLabel: '正在努力加载中...',
  successLabel: '加载完成啦~',
  refreshDelay: Duration(milliseconds: 1500),
  enableHaptic: true,
  onRefresh: () async {
    await Future.delayed(Duration(seconds: 2));
  },
  child: ListView.builder(
    physics: const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    ),
    itemCount: 20,
    itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
  ),
)
```
