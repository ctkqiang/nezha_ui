# NZMasonry 瀑布流布局

`NZMasonry` 是 NezhaUI 提供的专业瀑布流布局组件。它支持多列等宽不等高的布局，非常适合展示图片、卡片流等内容。

---

## 1. 参数说明

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| **children** | `List<Widget>` | **必填** | 子组件列表。 |
| crossAxisCount | `int` | `2` | 布局的列数。 |
| mainAxisSpacing | `double` | `8.0` | 垂直方向（上下）的间距。 |
| crossAxisSpacing | `double` | `8.0` | 水平方向（左右）的间距。 |
| padding | `EdgeInsetsGeometry?` | `null` | 整体布局的内边距。 |

---

## 2. 使用方法

### 基础用法

```dart
NZMasonry(
  crossAxisCount: 2,
  mainAxisSpacing: 10,
  crossAxisSpacing: 10,
  children: [
    Container(height: 100, color: Colors.red),
    Container(height: 150, color: Colors.blue),
    Container(height: 80, color: Colors.green),
    Container(height: 120, color: Colors.orange),
  ],
)
```

### 三列布局

```dart
NZMasonry(
  crossAxisCount: 3,
  padding: EdgeInsets.all(16),
  children: List.generate(20, (index) => MyCustomCard(index)),
)
```
