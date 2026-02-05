# NZTheme 主题管理

用于配置 NezhaUI 的全局外观，支持浅色和深色模式。

### 静态方法

| 方法名 | 返回类型 | 说明 |
| :--- | :--- | :--- |
| lightTheme | ThemeData | 获取预设的浅色主题配置 |
| darkTheme | ThemeData | 获取预设的深色主题配置 |

### 主题特性

- **Material 3**: 默认开启 `useMaterial3: true`。
- **自定义导航栏**: 自动配置白色/深色背景的 `AppBar`。
- **背景色**: 浅色模式下使用浅灰色背景 (`0xFFF8F9FA`)，深色模式下使用深黑色背景 (`0xFF121212`)。

### 使用方法

在 `NezhaApp` 或 `MaterialApp` 中直接引用：

```dart
NezhaApp(
  theme: NZTheme.lightTheme,
  darkTheme: NZTheme.darkTheme,
  // ... 其他配置
)
```
