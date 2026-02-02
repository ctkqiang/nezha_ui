import 'package:flutter/material.dart';

/// 代码查看器主题
enum NZCodeTheme {
  /// GitHub Light 风格 (白色背景)
  githubLight,

  /// GitHub Dark 风格 (深色背景)
  githubDark,
}

/// NZCodeView
/// 一个支持 GitHub Light/Dark 主题的代码高亮查看组件
class NZCodeView extends StatelessWidget {
  /// 需要显示的代码内容
  final String code;

  /// 主题模式，默认 githubLight
  final NZCodeTheme theme;

  /// 字体大小
  final double fontSize;

  /// 内边距
  final EdgeInsets padding;

  /// 是否显示行号 (预留功能)
  final bool showLineNumbers;

  const NZCodeView({
    super.key,
    required this.code,
    this.theme = NZCodeTheme.githubLight,
    this.fontSize = 13.0,
    this.padding = const EdgeInsets.all(16.0),
    this.showLineNumbers = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = theme == NZCodeTheme.githubDark;

    // GitHub 风格配色
    final Color bgColor = isDark
        ? const Color(0xFF0D1117)
        : const Color(0xFFF6F8FA);
    final Color textColor = isDark
        ? const Color(0xFFC9D1D9)
        : const Color(0xFF24292E);
    final Color borderColor = isDark
        ? const Color(0xFF30363D)
        : const Color(0xFFE1E4E8);
    final Color lineNumberColor = isDark
        ? const Color(0xFF484F58)
        : const Color(0xFF6A737D);
    final Color lineNumberBgColor = isDark
        ? const Color(0xFF0D1117)
        : const Color(0xFFF6F8FA);

    final List<String> lines = code.split('\n');
    final int lineCount = lines.length;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showLineNumbers)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: lineNumberBgColor,
                    border: Border(right: BorderSide(color: borderColor)),
                  ),
                  child: Column(
                    children: List.generate(
                      lineCount,
                      (index) => Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: lineNumberColor,
                          fontFamily: 'monospace',
                          fontSize: fontSize,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: padding,
                child: SingleChildScrollView(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: textColor,
                        fontFamily: 'monospace',
                        fontSize: fontSize,
                        height: 1.5,
                      ),
                      children: _highlightCode(code, isDark),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<TextSpan> _highlightCode(String code, bool isDark) {
    final List<TextSpan> spans = [];

    // GitHub Light 颜色
    const lightComment = Color(0xFF6A737D);
    const lightString = Color(0xFF032F62);
    const lightKeyword = Color(0xFFD73A49);
    const lightClass = Color(0xFF6F42C1);
    const lightNumber = Color(0xFF005CC5);

    // GitHub Dark 颜色
    const darkComment = Color(0xFF8B949E);
    const darkString = Color(0xFFA5D6FF);
    const darkKeyword = Color(0xFFFF7B72);
    const darkClass = Color(0xFFD2A8FF);
    const darkNumber = Color(0xFF79C0FF);

    final commentColor = isDark ? darkComment : lightComment;
    final stringColor = isDark ? darkString : lightString;
    final keywordColor = isDark ? darkKeyword : lightKeyword;
    final classColor = isDark ? darkClass : lightClass;
    final numberColor = isDark ? darkNumber : lightNumber;

    final pattern = RegExp(
      r'(\/\/.*|\/\*[\s\S]*?\*\/)|'
      r'(".*?"|'
      "'"
      r".*?')|" // 2: 字符串
      r'(\b(?:void|class|final|const|var|if|else|return|await|async|import|package|extends|super|this|new|true|false|public|private|protected|static|abstract|interface|enum|byte|short|int|long|float|double|boolean|char|String|List|Map|Set|struct|typedef|union|volatile|extern|inline|virtual|override|nullptr|nil|func|let|type|range|chan|go|select|case|default|switch|for|while|do|break|continue|goto|try|catch|finally|throw|throws|synchronized|native|transient|strictfp|assert|module|requires|exports|opens|uses|provides|with|to|using|namespace|dynamic|is|as|yield|get|set|factory|operator|bool|num|dynamic|external|late|required)\b)|' // 3: 通用关键字
      r'(\b[A-Z][a-zA-Z0-9]*\b)|'
      r'(\b\d+\.?\d*\b)|'
      r'(@\w+)', //
      multiLine: true,
    );

    int lastMatchEnd = 0;
    for (final match in pattern.allMatches(code)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: code.substring(lastMatchEnd, match.start)));
      }

      if (match.group(1) != null) {
        spans.add(
          TextSpan(
            text: match.group(1),
            style: TextStyle(color: commentColor, fontStyle: FontStyle.italic),
          ),
        );
      } else if (match.group(2) != null) {
        spans.add(
          TextSpan(
            text: match.group(2),
            style: TextStyle(color: stringColor),
          ),
        );
      } else if (match.group(3) != null) {
        spans.add(
          TextSpan(
            text: match.group(3),
            style: TextStyle(color: keywordColor, fontWeight: FontWeight.bold),
          ),
        );
      } else if (match.group(4) != null) {
        spans.add(
          TextSpan(
            text: match.group(4),
            style: TextStyle(color: classColor),
          ),
        );
      } else if (match.group(5) != null) {
        spans.add(
          TextSpan(
            text: match.group(5),
            style: TextStyle(color: numberColor),
          ),
        );
      } else if (match.group(6) != null) {
        spans.add(
          TextSpan(
            text: match.group(6),
            style: TextStyle(color: keywordColor),
          ),
        );
      }

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < code.length) {
      spans.add(TextSpan(text: code.substring(lastMatchEnd)));
    }

    return spans;
  }
}
