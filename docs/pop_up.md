# PopUp 弹窗

微信风格的对话框组件，用于重要的交互提示或确认操作。

## 代码演示

### 基础用法

```dart
NZPopUp.alert(
  context,
  title: '提示',
  content: '这是一个基础提示弹窗',
  onConfirm: () => print('点击了确定'),
);
```

### 确认弹窗

```dart
NZPopUp.confirm(
  context,
  title: '确认提交',
  content: '提交后将无法修改，是否确认继续？',
  onConfirm: () => print('已确认'),
  onCancel: () => print('已取消'),
);
```

### 危险操作

```dart
NZPopUp.confirm(
  context,
  title: '删除提示',
  content: '确定要删除这条重要数据吗？此操作不可撤销。',
  confirmLabel: '删除',
  isDestructive: true,
  onConfirm: () => print('已删除'),
);
```

### 多按钮弹窗

```dart
NZPopUp.show(
  context,
  title: '请选择操作',
  actionsAxis: Axis.vertical,
  actions: [
    NZPopUpAction(
      label: '查看详情',
      onPressed: () => Navigator.pop(context),
    ),
    NZPopUpAction(
      label: '分享给好友',
      onPressed: () => Navigator.pop(context),
    ),
    NZPopUpAction(
      label: '取消',
      onPressed: () => Navigator.pop(context),
    ),
  ],
);
```

## API

### NZPopUp 静态方法

| 方法 | 说明 | 返回值 |
| --- | --- | --- |
| show | 通用显示方法 | `Future<T?>` |
| alert | 显示警告/提示弹窗 | `Future<void>` |
| confirm | 显示确认/取消弹窗 | `Future<bool?>` |

### NZPopUp 属性

| 参数 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| title | 弹窗标题 | `String?` | - |
| content | 弹窗内容描述 | `String?` | - |
| contentWidget | 自定义内容组件，优先级高于 `content` | `Widget?` | - |
| actions | 操作按钮列表 | `List<NZPopUpAction>` | - |
| actionsAxis | 按钮排列方向 | `Axis` | `Axis.horizontal` |
| barrierDismissible | 是否可以通过点击遮罩层关闭 | `bool` | `true` |

### NZPopUpAction 属性

| 参数 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| label | 按钮文本 | `String` | - |
| onPressed | 点击回调 | `VoidCallback?` | - |
| isDestructive | 是否为警示性操作（红色） | `bool` | `false` |
| isPrimary | 是否为主操作（加粗显示且为主色） | `bool` | `false` |
| color | 自定义颜色 | `Color?` | - |
