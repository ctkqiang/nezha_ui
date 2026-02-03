import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/colors.dart';

/// 分页器形状
enum NZPaginationShape {
  /// 矩形 (圆角)
  square,

  /// 圆形
  circle,
}

/// 分页器样式类型
enum NZPaginationType {
  /// 填充样式
  filled,

  /// 描边样式
  outline,

  /// 浅色背景样式
  light,
}

/// NZPagination 是 NezhaUI 提供的专业分页器组件。
///
/// 用于将大量数据分割成多页展示，支持直接跳转、上一页/下一页等功能。
class NZPagination extends StatefulWidget {
  /// 总条目数
  final int total;

  /// 每页条数
  final int pageSize;

  /// 当前页码 (从 1 开始)
  final int current;

  /// 点击页码回调
  final ValueChanged<int>? onPageChanged;

  /// 是否显示首尾页按钮
  final bool showFirstLast;

  /// 主色调
  final Color? color;

  /// 形状
  final NZPaginationShape shape;

  /// 样式类型
  final NZPaginationType type;

  /// 是否显示快速跳转
  final bool showQuickJumper;

  /// 是否启用滚动模式 (当页码过多时)
  final bool scrollable;

  /// 禁用状态
  final bool disabled;

  const NZPagination({
    super.key,
    required this.total,
    this.current = 1,
    this.pageSize = 10,
    this.onPageChanged,
    this.showFirstLast = false,
    this.color,
    this.shape = NZPaginationShape.square,
    this.type = NZPaginationType.filled,
    this.showQuickJumper = false,
    this.scrollable = false,
    this.disabled = false,
  });

  @override
  State<NZPagination> createState() => _NZPaginationState();
}

class _NZPaginationState extends State<NZPagination> {
  late TextEditingController _jumpController;

  @override
  void initState() {
    super.initState();
    _jumpController = TextEditingController();
  }

  @override
  void dispose() {
    _jumpController.dispose();
    super.dispose();
  }

  int get _totalPages => (widget.total / widget.pageSize).ceil();

  void _handlePageChange(int page) {
    if (widget.disabled) return;
    if (page < 1 || page > _totalPages) return;
    widget.onPageChanged?.call(page);
  }

  void _handleJump() {
    final value = int.tryParse(_jumpController.text);
    if (value != null) {
      _handlePageChange(value);
      _jumpController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.total <= 0) return const SizedBox.shrink();

    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color primary = widget.color ?? NZColor.nezhaPrimary;

    Widget paginationContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.showFirstLast)
          _buildActionBtn(
            context,
            Icons.first_page_rounded,
            widget.current > 1,
            () => _handlePageChange(1),
            isDark,
            primary,
          ),
        _buildActionBtn(
          context,
          Icons.chevron_left_rounded,
          widget.current > 1,
          () => _handlePageChange(widget.current - 1),
          isDark,
          primary,
        ),
        const SizedBox(width: 4),
        if (widget.scrollable)
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: _buildPageNumbers(context, isDark, primary),
            ),
          )
        else
          _buildPageNumbers(context, isDark, primary),
        const SizedBox(width: 4),
        _buildActionBtn(
          context,
          Icons.chevron_right_rounded,
          widget.current < _totalPages,
          () => _handlePageChange(widget.current + 1),
          isDark,
          primary,
        ),
        if (widget.showFirstLast)
          _buildActionBtn(
            context,
            Icons.last_page_rounded,
            widget.current < _totalPages,
            () => _handlePageChange(_totalPages),
            isDark,
            primary,
          ),
        if (widget.showQuickJumper) ...[
          const SizedBox(width: 12),
          _buildQuickJumper(isDark, primary),
        ],
      ],
    );

    return Opacity(
      opacity: widget.disabled ? 0.5 : 1.0,
      child: IgnorePointer(ignoring: widget.disabled, child: paginationContent),
    );
  }

  Widget _buildPageNumbers(BuildContext context, bool isDark, Color primary) {
    List<Widget> items = [];

    if (widget.scrollable) {
      // 滚动模式下显示所有页码
      for (int i = 1; i <= _totalPages; i++) {
        items.add(_buildPageItem(i, isDark, primary));
      }
    } else {
      // 非滚动模式下使用省略号逻辑
      if (_totalPages <= 7) {
        for (int i = 1; i <= _totalPages; i++) {
          items.add(_buildPageItem(i, isDark, primary));
        }
      } else {
        // 始终显示第一页
        items.add(_buildPageItem(1, isDark, primary));

        if (widget.current > 4) {
          items.add(_buildEllipsis(isDark));
        }

        // 中间部分
        int start = (widget.current - 2).clamp(2, _totalPages - 1);
        int end = (widget.current + 2).clamp(2, _totalPages - 1);

        if (widget.current <= 4) end = 5;
        if (widget.current >= _totalPages - 3) start = _totalPages - 4;

        for (int i = start; i <= end; i++) {
          items.add(_buildPageItem(i, isDark, primary));
        }

        if (widget.current < _totalPages - 3) {
          items.add(_buildEllipsis(isDark));
        }

        // 始终显示最后一页
        items.add(_buildPageItem(_totalPages, isDark, primary));
      }
    }

    return Row(mainAxisSize: MainAxisSize.min, children: items);
  }

  Widget _buildPageItem(int page, bool isDark, Color primary) {
    final bool isSelected = page == widget.current;

    Color bgColor;
    Color borderColor;
    Color textColor;

    switch (widget.type) {
      case NZPaginationType.filled:
        bgColor = isSelected ? primary : Colors.transparent;
        borderColor = isSelected
            ? primary
            : (isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05));
        textColor = isSelected
            ? Colors.white
            : (isDark ? Colors.white70 : Colors.black87);
        break;
      case NZPaginationType.outline:
        bgColor = Colors.transparent;
        borderColor = isSelected
            ? primary
            : (isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05));
        textColor = isSelected
            ? primary
            : (isDark ? Colors.white70 : Colors.black87);
        break;
      case NZPaginationType.light:
        bgColor = isSelected
            ? primary.withValues(alpha: 0.1)
            : Colors.transparent;
        borderColor = isSelected
            ? primary.withValues(alpha: 0.2)
            : Colors.transparent;
        textColor = isSelected
            ? primary
            : (isDark ? Colors.white70 : Colors.black87);
        break;
    }

    return GestureDetector(
      onTap: () => _handlePageChange(page),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: bgColor,
          shape: widget.shape == NZPaginationShape.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
          borderRadius: widget.shape == NZPaginationShape.square
              ? BorderRadius.circular(8)
              : null,
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis(bool isDark) {
    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      child: Text(
        '...',
        style: TextStyle(
          color: isDark ? Colors.white38 : Colors.black38,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildActionBtn(
    BuildContext context,
    IconData icon,
    bool enabled,
    VoidCallback onTap,
    bool isDark,
    Color primary,
  ) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 34,
        height: 34,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.02),
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled
              ? (isDark ? Colors.white70 : Colors.black87)
              : (isDark ? Colors.white10 : Colors.black12),
        ),
      ),
    );
  }

  Widget _buildQuickJumper(bool isDark, Color primary) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '跳至',
          style: TextStyle(
            fontSize: 13,
            color: isDark ? Colors.white60 : Colors.black54,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 44,
          height: 34,
          child: TextField(
            controller: _jumpController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.02),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: primary, width: 1),
              ),
            ),
            onSubmitted: (_) => _handleJump(),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '页',
          style: TextStyle(
            fontSize: 13,
            color: isDark ? Colors.white60 : Colors.black54,
          ),
        ),
      ],
    );
  }
}
