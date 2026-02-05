# NZPagination 分页器

`NZPagination` 是 NezhaUI 提供的专业分页器组件，用于将大量数据分割成多页展示，支持直接跳转、上一页/下一页等功能。

---

## 1. 参数说明

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| **total** | `int` | **必填** | 总条目数。 |
| pageSize | `int` | `10` | 每页展示的条目数。 |
| current | `int` | `1` | 当前页码 (从 1 开始)。 |
| onPageChanged | `ValueChanged<int>?` | `null` | 点击页码或切换按钮时的回调。 |
| showFirstLast | `bool` | `false` | 是否显示跳转到首页和末页的按钮。 |
| color | `Color?` | `NZColor.nezhaPrimary` | 选中页码的主色调。 |

---

## 2. 使用方法

### 基础用法

```dart
NZPagination(
  total: 50,
  current: 1,
  onPageChanged: (page) {
    print('当前页: $page');
  },
)
```

### 显示首尾页按钮

```dart
NZPagination(
  total: 100,
  pageSize: 10,
  current: 5,
  showFirstLast: true,
  onPageChanged: (page) => setState(() => _currentPage = page),
)
```

### 自定义颜色

```dart
NZPagination(
  total: 30,
  color: Colors.orange,
  onPageChanged: (page) {},
)
```
