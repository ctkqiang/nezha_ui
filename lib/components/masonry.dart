import 'package:flutter/material.dart';

/// NZMasonry 是 NezhaUI 提供的专业瀑布流布局组件。
///
/// 它支持多列等宽不等高的布局，非常适合展示图片、卡片流等内容。
/// 提供基础列表和生成器两种模式，并内置了平滑的进入动画。
class NZMasonry extends StatelessWidget {
  /// 子组件列表 (仅在普通构造函数中使用)
  final List<Widget>? children;

  /// 子组件生成器 (仅在 builder 构造函数中使用)
  final IndexedWidgetBuilder? itemBuilder;

  /// 子组件数量 (仅在 builder 构造函数中使用)
  final int? itemCount;

  /// 列数
  final int crossAxisCount;

  /// 主轴间距 (上下)
  final double mainAxisSpacing;

  /// 交叉轴间距 (左右)
  final double crossAxisSpacing;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 是否开启进入动画
  final bool animate;

  /// 动画持续时间
  final Duration animationDuration;

  /// 滚动物理效果
  final ScrollPhysics? physics;

  /// 是否根据子组件收缩
  final bool shrinkWrap;

  /// 滚动控制器
  final ScrollController? controller;

  /// 基础构造函数
  const NZMasonry({
    super.key,
    required List<Widget> this.children,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.padding,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 500),
    this.physics,
    this.shrinkWrap = false,
    this.controller,
  }) : itemBuilder = null,
       itemCount = null;

  /// 生成器构造函数
  const NZMasonry.builder({
    super.key,
    required IndexedWidgetBuilder this.itemBuilder,
    required int this.itemCount,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.padding,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 500),
    this.physics,
    this.shrinkWrap = false,
    this.controller,
  }) : children = null;

  @override
  Widget build(BuildContext context) {
    final count = itemCount ?? children?.length ?? 0;
    if (count == 0) return const SizedBox.shrink();

    Widget masonryContent = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(crossAxisCount, (columnIndex) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: crossAxisSpacing / 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _getChildrenForColumn(context, columnIndex, count),
              ),
            ),
          );
        }),
      ),
    );

    if (shrinkWrap) {
      return masonryContent;
    }

    return SingleChildScrollView(
      controller: controller,
      physics: physics,
      child: masonryContent,
    );
  }

  List<Widget> _getChildrenForColumn(
    BuildContext context,
    int columnIndex,
    int totalCount,
  ) {
    List<Widget> columnChildren = [];

    for (int i = columnIndex; i < totalCount; i += crossAxisCount) {
      Widget child;
      if (itemBuilder != null) {
        child = itemBuilder!(context, i);
      } else {
        child = children![i];
      }

      if (animate) {
        child = _AnimatedMasonryItem(
          index: i,
          duration: animationDuration,
          child: child,
        );
      }

      columnChildren.add(child);
      if (i + crossAxisCount < totalCount) {
        columnChildren.add(SizedBox(height: mainAxisSpacing));
      }
    }
    return columnChildren;
  }
}

class _AnimatedMasonryItem extends StatefulWidget {
  final int index;
  final Duration duration;
  final Widget child;

  const _AnimatedMasonryItem({
    required this.index,
    required this.duration,
    required this.child,
  });

  @override
  State<_AnimatedMasonryItem> createState() => _AnimatedMasonryItemState();
}

class _AnimatedMasonryItemState extends State<_AnimatedMasonryItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );

    _slide = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
          ),
        );

    // 根据索引延迟执行动画，形成交错效果
    Future.delayed(Duration(milliseconds: widget.index * 50), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: FractionalTranslation(translation: _slide.value, child: child),
        );
      },
      child: widget.child,
    );
  }
}
