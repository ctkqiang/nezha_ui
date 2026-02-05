# 对话框 (NZDialog)

NZDialog 是 NezhaUI 中功能最丰富的反馈组件，支持从简单的消息提示到复杂的交互表单。

## 特性

- **多态支持**：内置超过 10 种对话框类型（确认、输入、加载、进度等）。
- **静态调用**：提供语义化的静态方法，一行代码即可弹出对话框。
- **高度定制**：支持自定义标题、内容、图标、按钮列表及排列方式。
- **响应式设计**：完美适配移动端屏幕，支持自动处理键盘遮挡。
- **交互规范**：遵循移动端主流交互设计，提供清晰的视觉层次。

## 基础用法

### 确认对话框

```dart
NZDialog.confirm(
  context,
  '确定要执行此操作吗？',
  title: '确认提示',
);
```

### 输入对话框

```dart
String? result = await NZDialog.input(
  context,
  title: '反馈意见',
  hintText: '请输入您的建议...',
);
```

### 进度对话框

```dart
NZDialog.progress(
  context,
  0.45,
  title: '正在下载资源',
);
```

## API 参考

### 静态方法

| 方法 | 说明 |
| --- | --- |
| confirm | 弹出确认对话框，返回 Future<bool?> |
| input | 弹出带输入框的对话框，返回 Future<String?> |
| success | 弹出成功状态提示对话框 |
| error | 弹出错误状态提示对话框 |
| loading | 弹出加载中对话框 |
| progress | 弹出带进度条的对话框 |

### 属性说明 (NZDialog)

| 参数 | 类型 | 说明 | 默认值 |
| --- | --- | --- | --- |
| type | NZDialogType | 对话框类型 | NZDialogType.basic |
| title | String? | 对话框标题 | - |
| message | String? | 对话框正文内容 | - |
| actions | List<NZDialogAction>? | 自定义按钮列表 | - |
| icon | IconData? | 顶部装饰图标 | - |
| progress | double? | 进度条数值 (0.0 - 1.0) | - |
| barrierDismissible | bool | 点击遮罩是否可关闭 | true |
