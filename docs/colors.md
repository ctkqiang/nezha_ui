# NZColor 颜色库

NezhaUI 的核心调色板，提供了丰富的色彩选择。

### 核心色调 (常用)

| 变量名 | 数据类型 | 说明 |
| :--- | :--- | :--- |
| nezhaPrimary | Color | 品牌主色（红色） |
| nezhaSecondary | Color | 辅助色（橙色） |
| nezhaSub | Color | 次要辅助色（黄色） |

### 完整色系

你可以使用各色系的色阶（50 - 900），例如 `NZColor.red500`。
| 色系 | 色阶范围 |

| :--- | :--- |
| 红色系 (Red) | `red50` 到 `red900` |
| 橙色系 (Orange) | `orange50` 到 `orange900` |
| 黄色系 (Yellow) | `yellow50` 到 `yellow900` |
| 粉色系 (Pink) | `pink50` 到 `pink900` |
| 紫色系 (Purple) | `purple50` 到 `purple900` |
| 蓝色系 (Blue) | `blue50` 到 `blue900` |
| 绿色系 (Green) | `green50` 到 `green900` |
| 灰色系 (Grey) | `grey50` 到 `grey900` |

### 使用方法

```dart
Container(
  color: NZColor.nezhaPrimary, // 使用主色
)

Text(
  '警告',
  style: TextStyle(color: NZColor.red700), // 使用深红色
)
```
