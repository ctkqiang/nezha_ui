import 'package:flutter/material.dart';
import 'package:nezha_ui/theme/colors.dart';

class NZDropDownMenuItem<T> {
  final T value;
  final String label;
  final IconData? icon;

  const NZDropDownMenuItem({
    required this.value,
    required this.label,
    this.icon,
  });
}

/// NZDropDownMenu 是一个微信风格的下拉菜单组件。
/// 它通常用于在导航栏或其他触发器下方显示一组操作或选项。
/// 采用项目主色调 (NZColor.nezhaPrimary) 作为强调色。
class NZDropDownMenu<T> extends StatefulWidget {
  /// 菜单选项列表
  final List<NZDropDownMenuItem<T>> items;

  /// 当前选中的值
  final T? value;

  /// 选项改变时的回调
  final ValueChanged<T?>? onChanged;

  /// 菜单触发器的占位文本
  final String hint;

  /// 是否展开
  final bool isExpanded;

  /// 背景颜色
  final Color? backgroundColor;

  /// 文本颜色
  final Color? textColor;

  /// 激活状态的颜色（主色调）
  final Color? activeColor;

  const NZDropDownMenu({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.hint = '请选择',
    this.isExpanded = false,
    this.backgroundColor,
    this.textColor,
    this.activeColor,
  });

  @override
  State<NZDropDownMenu<T>> createState() => _NZDropDownMenuState<T>();
}

class _NZDropDownMenuState<T> extends State<NZDropDownMenu<T>>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _heightFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInQuad,
    );
  }

  @override
  void dispose() {
    _hideMenu();
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    if (_isOpen) {
      _hideMenu();
    } else {
      _showMenu();
    }
  }

  void _showMenu() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = _createOverlayEntry(size);
    Overlay.of(context).insert(_overlayEntry!);
    _controller.forward();
    setState(() => _isOpen = true);
  }

  void _hideMenu() {
    _controller.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      if (mounted) {
        setState(() => _isOpen = false);
      }
    });
  }

  OverlayEntry _createOverlayEntry(Size size) {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 点击背景关闭菜单
          GestureDetector(
            onTap: _hideMenu,
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 4),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                color: widget.backgroundColor ?? Colors.white,
                child: SizeTransition(
                  sizeFactor: _heightFactor,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        final isSelected = item.value == widget.value;
                        final activeColor =
                            widget.activeColor ?? NZColor.nezhaPrimary;

                        return InkWell(
                          onTap: () {
                            widget.onChanged?.call(item.value);
                            _hideMenu();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                if (item.icon != null) ...[
                                  Icon(
                                    item.icon,
                                    size: 20,
                                    color: isSelected
                                        ? activeColor
                                        : (widget.textColor ?? Colors.black87),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                                Expanded(
                                  child: Text(
                                    item.label,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? activeColor
                                          : (widget.textColor ??
                                                Colors.black87),
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check_rounded,
                                    size: 18,
                                    color: activeColor,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = widget.activeColor ?? NZColor.nezhaPrimary;
    final selectedItem = widget.items.cast<NZDropDownMenuItem<T>?>().firstWhere(
      (item) => item?.value == widget.value,
      orElse: () => null,
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleMenu,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isOpen ? activeColor : Colors.grey.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: widget.isExpanded
                ? MainAxisSize.max
                : MainAxisSize.min,
            children: [
              Text(
                selectedItem?.label ?? widget.hint,
                style: TextStyle(
                  fontSize: 15,
                  color: selectedItem != null
                      ? (widget.textColor ?? Colors.black87)
                      : Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: _isOpen ? activeColor : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
