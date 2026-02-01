import 'package:flutter/material.dart';

/// [NZColor] 类定义了应用程序使用的所有核心色彩方案
/// 包含 10 个色阶的 Material Design 标准调色板
class NZColor {
  // 红色系 (主色调) - 10 个色阶
  static const Color red50 = Color(0xFFFFEBEE); // 极浅红
  static const Color red100 = Color(0xFFFFCDD2); // 浅红
  static const Color red200 = Color(0xFFEF9A9A); // 淡红
  static const Color red300 = Color(0xFFE57373); // 亮红
  static const Color red400 = Color(0xFFEF5350); // 鲜红
  static const Color red500 = Color(0xFFF44336); // 标准红 (基准色)
  static const Color red600 = Color(0xFFE53935); // 中红
  static const Color red700 = Color(0xFFD32F2F); // 深红
  static const Color red800 = Color(0xFFC62828); // 浓红
  static const Color red900 = Color(0xFFB71C1C); // 极深红

  /// 应用程序主色调，默认为标准红色
  static const Color nezhaPrimary = red500;

  // 橙色系 (辅助色) - 10 个色阶
  static const Color orange50 = Color(0xFFFFF3E0); // 极浅橙
  static const Color orange100 = Color(0xFFFFE0B2); // 浅橙
  static const Color orange200 = Color(0xFFFFCC80); // 淡橙
  static const Color orange300 = Color(0xFFFFB74D); // 亮橙
  static const Color orange400 = Color(0xFFFFA726); // 鲜橙
  static const Color orange500 = Color(0xFFFF9800); // 标准橙 (基准色)
  static const Color orange600 = Color(0xFFFB8C00); // 中橙
  static const Color orange700 = Color(0xFFF57C00); // 深橙
  static const Color orange800 = Color(0xFFEF6C00); // 浓橙
  static const Color orange900 = Color(0xFFE65100); // 极深橙

  /// 应用程序辅助色调，默认为标准橙色
  static const Color nezhaSecondary = orange500;

  // 黄色系 (次要辅助色) - 10 个色阶
  static const Color yellow50 = Color(0xFFFFFDE7); // 极浅黄
  static const Color yellow100 = Color(0xFFFFF9C4); // 浅黄
  static const Color yellow200 = Color(0xFFFFF59D); // 淡黄
  static const Color yellow300 = Color(0xFFFFF176); // 亮黄
  static const Color yellow400 = Color(0xFFFFEE58); // 鲜黄
  static const Color yellow500 = Color(0xFFFFEB3B); // 标准黄 (基准色)
  static const Color yellow600 = Color(0xFFFDD835); // 中黄
  static const Color yellow700 = Color(0xFFFBC02D); // 深黄
  static const Color yellow800 = Color(0xFFF9A825); // 浓黄
  static const Color yellow900 = Color(0xFFF57F17); // 极深黄

  /// 应用程序次要辅助色，默认为标准黄色
  static const Color nezhaSub = yellow500;

  // 粉色系 - 10 个色阶
  static const Color pink50 = Color(0xFFFCE4EC); // 极浅粉
  static const Color pink100 = Color(0xFFF8BBD0); // 浅粉
  static const Color pink200 = Color(0xFFF48FB1); // 淡粉
  static const Color pink300 = Color(0xFFF06292); // 亮粉
  static const Color pink400 = Color(0xFFEC407A); // 鲜粉
  static const Color pink500 = Color(0xFFE91E63); // 标准粉 (基准色)
  static const Color pink600 = Color(0xFFD81B60); // 中粉
  static const Color pink700 = Color(0xFFC2185B); // 深粉
  static const Color pink800 = Color(0xFFAD1457); // 浓粉
  static const Color pink900 = Color(0xFF880E4F); // 极深粉

  // 紫色系 - 10 个色阶
  static const Color purple50 = Color(0xFFF3E5F5); // 极浅紫
  static const Color purple100 = Color(0xFFE1BEE7); // 浅紫
  static const Color purple200 = Color(0xFFCE93D8); // 淡紫
  static const Color purple300 = Color(0xFFBA68C8); // 亮紫
  static const Color purple400 = Color(0xFFAB47BC); // 鲜紫
  static const Color purple500 = Color(0xFF9C27B0); // 标准紫 (基准色)
  static const Color purple600 = Color(0xFF8E24AA); // 中紫
  static const Color purple700 = Color(0xFF7B1FA2); // 深紫
  static const Color purple800 = Color(0xFF6A1B9A); // 浓紫
  static const Color purple900 = Color(0xFF4A148C); // 极深紫

  // 深紫色系 - 10 个色阶
  static const Color deepPurple50 = Color(0xFFEDE7F6); // 极浅深紫
  static const Color deepPurple100 = Color(0xFFD1C4E9); // 浅深紫
  static const Color deepPurple200 = Color(0xFFB39DDB); // 淡深紫
  static const Color deepPurple300 = Color(0xFF9575CD); // 亮深紫
  static const Color deepPurple400 = Color(0xFF7E57C2); // 鲜深紫
  static const Color deepPurple500 = Color(0xFF673AB7); // 标准深紫 (基准色)
  static const Color deepPurple600 = Color(0xFF5E35B1); // 中深紫
  static const Color deepPurple700 = Color(0xFF512DA8); // 深深紫
  static const Color deepPurple800 = Color(0xFF4527A0); // 浓深紫
  static const Color deepPurple900 = Color(0xFF311B92); // 极深深紫

  // 靛蓝色系 - 10 个色阶
  static const Color indigo50 = Color(0xFFE8EAF6); // 极浅靛蓝
  static const Color indigo100 = Color(0xFFC5CAE9); // 浅靛蓝
  static const Color indigo200 = Color(0xFF9FA8DA); // 淡靛蓝
  static const Color indigo300 = Color(0xFF7986CB); // 亮靛蓝
  static const Color indigo400 = Color(0xFF5C6BC0); // 鲜靛蓝
  static const Color indigo500 = Color(0xFF3F51B5); // 标准靛蓝 (基准色)
  static const Color indigo600 = Color(0xFF3949AB); // 中靛蓝
  static const Color indigo700 = Color(0xFF303F9F); // 深靛蓝
  static const Color indigo800 = Color(0xFF283593); // 浓靛蓝
  static const Color indigo900 = Color(0xFF1A237E); // 极深靛蓝

  // 蓝色系 - 10 个色阶
  static const Color blue50 = Color(0xFFE3F2FD); // 极浅蓝
  static const Color blue100 = Color(0xFFBBDEFB); // 浅蓝
  static const Color blue200 = Color(0xFF90CAF9); // 淡蓝
  static const Color blue300 = Color(0xFF64B5F6); // 亮蓝
  static const Color blue400 = Color(0xFF42A5F5); // 鲜蓝
  static const Color blue500 = Color(0xFF2196F3); // 标准蓝 (基准色)
  static const Color blue600 = Color(0xFF1E88E5); // 中蓝
  static const Color blue700 = Color(0xFF1976D2); // 深蓝
  static const Color blue800 = Color(0xFF1565C0); // 浓蓝
  static const Color blue900 = Color(0xFF0D47A1); // 极深蓝

  // 浅蓝色系 - 10 个色阶
  static const Color lightBlue50 = Color(0xFFE1F5FE); // 极浅亮蓝
  static const Color lightBlue100 = Color(0xFFB3E5FC); // 浅亮蓝
  static const Color lightBlue200 = Color(0xFF81D4FA); // 淡亮蓝
  static const Color lightBlue300 = Color(0xFF4FC3F7); // 亮亮蓝
  static const Color lightBlue400 = Color(0xFF29B6F6); // 鲜亮蓝
  static const Color lightBlue500 = Color(0xFF03A9F4); // 标准亮蓝 (基准色)
  static const Color lightBlue600 = Color(0xFF039BE5); // 中亮蓝
  static const Color lightBlue700 = Color(0xFF0288D1); // 深亮蓝
  static const Color lightBlue800 = Color(0xFF0277BD); // 浓亮蓝
  static const Color lightBlue900 = Color(0xFF01579B); // 极深亮蓝

  // 青色系 - 10 个色阶
  static const Color cyan50 = Color(0xFFE0F7FA); // 极浅青
  static const Color cyan100 = Color(0xFFB2EBF2); // 浅青
  static const Color cyan200 = Color(0xFF80DEEA); // 淡青
  static const Color cyan300 = Color(0xFF4DD0E1); // 亮青
  static const Color cyan400 = Color(0xFF26C6DA); // 鲜青
  static const Color cyan500 = Color(0xFF00BCD4); // 标准青 (基准色)
  static const Color cyan600 = Color(0xFF00ACC1); // 中青
  static const Color cyan700 = Color(0xFF0097A7); // 深青
  static const Color cyan800 = Color(0xFF00838F); // 浓青
  static const Color cyan900 = Color(0xFF006064); // 极深青

  // 青绿色系 - 10 个色阶
  static const Color teal50 = Color(0xFFE0F2F1); // 极浅青绿
  static const Color teal100 = Color(0xFFB2DFDB); // 浅青绿
  static const Color teal200 = Color(0xFF80CBC4); // 淡青绿
  static const Color teal300 = Color(0xFF4DB6AC); // 亮青绿
  static const Color teal400 = Color(0xFF26A69A); // 鲜青绿
  static const Color teal500 = Color(0xFF009688); // 标准青绿 (基准色)
  static const Color teal600 = Color(0xFF00897B); // 中青绿
  static const Color teal700 = Color(0xFF00796B); // 深青绿
  static const Color teal800 = Color(0xFF00695C); // 浓青绿
  static const Color teal900 = Color(0xFF004D40); // 极深青绿

  // 绿色系 - 10 个色阶
  static const Color green50 = Color(0xFFE8F5E9); // 极浅绿
  static const Color green100 = Color(0xFFC8E6C9); // 浅绿
  static const Color green200 = Color(0xFFA5D6A7); // 淡绿
  static const Color green300 = Color(0xFF81C784); // 亮绿
  static const Color green400 = Color(0xFF66BB6A); // 鲜绿
  static const Color green500 = Color(0xFF4CAF50); // 标准绿 (基准色)
  static const Color green600 = Color(0xFF43A047); // 中绿
  static const Color green700 = Color(0xFF388E3C); // 深绿
  static const Color green800 = Color(0xFF2E7D32); // 浓绿
  static const Color green900 = Color(0xFF1B5E20); // 极深绿

  // 浅绿色系 - 10 个色阶
  static const Color lightGreen50 = Color(0xFFF1F8E9); // 极浅亮绿
  static const Color lightGreen100 = Color(0xFFDCEDC8); // 浅亮绿
  static const Color lightGreen200 = Color(0xFFC5E1A5); // 淡亮绿
  static const Color lightGreen300 = Color(0xFFAED581); // 亮亮绿
  static const Color lightGreen400 = Color(0xFF9CCC65); // 鲜亮绿
  static const Color lightGreen500 = Color(0xFF8BC34A); // 标准亮绿 (基准色)
  static const Color lightGreen600 = Color(0xFF7CB342); // 中亮绿
  static const Color lightGreen700 = Color(0xFF689F38); // 深亮绿
  static const Color lightGreen800 = Color(0xFF558B2F); // 浓亮绿
  static const Color lightGreen900 = Color(0xFF33691E); // 极深亮绿

  // 柠檬绿色系 - 10 个色阶
  static const Color lime50 = Color(0xFFF9FBE7); // 极浅柠檬绿
  static const Color lime100 = Color(0xFFF0F4C3); // 浅柠檬绿
  static const Color lime200 = Color(0xFFE6EE9C); // 淡柠檬绿
  static const Color lime300 = Color(0xFFDCE775); // 亮柠檬绿
  static const Color lime400 = Color(0xFFD4E157); // 鲜柠檬绿
  static const Color lime500 = Color(0xFFCDDC39); // 标准柠檬绿 (基准色)
  static const Color lime600 = Color(0xFFC0CA33); // 中柠檬绿
  static const Color lime700 = Color(0xFFAFB42B); // 深柠檬绿
  static const Color lime800 = Color(0xFF9E9D24); // 浓柠檬绿
  static const Color lime900 = Color(0xFF827717); // 极深柠檬绿

  // 琥珀色系 - 10 个色阶
  static const Color amber50 = Color(0xFFFFF8E1); // 极浅琥珀
  static const Color amber100 = Color(0xFFFFECB3); // 浅琥珀
  static const Color amber200 = Color(0xFFFFE082); // 淡琥珀
  static const Color amber300 = Color(0xFFFFD54F); // 亮琥珀
  static const Color amber400 = Color(0xFFFFCA28); // 鲜琥珀
  static const Color amber500 = Color(0xFFFFC107); // 标准琥珀 (基准色)
  static const Color amber600 = Color(0xFFFFB300); // 中琥珀
  static const Color amber700 = Color(0xFFFFA000); // 深琥珀
  static const Color amber800 = Color(0xFFFF8F00); // 浓琥珀
  static const Color amber900 = Color(0xFFFF6F00); // 极深琥珀

  // 深橙色系 - 10 个色阶
  static const Color deepOrange50 = Color(0xFFFBE9E7); // 极浅深橙
  static const Color deepOrange100 = Color(0xFFFFCCBC); // 浅深橙
  static const Color deepOrange200 = Color(0xFFFFAB91); // 淡深橙
  static const Color deepOrange300 = Color(0xFFFF8A65); // 亮深橙
  static const Color deepOrange400 = Color(0xFFFF7043); // 鲜深橙
  static const Color deepOrange500 = Color(0xFFFF5722); // 标准深橙 (基准色)
  static const Color deepOrange600 = Color(0xFFF4511E); // 中深橙
  static const Color deepOrange700 = Color(0xFFE64A19); // 深深橙
  static const Color deepOrange800 = Color(0xFFD84315); // 浓深橙
  static const Color deepOrange900 = Color(0xFFBF360C); // 极深深橙

  // 棕色系 - 10 个色阶
  static const Color brown50 = Color(0xFFEFEBE9); // 极浅棕
  static const Color brown100 = Color(0xFFD7CCC8); // 浅棕
  static const Color brown200 = Color(0xFFBCAAA4); // 淡棕
  static const Color brown300 = Color(0xFFA1887F); // 亮棕
  static const Color brown400 = Color(0xFF8D6E63); // 鲜棕
  static const Color brown500 = Color(0xFF795548); // 标准棕 (基准色)
  static const Color brown600 = Color(0xFF6D4C41); // 中棕
  static const Color brown700 = Color(0xFF5D4037); // 深棕
  static const Color brown800 = Color(0xFF4E342E); // 浓棕
  static const Color brown900 = Color(0xFF3E2723); // 极深棕

  // 灰色系 - 10 个色阶
  static const Color grey50 = Color(0xFFFAFAFA); // 极浅灰
  static const Color grey100 = Color(0xFFF5F5F5); // 浅灰
  static const Color grey200 = Color(0xFFEEEEEE); // 淡灰
  static const Color grey300 = Color(0xFFE0E0E0); // 亮灰
  static const Color grey400 = Color(0xFFBDBDBD); // 鲜灰
  static const Color grey500 = Color(0xFF9E9E9E); // 标准灰 (基准色)
  static const Color grey600 = Color(0xFF757575); // 中灰
  static const Color grey700 = Color(0xFF616161); // 深灰
  static const Color grey800 = Color(0xFF424242); // 浓灰
  static const Color grey900 = Color(0xFF212121); // 极深灰

  // 蓝灰色系 - 10 个色阶
  static const Color blueGrey50 = Color(0xFFECEFF1); // 极浅蓝灰
  static const Color blueGrey100 = Color(0xFFCFD8DC); // 浅蓝灰
  static const Color blueGrey200 = Color(0xFFB0BEC5); // 淡蓝灰
  static const Color blueGrey300 = Color(0xFF90A4AE); // 亮蓝灰
  static const Color blueGrey400 = Color(0xFF78909C); // 鲜蓝灰
  static const Color blueGrey500 = Color(0xFF607D8B); // 标准蓝灰 (基准色)
  static const Color blueGrey600 = Color(0xFF546E7A); // 中蓝灰
  static const Color blueGrey700 = Color(0xFF455A64); // 深蓝灰
  static const Color blueGrey800 = Color(0xFF37474F); // 浓蓝灰
  static const Color blueGrey900 = Color(0xFF263238); // 极深蓝灰
}
