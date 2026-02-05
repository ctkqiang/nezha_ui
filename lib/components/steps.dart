import 'package:flutter/material.dart';
import '../theme/colors.dart';

/// NZStep 步骤条的单步配置
class NZStep {
  /// 标题
  final String title;

  /// 描述信息
  final String? description;

  /// 图标
  final IconData? icon;

  const NZStep({required this.title, this.description, this.icon});
}

/// NZSteps 是 NezhaUI 提供的专业步骤条组件。
///
/// 用于展示一个任务的进度，或引导用户按照流程完成任务。
class NZSteps extends StatelessWidget {
  /// 步骤列表
  final List<NZStep> steps;

  /// 当前进行的步骤索引 (从 0 开始)
  final int current;

  /// 排列方向
  final Axis direction;

  /// 主色调
  final Color? color;

  const NZSteps({
    super.key,
    required this.steps,
    this.current = 0,
    this.direction = Axis.horizontal,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color primary = color ?? NZColor.nezhaPrimary;

    if (direction == Axis.horizontal) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(steps.length, (index) {
          final bool isLast = index == steps.length - 1;
          return Expanded(
            flex: isLast ? 0 : 1,
            child: _buildStep(context, index, isLast, isDark, primary),
          );
        }),
      );
    } else {
      return Column(
        children: List.generate(steps.length, (index) {
          final bool isLast = index == steps.length - 1;
          return _buildStep(context, index, isLast, isDark, primary);
        }),
      );
    }
  }

  Widget _buildStep(
    BuildContext context,
    int index,
    bool isLast,
    bool isDark,
    Color primary,
  ) {
    final bool isCompleted = index < current;
    final bool isActive = index == current;

    final Color statusColor = isCompleted || isActive
        ? primary
        : (isDark ? Colors.white38 : Colors.black26);

    if (direction == Axis.horizontal) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildCircle(index, isCompleted, isActive, isDark, primary),
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: isCompleted
                        ? primary
                        : statusColor.withValues(alpha: 0.2),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  steps[index].title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive
                        ? (isDark ? Colors.white : Colors.black87)
                        : (isDark ? Colors.white38 : Colors.black45),
                  ),
                ),
                if (steps[index].description != null)
                  Text(
                    steps[index].description!,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white30 : Colors.black38,
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    } else {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _buildCircle(index, isCompleted, isActive, isDark, primary),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: isCompleted
                          ? primary
                          : statusColor.withValues(alpha: 0.2),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[index].title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isActive
                            ? (isDark ? Colors.white : Colors.black87)
                            : (isDark ? Colors.white38 : Colors.black45),
                      ),
                    ),
                    if (steps[index].description != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          steps[index].description!,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.white30 : Colors.black38,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildCircle(
    int index,
    bool isCompleted,
    bool isActive,
    bool isDark,
    Color primary,
  ) {
    if (isCompleted) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          border: Border.all(color: primary, width: 1),
        ),
        child: Icon(Icons.check_rounded, size: 14, color: primary),
      );
    }

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isActive ? primary : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive
              ? primary
              : (isDark ? Colors.white24 : Colors.black12),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isActive
                ? Colors.white
                : (isDark ? Colors.white38 : Colors.black38),
          ),
        ),
      ),
    );
  }
}
