import 'package:flutter/material.dart';
import 'package:nezha_ui/theme/colors.dart';

/// NZThemeConfig 允许开发者自定义 NezhaUI 的外观和感觉。
///
/// 通过配置主色调、圆角半径和字体等参数，可以轻松实现个性化定制。
class NZThemeConfig {
  /// 主色调
  final Color primaryColor;

  /// 次色调
  final Color secondaryColor;

  /// 全局圆角半径
  final double borderRadius;

  /// 页面背景颜色 (浅色)
  final Color lightScaffoldBackgroundColor;

  /// 页面背景颜色 (深色)
  final Color darkScaffoldBackgroundColor;

  /// 默认字体族
  final String? fontFamily;

  const NZThemeConfig({
    this.primaryColor = NZColor.nezhaPrimary,
    this.secondaryColor = NZColor.nezhaSecondary,
    this.borderRadius = 12.0,
    this.lightScaffoldBackgroundColor = const Color(0xFFF8F9FA),
    this.darkScaffoldBackgroundColor = const Color(0xFF121212),
    this.fontFamily,
  });

  /// 默认配置
  static const NZThemeConfig defaultContent = NZThemeConfig();
}

/// NZTheme 类提供了 NezhaUI 的主题配置管理。
///
/// 它可以根据 [NZThemeConfig] 生成符合 Material Design 规范的 [ThemeData]。
class NZTheme {
  /// 获取浅色主题配置
  ///
  /// [config] 可选的主题配置参数，若不提供则使用默认配置。
  static ThemeData lightTheme([
    NZThemeConfig config = NZThemeConfig.defaultContent,
  ]) {
    return ThemeData(
      useMaterial3: true,
      primaryColor: config.primaryColor,
      fontFamily: config.fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: config.primaryColor,
        primary: config.primaryColor,
        secondary: config.secondaryColor,
        surface: Colors.white,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: config.lightScaffoldBackgroundColor,
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
  ///
  /// [config] 可选的主题配置参数，若不提供则使用默认配置。
  static ThemeData darkTheme([
    NZThemeConfig config = NZThemeConfig.defaultContent,
  ]) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: config.primaryColor,
      fontFamily: config.fontFamily,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: config.primaryColor,
        primary: config.primaryColor,
        secondary: config.secondaryColor,
        surface: const Color(0xFF1A1A1A),
      ),
      scaffoldBackgroundColor: config.darkScaffoldBackgroundColor,
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
