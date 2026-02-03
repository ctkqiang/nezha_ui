# 标签 (NZTag)

NZTag 是 NezhaUI 提供的专业标签组件，用于分类、标记和筛选。

## 特性

- **多样样式**：支持填充 (Filled)、描边 (Outline) 和浅色 (Soft) 三种视觉风格。
- **预设大小**：提供小、中、大三种尺寸，适配不同排版需求。
- **交互反馈**：支持点击回调及内置的删除/移除交互。
- **语义化工厂**：内置成功、警告、错误等状态的快速构建方法。
- **高度定制**：可自由配置颜色、圆角、图标等属性。

## 基础用法

```dart
// 默认样式 (Soft)
const NZTag(label: '标签文本')

// 填充样式
const NZTag(
  label: '主要标签',
  style: NZTagStyle.filled,
)

// 描边样式
const NZTag(
  label: '描边标签',
  style: NZTagStyle.outline,
)
```

## 语义化标签

```dart
NZTag.success('成功')
NZTag.warning('警告')
NZTag.error('错误')
```

## API 参考

### 属性说明

| 参数 | 类型 | 说明 | 默认值 |
| --- | --- | --- | --- |
| label | String | 标签显示的文字 | - |
| style | NZTagStyle | 样式类型 (filled, outline, soft) | NZTagStyle.soft |
| size | NZTagSize | 标签大小 (small, medium, large) | NZTagSize.medium |
| color | Color? | 标签主色调 | NZColor.nezhaPrimary |
| foregroundColor | Color? | 文字及图标颜色 | - |
| leading | Widget? | 左侧图标 | - |
| trailing | Widget? | 右侧图标 | - |
| onTap | VoidCallback? | 点击回调 | - |
| onDeleted | VoidCallback? | 删除回调 (若提供则显示删除图标) | - |
| round | bool | 是否为圆形圆角 | false |
| borderRadius | double? | 自定义圆角半径 | 8.0 |
