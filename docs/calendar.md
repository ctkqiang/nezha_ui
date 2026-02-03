# NZCalendar 日历组件

`NZCalendar` 是一个专业级、高度可定制的日历组件。它不仅提供了基础的日期选择功能，还深度集成了农历显示、多种视觉样式以及平滑的月份切换动画。

---

## 特性

- **多样式支持**：内置 `classic` (经典)、`card` (卡片)、`compact` (紧凑) 三种视觉风格。
- **农历集成**：支持显示精准的农历日期（支持 1900-2050 年）。
- **丝滑动画**：使用 `PageView` 实现月份平滑切换，选中状态具备缩放动画。
- **高度定制**：支持自定义主题色、初始日期以及显示配置。
- **智能交互**：支持无限滚动翻页，自动处理日期溢出与选中逻辑。

---

## 参数说明

| 参数名 | 数据类型 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- |
| **initialDate** | `DateTime?` | `DateTime.now()` | 初始选中的日期 |
| **onDateSelected** | `ValueChanged<DateTime>?` | `null` | 日期选中时的回调 |
| **style** | `NZCalendarStyle` | `classic` | 日历视觉样式：classic, card, compact |
| **showLunar** | `bool` | `true` | 是否显示农历信息 |
| **primaryColor** | `Color?` | `NZColor.nezhaPrimary` | 主题色（选中背景色） |
| **usePrompt** | `bool` | `false` | 是否开启点击日期显示选项弹窗 |
| **promptOptions** | `List<String>?` | `['添加日程', '查看详情', '标记重要']` | 弹窗中的选项列表 |
| **onOptionSelected** | `void Function(DateTime, String)?` | `null` | 选中选项时的回调 |

### NZCalendarStyle 说明

- **classic**: 极简风格，无边框和阴影，适合内嵌在页面中。
- **card**: 带有阴影和边框的卡片风格，视觉层级更高。
- **compact**: 紧凑布局，减小了间距和内边距，适合小尺寸屏幕或侧边栏。

---

## 使用方法

### 基础用法

```dart
NZCalendar(
  onDateSelected: (date) {
    print('选中了日期: ${date.toString()}');
  },
)
```

### 卡片样式 + 显示农历

```dart
NZCalendar(
  style: NZCalendarStyle.card,
  showLunar: true,
  onDateSelected: (date) => _handleDate(date),
)
```

### 自定义主题色

```dart
NZCalendar(
  primaryColor: Colors.deepPurple,
  onDateSelected: (date) {},
)
```

### 开启点击选项弹窗

```dart
NZCalendar(
  usePrompt: true,
  promptOptions: ['新建日程', '查看日程', '设为重要'],
  onOptionSelected: (date, option) {
    print('日期 $date 选择了: $option');
  },
)
```

---

## 示例代码

```dart
class CalendarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('日历示例')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: NZCalendar(
            style: NZCalendarStyle.card,
            onDateSelected: (date) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('选中了: ${date.year}年${date.month}月${date.day}日')),
              );
            },
          ),
        ),
      ),
    );
  }
}
```
