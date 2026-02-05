# NZSteps 步骤条

`NZSteps` 是 NezhaUI 提供的专业步骤条组件，用于展示一个任务的进度，或引导用户按照流程完成任务。它支持水平和垂直两种排列方向，并能自动适配暗色模式。

---

## 1. 参数说明

### NZSteps

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| **steps** | `List<NZStep>` | **必填** | 步骤配置列表。 |
| current | `int` | `0` | 当前进行的步骤索引 (从 0 开始)。 |
| direction | `Axis` | `Axis.horizontal` | 排列方向：`horizontal` (水平), `vertical` (垂直)。 |
| color | `Color?` | `NZColor.nezhaPrimary` | 激活步骤的主色调。 |

### NZStep

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| **title** | `String` | **必填** | 步骤标题。 |
| description | `String?` | `null` | 步骤详细描述信息。 |
| icon | `IconData?` | `null` | 步骤自定义图标（未提供则显示数字）。 |

---

## 2. 使用方法

### 基础用法（水平）

```dart
NZSteps(
  current: 1,
  steps: [
    NZStep(title: '第一步', description: '填写个人信息'),
    NZStep(title: '第二步', description: '上传证明材料'),
    NZStep(title: '第三步', description: '等待审核'),
  ],
)
```

### 垂直方向

```dart
NZSteps(
  direction: Axis.vertical,
  current: 0,
  steps: [
    NZStep(title: '已提交', description: '2024-03-20 10:00'),
    NZStep(title: '审核中', description: '预计 1-3 个工作日完成'),
    NZStep(title: '已完成'),
  ],
)
```

### 自定义图标

```dart
NZSteps(
  steps: [
    NZStep(title: '购物车', icon: Icons.shopping_cart),
    NZStep(title: '付款', icon: Icons.payment),
    NZStep(title: '收货', icon: Icons.local_shipping),
  ],
)
```
