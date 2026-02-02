# NZToast 轻提示组件

`NZToast` 是一个轻量级的全局反馈组件，模仿微信小程序风格设计。它通过 Flutter 的 `Overlay` 实现，可以在应用任何位置显示，而无需传递 `context`（虽然建议传递以获取更好的主题适配）。

---

## 提示类型 (NZToastType)

`NZToast` 支持以下五种显示类型：

| 类型 | 说明 | 视觉特征 |
| :--- | :--- | :--- |
| **success** | 成功提示 | 绿色勾选图标 + 文字 |
| **error** | 错误提示 | 红色警告图标 + 文字 |
| **loading** | 加载中 | 旋转加载图标 + 文字 (需手动隐藏) |
| **info** | 信息提示 | 蓝色信息图标 + 文字 |
| **text** | 纯文字 | 仅显示文字，无图标 |

---

## 参数说明

`NZToast.show()` 方法支持以下参数：

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| **message** | `String` | **必填** | 提示文本内容。 |
| **type** | `NZToastType` | `text` | 提示类型。 |
| **duration** | `Duration` | `2s` | 显示时长。`loading` 模式下无效。 |
| **mask** | `bool` | `false` | 是否显示透明遮罩，防止穿透点击。 |

---

## 使用方法

### 1. 快捷调用

```dart
// 成功提示
NZToast.success(context, '操作成功');

// 错误提示
NZToast.error(context, '提交失败');

// 加载中
NZToast.loading(context, '加载中...');
// ... 异步操作完成后
NZToast.hide();

// 纯文字
NZToast.show(context, message: '这是一条消息');
```

### 2. 自定义配置

```dart
NZToast.show(
  context,
  message: '请稍候',
  type: NZToastType.info,
  duration: Duration(seconds: 5),
  mask: true,
);
```

---

## 注意事项

- **全局唯一**：同一时间只能显示一个 Toast，新调用的 Toast 会自动替换旧的。
- **Loading 手动关闭**：`loading` 类型的 Toast 不会自动消失，必须显式调用 `NZToast.hide()`。
- **无 Context 调用**：虽然组件设计上依赖 `context` 来查找 `Overlay`，但如果你的应用有全局 `navigatorKey`，也可以根据需求扩展支持。
