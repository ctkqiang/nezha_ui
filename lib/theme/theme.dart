import 'package:flutter/material.dart';
import 'package:nezha_ui/theme/colors.dart';

/// NZTheme 类提供了 NezhaUI 的主题配置管理。
///
/// 它可以生成符合 Material Design 规范的 [ThemeData]。
class NZTheme {
  /// 获取浅色主题配置
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: NZColor.nezhaPrimary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: NZColor.nezhaPrimary,
        primary: NZColor.nezhaPrimary,
        secondary: NZColor.nezhaSecondary,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }

  /// 获取深色主题配置
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: NZColor.nezhaPrimary,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: NZColor.nezhaPrimary,
        primary: NZColor.nezhaPrimary,
        secondary: NZColor.nezhaSecondary,
        surface: const Color(0xFF1A1A1A),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1A1A1A),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}
