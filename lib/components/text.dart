import 'package:flutter/material.dart';

/// NZText
/// 具有预定义样式的排版组件集合。
class NZText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const NZText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  /// 一级标题样式
  factory NZText.h1(String data, {Color? color, TextAlign? textAlign}) =>
      NZText(
        data,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      );

  /// 二级标题样式
  factory NZText.h2(String data, {Color? color, TextAlign? textAlign}) =>
      NZText(
        data,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      );

  /// 三级标题样式
  factory NZText.h3(String data, {Color? color, TextAlign? textAlign}) =>
      NZText(
        data,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      );

  /// 副标题样式
  factory NZText.subtitle(String data, {Color? color, TextAlign? textAlign}) =>
      NZText(
        data,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      );

  /// 正文样式 (普通)
  factory NZText.body(String data, {Color? color, TextAlign? textAlign}) =>
      NZText(
        data,
        textAlign: textAlign,
        style: TextStyle(fontSize: 16, color: color ?? Colors.black87),
      );

  /// 说明文字样式 (小号)
  factory NZText.caption(String data, {Color? color, TextAlign? textAlign}) =>
      NZText(
        data,
        textAlign: textAlign,
        style: TextStyle(fontSize: 12, color: color ?? Colors.black54),
      );

  /// 标签文字样式 (中号加粗)
  factory NZText.label(String data, {Color? color, TextAlign? textAlign}) =>
      NZText(
        data,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
