import 'package:flutter/material.dart';
import 'package:nezha_ui/theme/colors.dart';

/// NZCalendarStyle 样式类型
enum NZCalendarStyle {
  /// 经典样式：简洁明了，适合大多数场景
  classic,

  /// 卡片样式：带有阴影和边框，更具立体感
  card,

  /// 紧凑样式：单元格更小，适合空间有限的场景
  compact,
}

/// NZCalendar 是 NezhaUI 提供的专业日历组件。
///
/// 它支持多样式切换、农历显示、平滑动画以及高度自定义的主题配置。
/// 适用于日程管理、日期选择等场景。
class NZCalendar extends StatefulWidget {
  /// 初始选中的日期，默认为今天
  final DateTime? initialDate;

  /// 最小可选日期
  final DateTime? firstDate;

  /// 最大可选日期
  final DateTime? lastDate;

  /// 日期选中回调
  final ValueChanged<DateTime>? onDateSelected;

  /// 是否显示头部导航
  final bool showHeader;

  /// 是否显示农历
  final bool showLunar;

  /// 样式类型
  final NZCalendarStyle style;

  /// 自定义主色调
  final Color? primaryColor;

  /// 背景颜色
  final Color? backgroundColor;

  /// 容器圆角
  final double borderRadius;

  /// 是否开启点击弹窗选项
  final bool usePrompt;

  /// 弹窗选项列表
  final List<String>? promptOptions;

  /// 选项选中回调
  final void Function(DateTime date, String option)? onOptionSelected;

  /// 事件标记 (日期 -> 颜色列表)
  final Map<DateTime, List<Color>>? events;

  /// 星期显示文本
  final List<String> weekDayLabels;

  const NZCalendar({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.showHeader = true,
    this.showLunar = true,
    this.style = NZCalendarStyle.classic,
    this.primaryColor,
    this.backgroundColor,
    this.borderRadius = 16.0,
    this.usePrompt = false,
    this.promptOptions,
    this.onOptionSelected,
    this.events,
    this.weekDayLabels = const ['日', '一', '二', '三', '四', '五', '六'],
  });

  @override
  State<NZCalendar> createState() => _NZCalendarState();
}

class _NZCalendarState extends State<NZCalendar> {
  late DateTime _selectedDate;
  late DateTime _focusedMonth;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _focusedMonth = DateTime(_selectedDate.year, _selectedDate.month);
    // 假设初始页为 1200 (100年范围)，这样可以前后自由滚动
    _pageController = PageController(initialPage: 1200);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    final int monthOffset = page - 1200;
    setState(() {
      // 使用 PageController 的初始参考点来计算当前聚焦的月份
      // 这样即使 _selectedDate 改变，页码对应的月份依然保持稳定
      final DateTime baseDate = widget.initialDate ?? DateTime.now();
      _focusedMonth = DateTime(baseDate.year, baseDate.month + monthOffset);
    });
  }

  void _previousMonth() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  void _nextMonth() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color effectivePrimary = widget.primaryColor ?? NZColor.nezhaPrimary;
    final Color effectiveBg =
        widget.backgroundColor ?? (isDark ? Colors.grey[900]! : Colors.white);

    return Container(
      decoration: _getBoxDecoration(isDark, effectiveBg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showHeader) _buildHeader(effectivePrimary),
          _buildWeekDays(),
          SizedBox(
            height: widget.style == NZCalendarStyle.compact ? 240 : 300,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                final int monthOffset = index - 1200;
                final DateTime baseDate = widget.initialDate ?? DateTime.now();
                final DateTime month = DateTime(
                  baseDate.year,
                  baseDate.month + monthOffset,
                );
                return _buildDaysGrid(month, effectivePrimary);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showPromptOptions(BuildContext context, DateTime date) {
    final List<String> options =
        widget.promptOptions ?? ['添加日程', '查看详情', '标记重要'];
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color primary = widget.primaryColor ?? NZColor.nezhaPrimary;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '${date.year}年${date.month}月${date.day}日',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(height: 1),
            ...options.map(
              (option) => ListTile(
                leading: Icon(
                  _getIconForOption(option),
                  color: primary,
                  size: 22,
                ),
                title: Text(option, style: const TextStyle(fontSize: 15)),
                onTap: () {
                  Navigator.pop(context);
                  widget.onOptionSelected?.call(date, option);
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  IconData _getIconForOption(String option) {
    if (option.contains('添加')) return Icons.add_rounded;
    if (option.contains('详情')) return Icons.info_outline_rounded;
    if (option.contains('标记')) return Icons.bookmark_border_rounded;
    if (option.contains('日程')) return Icons.event_note_rounded;
    if (option.contains('删除')) return Icons.delete_outline_rounded;
    return Icons.radio_button_unchecked_rounded;
  }

  BoxDecoration _getBoxDecoration(bool isDark, Color bg) {
    switch (widget.style) {
      case NZCalendarStyle.card:
        return BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: isDark
                ? Colors.white10
                : Colors.black.withValues(alpha: 0.05),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        );
      case NZCalendarStyle.compact:
        return BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        );
      case NZCalendarStyle.classic:
        return BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
          ],
        );
    }
  }

  Widget _buildHeader(Color primary) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: animation.drive(
                    Tween(
                      begin: const Offset(0, 0.2),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeOutCubic)),
                  ),
                  child: child,
                ),
              );
            },
            child: Text(
              '${_focusedMonth.year}年${_focusedMonth.month}月',
              key: ValueKey(_focusedMonth),
              style: TextStyle(
                fontSize: widget.style == NZCalendarStyle.compact ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          _IconButton(
            icon: Icons.chevron_left_rounded,
            onPressed: _previousMonth,
          ),
          const SizedBox(width: 8),
          _IconButton(icon: Icons.chevron_right_rounded, onPressed: _nextMonth),
        ],
      ),
    );
  }

  Widget _buildWeekDays() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.weekDayLabels
            .map(
              (day) => Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDaysGrid(DateTime month, Color primary) {
    final int daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final int firstDayOffset = DateTime(month.year, month.month, 1).weekday % 7;

    final DateTime lastMonth = DateTime(month.year, month.month - 1);
    final int daysInLastMonth = DateUtils.getDaysInMonth(
      lastMonth.year,
      lastMonth.month,
    );

    final List<Widget> dayWidgets = [];

    // 上个月补全
    for (int i = firstDayOffset - 1; i >= 0; i--) {
      dayWidgets.add(
        _buildDayCell(
          date: DateTime(month.year, month.month - 1, daysInLastMonth - i),
          isCurrentMonth: false,
          primary: primary,
        ),
      );
    }

    // 本月天数
    for (int i = 1; i <= daysInMonth; i++) {
      dayWidgets.add(
        _buildDayCell(
          date: DateTime(month.year, month.month, i),
          isCurrentMonth: true,
          primary: primary,
        ),
      );
    }

    // 下个月补全
    final int remainingDays = 42 - dayWidgets.length;
    for (int i = 1; i <= remainingDays; i++) {
      dayWidgets.add(
        _buildDayCell(
          date: DateTime(month.year, month.month + 1, i),
          isCurrentMonth: false,
          primary: primary,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 7,
        children: dayWidgets,
      ),
    );
  }

  Widget _buildDayCell({
    required DateTime date,
    required bool isCurrentMonth,
    required Color primary,
  }) {
    final bool isSelected = DateUtils.isSameDay(date, _selectedDate);
    final bool isToday = DateUtils.isSameDay(date, DateTime.now());

    bool isEnabled = true;
    if (widget.firstDate != null && date.isBefore(widget.firstDate!)) {
      isEnabled = false;
    }
    if (widget.lastDate != null && date.isAfter(widget.lastDate!)) {
      isEnabled = false;
    }

    final String lunarDay = widget.showLunar
        ? _NZLunarUtils.getDayString(date)
        : '';

    // 获取当天的事件颜色
    final List<Color>? dayEvents = widget.events?.entries
        .where((e) => DateUtils.isSameDay(e.key, date))
        .map((e) => e.value)
        .firstOrNull;

    return GestureDetector(
      onTap: isEnabled && isCurrentMonth
          ? () {
              setState(() {
                _selectedDate = date;
              });
              widget.onDateSelected?.call(date);
              if (widget.usePrompt) {
                _showPromptOptions(context, date);
              }
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? primary : Colors.transparent,
          borderRadius: BorderRadius.circular(
            widget.style == NZCalendarStyle.compact ? 8 : 12,
          ),
          border: isToday && !isSelected
              ? Border.all(color: primary.withValues(alpha: 0.5), width: 1.5)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.day.toString(),
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : (isCurrentMonth
                          ? (isEnabled ? null : Colors.grey[300])
                          : Colors.grey[300]),
                fontWeight: isSelected || isToday
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontSize: widget.style == NZCalendarStyle.compact ? 13 : 15,
              ),
            ),
            if (widget.showLunar && isCurrentMonth && isEnabled)
              Text(
                lunarDay,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.8)
                      : Colors.grey[400],
                  fontSize: 9,
                ),
              ),
            if (dayEvents != null && dayEvents.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: dayEvents.take(3).map((color) {
                    return Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : color,
                        shape: BoxShape.circle,
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _IconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey[100],
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }
}

/// 简易农历工具类
class _NZLunarUtils {
  static const List<String> lunarDays = [
    '初一',
    '初二',
    '初三',
    '初四',
    '初五',
    '初六',
    '初七',
    '初八',
    '初九',
    '初十',
    '十一',
    '十二',
    '十三',
    '十四',
    '十五',
    '十六',
    '十七',
    '十八',
    '十九',
    '二十',
    '廿一',
    '廿二',
    '廿三',
    '廿四',
    '廿五',
    '廿六',
    '廿七',
    '廿八',
    '廿九',
    '三十',
  ];

  static const List<String> lunarMonths = [
    '正月',
    '二月',
    '三月',
    '四月',
    '五月',
    '六月',
    '七月',
    '八月',
    '九月',
    '十月',
    '冬月',
    '腊月',
  ];

  /// 农历数据 (1900-2050)
  /// 每项含义：[闰月月份(4bit), 农历年天数总和(12bit), 闰月大还是小(1bit)]
  /// 这里简化处理，仅提供核心数据结构
  static const List<int> lunarInfo = [
    0x04bd8,
    0x04ae0,
    0x0a570,
    0x054d5,
    0x0d260,
    0x0d950,
    0x16554,
    0x056a0,
    0x09ad0,
    0x055d2,
    0x04ae0,
    0x0a5b6,
    0x0a4d0,
    0x0d250,
    0x1d255,
    0x0b540,
    0x0d6a0,
    0x0ada2,
    0x095b0,
    0x14977,
    0x04970,
    0x0a4b0,
    0x0b4b5,
    0x06a50,
    0x06d40,
    0x1ab54,
    0x02b60,
    0x09570,
    0x052f2,
    0x04970,
    0x06566,
    0x0d4a0,
    0x0ea50,
    0x06e95,
    0x05ad0,
    0x02b60,
    0x186e3,
    0x092e0,
    0x1c8d7,
    0x0c950,
    0x0d4a0,
    0x1d8a6,
    0x0b550,
    0x056a0,
    0x1a5b4,
    0x025d0,
    0x092d0,
    0x0d2b2,
    0x0a950,
    0x0b557,
    0x06ca0,
    0x0b550,
    0x15355,
    0x04da0,
    0x0a5d0,
    0x14573,
    0x052d0,
    0x0a9a8,
    0x0e950,
    0x06aa0,
    0x0aea6,
    0x0ab50,
    0x04b60,
    0x0aae4,
    0x0a570,
    0x05260,
    0x0f263,
    0x0d950,
    0x05b57,
    0x056a0,
    0x096d0,
    0x04dd5,
    0x04ad0,
    0x0a4d0,
    0x0d4d4,
    0x0d250,
    0x0d558,
    0x0b540,
    0x0b5a0,
    0x195a6,
    0x095b0,
    0x049b0,
    0x0a974,
    0x0a4b0,
    0x0b27a,
    0x06a50,
    0x06d40,
    0x0af46,
    0x0ab60,
    0x09570,
    0x04af5,
    0x04970,
    0x064b0,
    0x074a3,
    0x0ea50,
    0x06b58,
    0x055c0,
    0x0ab60,
    0x096d5,
    0x092e0,
    0x0c960,
    0x0d954,
    0x0d4a0,
    0x0da50,
    0x07552,
    0x056a0,
    0x0abb7,
    0x025d0,
    0x092d0,
    0x0cab5,
    0x0a950,
    0x0b4a0,
    0x0baa4,
    0x0ad50,
    0x055d9,
    0x04ba0,
    0x0a5b0,
    0x15176,
    0x052b0,
    0x0a930,
    0x07954,
    0x06aa0,
    0x0ad50,
    0x05b52,
    0x04b60,
    0x0a6e6,
    0x0a4e0,
    0x0d260,
    0x0ea65,
    0x0d530,
    0x05aa0,
    0x076a3,
    0x096d0,
    0x04bd7,
    0x04ad0,
    0x0a4d0,
    0x1d0b6,
    0x0d250,
    0x0d520,
    0x0dd45,
    0x0b5a0,
    0x056d0,
    0x055b2,
    0x049b0,
    0x0a577,
    0x0a4b0,
    0x0aa50,
    0x1b255,
    0x06d20,
    0x0ada0,
  ];

  static int _getYearDays(int y) {
    int i, sum = 348;
    for (i = 0x8000; i > 0x8; i >>= 1) {
      sum += (lunarInfo[y - 1900] & i) != 0 ? 1 : 0;
    }
    return sum + _getLeapDays(y);
  }

  static int _getLeapDays(int y) {
    if (_getLeapMonth(y) != 0) {
      return (lunarInfo[y - 1900] & 0x10000) != 0 ? 30 : 29;
    }
    return 0;
  }

  static int _getLeapMonth(int y) {
    return lunarInfo[y - 1900] & 0xf;
  }

  static int _getMonthDays(int y, int m) {
    return (lunarInfo[y - 1900] & (0x10000 >> m)) != 0 ? 30 : 29;
  }

  /// 获取指定日期的农历显示字符串
  static String getDayString(DateTime date) {
    int i, leap = 0, temp = 0;
    DateTime baseDate = DateTime(1900, 1, 31);
    int offset = date.difference(baseDate).inDays;

    for (i = 1900; i < 2050 && offset > 0; i++) {
      temp = _getYearDays(i);
      if (offset < temp) break;
      offset -= temp;
    }

    int year = i;
    leap = _getLeapMonth(year);
    bool isLeap = false;

    for (i = 1; i < 13 && offset > 0; i++) {
      if (leap > 0 && i == (leap + 1) && !isLeap) {
        --i;
        isLeap = true;
        temp = _getLeapDays(year);
      } else {
        temp = _getMonthDays(year, i);
      }

      if (isLeap && i == (leap + 1)) isLeap = false;
      if (offset < temp) break;
      offset -= temp;
    }

    if (offset == 0 && leap > 0 && i == leap + 1) {
      if (isLeap) {
        isLeap = false;
      } else {
        isLeap = true;
        --i;
      }
    }

    if (offset < 0) {
      offset += temp;
      --i;
    }

    int day = offset + 1;
    if (day == 1) {
      return (isLeap ? '闰' : '') + lunarMonths[i - 1];
    }
    return lunarDays[day - 1];
  }
}
