import 'package:flutter/material.dart';
import 'package:nezha_ui/theme/colors.dart';

/// NZDivider 是 NezhaUI 提供的分割线组件。
///
/// 相比于标准的 Divider，它提供了更细致的间距控制和主题集成。
class NZDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  const NZDivider({
    super.key,
    this.height = 16.0,
    this.thickness = 1.0,
    this.indent,
    this.endIndent,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color ?? Colors.grey.withOpacity(0.2),
    );
  }
}
