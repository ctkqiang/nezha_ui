# DropDownMenu 下拉菜单

微信风格的下拉选择菜单组件，使用 Overlay 实现浮层显示，确保不会被父容器裁剪。支持项目主色调作为强调色。

## 代码演示

### 基础用法

最简单的下拉菜单用法。

```dart
NZDropDownMenu<String>(
  value: _selected,
  hint: '请选择',
  items: const [
    NZDropDownMenuItem(value: '1', label: '选项一'),
    NZDropDownMenuItem(value: '2', label: '选项二'),
  ],
  onChanged: (val) => setState(() => _selected = val),
)
```

### 带图标的菜单项

为菜单项添加图标，增强视觉引导。

```dart
NZDropDownMenu<String>(
  value: _selected,
  items: const [
    NZDropDownMenuItem(
      value: 'edit',
      label: '编辑',
      icon: Icons.edit_outlined,
    ),
    NZDropDownMenuItem(
      value: 'delete',
      label: '删除',
      icon: Icons.delete_outline_rounded,
    ),
  ],
  onChanged: (val) => setState(() => _selected = val),
)
```

### 撑满宽度

使用 `isExpanded: true` 使触发器撑满父容器宽度。

```dart
NZDropDownMenu<String>(
  isExpanded: true,
  items: items,
  onChanged: (val) {},
)
```

## API

### NZDropDownMenu 属性

| 参数 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| items | 菜单选项列表 | `List<NZDropDownMenuItem<T>>` | - |
| value | 当前选中的值 | `T?` | - |
| onChanged | 选项改变时的回调 | `ValueChanged<T?>?` | - |
| hint | 占位文本 | `String` | `'请选择'` |
| isExpanded | 是否撑满宽度 | `bool` | `false` |
| backgroundColor | 背景颜色 | `Color?` | `Colors.white` |
| textColor | 文本颜色 | `Color?` | `Colors.black87` |
| activeColor | 激活状态颜色 | `Color?` | `NZColor.nezhaPrimary` |

### NZDropDownMenuItem 属性

| 参数 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| value | 选项的值 | `T` | - |
| label | 选项显示的文本 | `String` | - |
| icon | 选项显示的图标 | `IconData?` | - |
