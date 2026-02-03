import 'dart:math';
import 'package:flutter/foundation.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:nezha_ui/nezha.dart';
import 'docs_site.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const NezhaUIExample());
}

class NezhaUIExample extends StatefulWidget {
  const NezhaUIExample({super.key});

  @override
  State<NezhaUIExample> createState() => _NezhaUIExampleState();
}

class _NezhaUIExampleState extends State<NezhaUIExample> {
  NZThemeConfig _currentConfig = NZThemeConfig.defaultContent;
  ThemeMode _themeMode = ThemeMode.system;

  void _updateConfig(NZThemeConfig config) {
    setState(() {
      _currentConfig = config;
    });
  }

  void _updateThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NezhaApp(
      title: 'NezhaUI 示例',
      theme: NZTheme.lightTheme(_currentConfig),
      darkTheme: NZTheme.darkTheme(_currentConfig),
      themeMode: _themeMode,
      showPerformanceOverlay: kProfileMode,
      debugShowCheckedModeBanner: kDebugMode,
      home: kIsWeb
          ? const NZDocsSite()
          : HomePage(
              currentConfig: _currentConfig,
              onConfigChanged: _updateConfig,
              themeMode: _themeMode,
              onThemeModeChanged: _updateThemeMode,
            ),
    );
  }
}

class HomePage extends StatefulWidget {
  final NZThemeConfig currentConfig;
  final ValueChanged<NZThemeConfig> onConfigChanged;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const HomePage({
    super.key,
    required this.currentConfig,
    required this.onConfigChanged,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldMessengerState> _messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final ScrollController _scrollController = ScrollController();
  int _counter = 0;
  double _downloadProgress = 0.0;
  int _currentPage = 1;
  bool _isDownloading = false;
  bool _isSaving = false;
  bool _showDraggable = false;
  double _appBarOpacity = 0.0;
  String? _selectedDropdownValue;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _showThemeSettings() {
    NZThemeConfig tempConfig = widget.currentConfig;
    NZDialog.show(
      context,
      title: '主题配置',
      message: '自定义 NezhaUI 的外观和感觉',
      content: StatefulBuilder(
        builder: (context, setDialogState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('主色调 (Primary Color)'),
                trailing: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: tempConfig.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                onTap: () {
                  final colors = [
                    NZColor.nezhaPrimary,
                    Colors.blue,
                    Colors.purple,
                    Colors.orange,
                    Colors.teal,
                  ];
                  final currentIndex = colors.indexOf(tempConfig.primaryColor);
                  final nextColor = colors[(currentIndex + 1) % colors.length];
                  setDialogState(() {
                    tempConfig = NZThemeConfig(
                      primaryColor: nextColor,
                      borderRadius: tempConfig.borderRadius,
                    );
                  });
                },
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('圆角半径: ${tempConfig.borderRadius.toInt()}px'),
                    Slider(
                      value: tempConfig.borderRadius,
                      min: 0,
                      max: 30,
                      onChanged: (val) {
                        setDialogState(() {
                          tempConfig = NZThemeConfig(
                            primaryColor: tempConfig.primaryColor,
                            borderRadius: val,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      actions: [
        NZDialogAction(
          label: '重置',
          onPressed: () {
            widget.onConfigChanged(NZThemeConfig.defaultContent);
            Navigator.pop(context);
          },
        ),
        NZDialogAction(
          label: '应用配置',
          isPrimary: true,
          onPressed: () {
            widget.onConfigChanged(tempConfig);
            Navigator.pop(context);
            _showMsg('主题配置已更新');
          },
        ),
      ],
    );
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final opacity = (offset / 100).clamp(0.0, 1.0);
    if (opacity != _appBarOpacity) {
      setState(() => _appBarOpacity = opacity);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    _showMsg('正在刷新数据...');
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _counter = 0;
    });
    _showMsg('数据已重置');
  }

  void _showMsg(String message) {
    NZToast.show(context, message: message);
  }

  Widget _buildThemeModeButton() {
    IconData icon;
    String label;
    switch (widget.themeMode) {
      case ThemeMode.system:
        icon = Icons.brightness_auto_rounded;
        label = '自动';
        break;
      case ThemeMode.light:
        icon = Icons.light_mode_rounded;
        label = '浅色';
        break;
      case ThemeMode.dark:
        icon = Icons.dark_mode_rounded;
        label = '深色';
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: PopupMenuButton<ThemeMode>(
        initialValue: widget.themeMode,
        icon: Icon(icon, color: Colors.white),
        tooltip: '切换外观: $label',
        onSelected: widget.onThemeModeChanged,
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: ThemeMode.system,
            child: Row(
              children: [
                Icon(Icons.brightness_auto_rounded, size: 20),
                SizedBox(width: 12),
                Text('跟随系统'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: ThemeMode.light,
            child: Row(
              children: [
                Icon(Icons.light_mode_rounded, size: 20),
                SizedBox(width: 12),
                Text('浅色模式'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: ThemeMode.dark,
            child: Row(
              children: [
                Icon(Icons.dark_mode_rounded, size: 20),
                SizedBox(width: 12),
                Text('深色模式'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPopUp() {
    NZPopUp.confirm(
      context,
      title: '确认提交',
      content: '提交后将无法修改，是否确认继续？',
      onConfirm: () => _showMsg('已确认提交'),
    );
  }

  void _showDestructivePopUp() {
    NZPopUp.confirm(
      context,
      title: '删除提示',
      content: '确定要删除这条重要数据吗？此操作不可撤销。',
      confirmLabel: '删除',
      isDestructive: true,
      onConfirm: () => _showMsg('数据已删除'),
    );
  }

  void _showMultiActionPopUp() {
    NZPopUp.show(
      context,
      title: '请选择操作',
      actionsAxis: Axis.vertical,
      actions: [
        NZPopUpAction(label: '分享到微信', onPressed: () => Navigator.pop(context)),
        NZPopUpAction(label: '保存到相册', onPressed: () => Navigator.pop(context)),
        NZPopUpAction(
          label: '取消',
          onPressed: () => Navigator.pop(context),
          color: Colors.grey,
        ),
      ],
    );
  }

  void _showNZDialog() {
    NZDialog.confirm(context, '这是一个全新的 NZDialog，感觉怎么样？');
  }

  void _showInputDialog() async {
    final name = await NZDialog.input(
      context,
      title: '你的名字',
      hintText: '请输入...',
    );
    if (name != null && name.isNotEmpty) {
      _showMsg('你好，$name！');
    }
  }

  void _showImageDialog() {
    NZDialog.image(
      context,
      'https://picsum.photos/seed/nz_dialog/800/400',
      title: '精选活动',
      message: '参与活动赢取精美礼品，快来参加吧！',
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _simulateSave() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isSaving = false);
    _incrementCounter();
  }

  void _simulateDownload() async {
    if (_isDownloading) return;
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      if (!mounted) return;
      setState(() {
        _downloadProgress = i / 100.0;
      });
    }

    setState(() {
      _isDownloading = false;
    });
  }

  void _showCode(String title, String code) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF24292E),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF959DA5)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: NZCodeView(code: code, theme: NZCodeTheme.githubLight),
            ),
            const SizedBox(height: 16),
            NZButton.primary(
              label: '复制示例代码',
              block: true,
              onPressed: () {
                Navigator.pop(context);
                _showMsg('代码已复制到剪贴板');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content, {String? code}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF24292E);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : Colors.black).withValues(
              alpha: isDark ? 0.2 : 0.03,
            ),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 16,
                      decoration: BoxDecoration(
                        color: NZColor.nezhaPrimary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                if (code != null)
                  IconButton(
                    icon: const Icon(
                      Icons.code_rounded,
                      size: 20,
                      color: NZColor.nezhaPrimary,
                    ),
                    onPressed: () => _showCode(title, code),
                    visualDensity: VisualDensity.compact,
                    tooltip: '查看代码',
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: content,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return ScaffoldMessenger(
      key: _messengerKey,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: isDark
                ? const Color(0xFF000000)
                : const Color(0xFFF7F8FA),
            body: NZPullToRefresh(
              backgroundColor: Colors.transparent,
              refreshDelay: const Duration(milliseconds: 1000),
              onRefresh: _handleRefresh,
              showSpinner: false,
              label: '下拉重置数据',
              readyLabel: '松开立即重置',
              refreshingLabel: '正在努力加载...',
              successLabel: '重置成功啦',
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 220,
                    pinned: true,
                    stretch: true,
                    backgroundColor: isDark
                        ? const Color(0xFF1C1C1E)
                        : Colors.white,
                    surfaceTintColor: isDark
                        ? const Color(0xFF1C1C1E)
                        : Colors.white,
                    elevation: 0,
                    actions: [_buildThemeModeButton()],
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [
                        StretchMode.zoomBackground,
                        StretchMode.blurBackground,
                        StretchMode.fadeTitle,
                      ],
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              NZColor.nezhaPrimary,
                              NZColor.nezhaPrimary.withValues(alpha: 0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -50,
                              top: -50,
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      'V1.0.0 STABLE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'NezhaUI',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const Text(
                                    '更轻量、更优雅、更专业的移动端组件库',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      centerTitle: true,
                      title: Opacity(
                        opacity: _appBarOpacity,
                        child: Text(
                          'NezhaUI 设计规范',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _buildSection(
                          'K线盘面 (NZKPan)',
                          Column(
                            children: [
                              const _SectionTitle('实心蜡烛 (Solid) + 国际配色'),
                              NZKPan(
                                symbol: 'BTC/USDT',
                                style: KLineStyle.solid,
                                isChinaStyle: false,
                                height: 320,
                                indicators: const {
                                  KLineIndicator.ma,
                                  KLineIndicator.vol,
                                },
                                data: _generateMockKData(100),
                              ),
                              const SizedBox(height: 24),
                              const _SectionTitle('空心蜡烛 (Hollow) + 中国配色'),
                              NZKPan(
                                symbol: 'XIAOMI',
                                style: KLineStyle.hollow,
                                isChinaStyle: true,
                                height: 320,
                                indicators: const {
                                  KLineIndicator.ema,
                                  KLineIndicator.vol,
                                },
                                data: _generateMockKData(100),
                              ),
                            ],
                          ),
                          code: '''// 基础用法
NZKPan(
  symbol: 'BTC/USDT',
  data: klineDataList,
)

// 高级配置
NZKPan(
  symbol: 'ETH/USDT',
  style: KLineStyle.hollow,
  isChinaStyle: false, // 国际配色：绿涨红跌
  indicators: {
    KLineIndicator.ma,
    KLineIndicator.vol,
  },
  height: 450,
  data: klineDataList,
)''',
                        ),
                        _buildSection(
                          '基础按钮 (NZButton)',
                          Wrap(
                            spacing: 12,
                            runSpacing: 16,
                            children: [
                              NZButton.primary(
                                label: '主要操作',
                                onPressed: () => _showMsg('点击了主要操作'),
                              ),
                              NZButton.secondary(
                                label: '次要操作',
                                onPressed: () => _showMsg('点击了次要操作'),
                              ),
                              NZButton.outline(
                                label: '描边按钮',
                                onPressed: () => _showMsg('点击了描边按钮'),
                              ),
                              NZButton.text(
                                label: '文字按钮',
                                onPressed: () => _showMsg('点击了文字按钮'),
                              ),
                            ],
                          ),
                          code: '''NZButton.primary(
  label: '主要操作',
  onPressed: () => _showMsg('点击了主要操作'),
),
NZButton.secondary(
  label: '次要操作',
  onPressed: () => _showMsg('点击了次要操作'),
),
NZButton.outline(
  label: '描边按钮',
  onPressed: () => _showMsg('点击了描边按钮'),
),
NZButton.text(
  label: '文字按钮',
  onPressed: () => _showMsg('点击了文字按钮'),
)''',
                        ),
                        _buildSection(
                          '按钮状态',
                          Column(
                            children: [
                              NZButton.primary(
                                label: _isSaving ? '正在努力保存...' : '点击触发加载状态',
                                block: true,
                                isLoading: _isSaving,
                                onPressed: _simulateSave,
                              ),
                              const SizedBox(height: 12),
                              NZButton.primary(
                                label: '禁用状态演示',
                                block: true,
                                onPressed: null,
                              ),
                            ],
                          ),
                          code: '''NZButton.primary(
  label: _isSaving ? '正在保存...' : '加载状态',
  block: true,
  isLoading: _isSaving,
  onPressed: _simulateSave,
),
NZButton.primary(
  label: '禁用状态',
  block: true,
  onPressed: null,
)''',
                        ),
                        _buildSection(
                          '进度按钮 (NZProgressButton)',
                          NZProgressButton(
                            progress: _downloadProgress,
                            block: true,
                            color: NZColor.nezhaIndigo,
                            label: _isDownloading
                                ? '下载中... ${(_downloadProgress * 100).toInt()}%'
                                : '开始背景进度下载',
                            onPressed: _simulateDownload,
                          ),
                          code: '''NZProgressButton(
  progress: _downloadProgress,
  block: true,
  color: NZColor.nezhaIndigo,
  label: _isDownloading ? '下载中...' : '开始下载',
  onPressed: _simulateDownload,
)''',
                        ),
                        _buildSection(
                          '图片按钮 (NZImageButton)',
                          NZImageButton(
                            image: const NetworkImage(
                              'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=2564&auto=format&fit=crop',
                            ),
                            label: '探索视觉艺术',
                            block: true,
                            borderRadius: 20,
                            onPressed: () => _showMsg('开启艺术之旅'),
                          ),
                          code: '''NZImageButton(
  image: NetworkImage('...'),
  label: '探索视觉艺术',
  block: true,
  borderRadius: 20,
  onPressed: () => _showMsg('开启艺术之旅'),
)''',
                        ),
                        _buildSection(
                          '分割线 (NZDivider)',
                          const Column(
                            children: [
                              Text(
                                '上方内容',
                                style: TextStyle(color: Colors.black38),
                              ),
                              NZDivider(height: 40, thickness: 1),
                              Text(
                                '下方内容',
                                style: TextStyle(color: Colors.black38),
                              ),
                            ],
                          ),
                          code: '''NZDivider(height: 40, thickness: 1)''',
                        ),
                        _buildSection(
                          '交互计数器',
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '当前计数值: $_counter',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              NZButton.primary(
                                label: '点我计数',
                                width: 100,
                                height: 40,
                                borderRadius: 20,
                                onPressed: _incrementCounter,
                              ),
                            ],
                          ),
                          code: '''NZButton.primary(
  label: '计数',
  onPressed: _incrementCounter,
)''',
                        ),
                        _buildSection(
                          '代码查看器 (NZCodeView)',
                          const Column(
                            children: [
                              NZCodeView(
                                code: '''// C++ 示例代码，展示 NZCodeView 对 C++ 语法高亮的支持
#include <iostream>

int main() {
    std::cout << "Hello NezhaUI from C++" << std::endl;
    return 0;
}''',
                                theme: NZCodeTheme.githubLight,
                              ),
                              SizedBox(height: 12),

                              NZCodeView(
                                code:
                                    '''// Golang 示例代码，展示 NZCodeView 对 Golang 语法高亮的支持
package main

import "fmt"

func main() {
    fmt.Println("Hello NezhaUI from Golang")
}''',
                                theme: NZCodeTheme.githubDark,
                              ),
                            ],
                          ),
                          code: '''NZCodeView(
  code: '...',
  theme: NZCodeTheme.githubLight,
)''',
                        ),
                        _buildSection(
                          'Floating Action Button 悬浮按钮',
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              NZFloatingActionButton.standard(
                                onPressed: () {},
                                icon: const Icon(Icons.add_rounded),
                                label: '添加',
                              ),
                              NZFloatingActionButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.edit_rounded),
                              ),
                              NZFloatingActionButton.image(
                                onPressed: () {},
                                image: const NetworkImage(
                                  'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=120&h=120&auto=format&fit=crop',
                                ),
                                icon: const Icon(Icons.auto_awesome_rounded),
                              ),
                            ],
                          ),
                          code: '''NZFloatingActionButton.standard(
  onPressed: () {},
  icon: Icon(Icons.add),
  label: '添加',
)''',
                        ),
                        _buildSection(
                          '轻提示 (NZToast)',
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              NZButton.primary(
                                label: '成功提示',
                                onPressed: () =>
                                    NZToast.success(context, '保存成功啦'),
                              ),
                              NZButton.primary(
                                label: '错误提示',
                                color: Colors.redAccent,
                                onPressed: () =>
                                    NZToast.error(context, '网络连接超时'),
                              ),
                              NZButton.primary(
                                label: '加载中',
                                color: Colors.blueAccent,
                                onPressed: () {
                                  NZToast.loading(context, '正在努力中...');
                                  Future.delayed(
                                    const Duration(seconds: 2),
                                    () {
                                      NZToast.hide();
                                      if (!context.mounted) return;
                                      NZToast.success(context, '加载完成');
                                    },
                                  );
                                },
                              ),
                              NZButton.primary(
                                label: '普通提示',
                                color: Colors.grey,
                                onPressed: () =>
                                    NZToast.show(context, message: '这是一条普通消息'),
                              ),
                            ],
                          ),
                          code: '''// 成功提示
NZToast.success(context, '保存成功啦');

// 错误提示
NZToast.error(context, '网络连接超时');

// 加载中并自动隐藏
NZToast.loading(context, '正在努力中...');
Future.delayed(Duration(seconds: 2), () => NZToast.hide());''',
                        ),
                        _buildSection(
                          '悬浮拖拽按钮 (NZDraggableButton)',
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('快看屏幕右下角！那个小球可以随意拖动，松手会自动贴边哦。'),
                              const SizedBox(height: 12),
                              NZButton.primary(
                                label: _showDraggable ? '隐藏全局悬浮球' : '显示全局悬浮球',
                                color: _showDraggable
                                    ? Colors.redAccent
                                    : NZColor.nezhaPrimary,
                                block: true,
                                onPressed: () {
                                  setState(
                                    () => _showDraggable = !_showDraggable,
                                  );
                                  _showMsg(
                                    _showDraggable ? '悬浮球已现身' : '悬浮球已隐身',
                                  );
                                },
                              ),
                              const SizedBox(height: 8),
                              NZText.caption('提示：DraggableButton 适合放客服、全局菜单等。'),
                            ],
                          ),
                          code: '''NZDraggableButton(
  initialPosition: Offset(300, 600),
  onTap: () => NZToast.show(context, message: '点击了悬浮球'),
  child: Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      color: NZColor.nezhaPrimary,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Icon(Icons.support_agent_rounded, color: Colors.white),
  ),
)''',
                        ),
                        _buildSection(
                          'Navigation Bar 导航栏',
                          Column(
                            children: [
                              const Text(
                                '普通模式',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              NZNavBar(
                                title: '标题',
                                leading: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                  ),
                                  onPressed: () {},
                                ),
                                actions: [
                                  IconButton(
                                    icon: const Icon(Icons.more_horiz_rounded),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                '搜索模式',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              NZNavBar.search(
                                title: '搜索组件',
                                onSearch: () {},
                                onSearchChanged: (val) =>
                                    debugPrint('Searching: $val'),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Logo 模式',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              NZNavBar.logo(
                                logoUrl:
                                    'https://images.unsplash.com/photo-1614850523296-d8c1af93d400?q=80&w=100&h=100&auto=format&fit=crop',
                                actions: [
                                  IconButton(
                                    icon: const Icon(Icons.palette_rounded),
                                    tooltip: '主题配置',
                                    onPressed: _showThemeSettings,
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.notifications_none_rounded,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                '小程序模式',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              NZNavBar.miniApp(
                                title: '小程序风格',
                                onMiniAppShare: () => _showMsg('分享'),
                                onMiniAppClose: () => _showMsg('关闭'),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                '自定义颜色模式',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const NZNavBar(
                                title: '自定义配色',
                                backgroundColor: NZColor.nezhaPrimary,
                                foregroundColor: Colors.white,
                                elevation: 4,
                              ),
                            ],
                          ),
                          code: '''// 普通模式
NZNavBar(
  title: '标题',
  leading: IconButton(icon: Icon(Icons.arrow_back)),
)

// 搜索模式
NZNavBar.search(
  title: '搜索',
  onSearch: () {},
)

// 小程序模式
NZNavBar.miniApp(
  title: '小程序',
  onMiniAppShare: () {},
)

// 自定义样式
NZNavBar(
  title: '自定义',
  backgroundColor: NZColor.nezhaPrimary,
  foregroundColor: Colors.white,
)''',
                        ),
                        _buildSection(
                          '日历 (NZCalendar)',
                          Column(
                            children: [
                              const NZCalendar(
                                style: NZCalendarStyle.card,
                                showLunar: true,
                              ),
                              const SizedBox(height: 16),
                              NZCalendar(
                                style: NZCalendarStyle.compact,
                                usePrompt: true,
                                onOptionSelected: (date, option) {
                                  NZToast.show(
                                    context,
                                    message:
                                        '${date.year}-${date.month}-${date.day} 选择: $option',
                                  );
                                },
                              ),
                            ],
                          ),
                          code: '''// 卡片样式 + 农历
NZCalendar(
  style: NZCalendarStyle.card,
  showLunar: true,
)

// 紧凑样式 + 选项弹窗
NZCalendar(
  style: NZCalendarStyle.compact,
  usePrompt: true,
  onOptionSelected: (date, option) {
    print('选择: \$option');
  },
)''',
                        ),
                        _buildSection(
                          'Swipe Action 滑动操作',
                          Column(
                            children: [
                              NZSwipeListTile(
                                rightActions: [
                                  NZSwipeAction(
                                    label: '编辑',
                                    icon: const Icon(Icons.edit_rounded),
                                    onTap: () => _showMsg('点击了编辑'),
                                  ),
                                  NZSwipeAction(
                                    label: '删除',
                                    backgroundColor: Colors.red,
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                    ),
                                    onTap: () => _showMsg('点击了删除'),
                                  ),
                                ],
                                child: const ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: NZColor.red100,
                                    child: Icon(
                                      Icons.person_rounded,
                                      color: NZColor.red500,
                                    ),
                                  ),
                                  title: Text('左滑试试看'),
                                  subtitle: Text('支持多个操作按钮'),
                                ),
                              ),
                              const Divider(height: 1, indent: 16),
                              NZSwipeListTile(
                                leftActions: [
                                  NZSwipeAction(
                                    label: '收藏',
                                    backgroundColor: Colors.orange,
                                    icon: const Icon(Icons.star_rounded),
                                    onTap: () => _showMsg('点击了收藏'),
                                  ),
                                ],
                                child: const ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: NZColor.orange100,
                                    child: Icon(
                                      Icons.star_outline_rounded,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  title: Text('右滑试试看'),
                                  subtitle: Text('支持左侧滑出按钮'),
                                ),
                              ),
                              const Divider(height: 1, indent: 16),
                              NZSwipeListTile(
                                topActions: [
                                  NZSwipeAction(
                                    label: '置顶',
                                    backgroundColor: Colors.blue,
                                    icon: const Icon(
                                      Icons.vertical_align_top_rounded,
                                    ),
                                    onTap: () => _showMsg('点击了置顶'),
                                  ),
                                ],
                                child: const ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Color(0xFFE3F2FD),
                                    child: Icon(
                                      Icons.info_outline_rounded,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  title: Text('上下滑动 (实验性)'),
                                  subtitle: Text('支持 4 个方向的滑动操作'),
                                ),
                              ),
                            ],
                          ),
                          code: '''NZSwipeListTile(
  rightActions: [
    NZSwipeAction(
      label: '删除',
      backgroundColor: Colors.red,
      icon: Icon(Icons.delete),
      onTap: () => print('delete'),
    ),
  ],
  child: ListTile(title: Text('滑动我')),
)''',
                        ),
                        _buildSection(
                          'NoticeBar 公告栏',
                          Column(
                            children: [
                              const NZNoticeBar(
                                text: ['提示：这是一条标准的水平滚动公告，用于展示重要的通知信息。'],
                                icon: Icon(Icons.campaign_rounded),
                                suffix: Icon(Icons.chevron_right_rounded),
                              ),
                              const SizedBox(height: 12),
                              const NZNoticeBar(
                                theme: NZNoticeBarTheme.finance,
                                text: ['[行情] 沪深300指数今日上涨 1.25%，科技板块领涨市场。'],
                                icon: Icon(Icons.trending_up_rounded),
                                speed: 60,
                              ),
                              const SizedBox(height: 12),
                              const NZNoticeBar(
                                theme: NZNoticeBarTheme.success,
                                direction: NZNoticeBarDirection.vertical,
                                text: [
                                  '恭喜！您的账户已成功通过实名认证。',
                                  '系统消息：新功能“智能选股”已上线。',
                                  '提醒：请及时领取您的周度交易报告。',
                                ],
                                icon: Icon(Icons.check_circle_outline_rounded),
                              ),
                              const SizedBox(height: 12),
                              NZNoticeBar(
                                theme: NZNoticeBarTheme.error,
                                text: ['警告：检测到您的账户存在异地登录风险，请立即检查。'],
                                icon: const Icon(Icons.error_outline_rounded),
                                suffix: const Icon(Icons.close_rounded),
                                onSuffixTap: () => _showMsg('关闭公告'),
                              ),
                            ],
                          ),
                          code: '''NZNoticeBar(
  theme: NZNoticeBarTheme.finance,
  text: ['沪深300指数今日上涨 1.25%'],
  icon: Icon(Icons.trending_up),
)''',
                        ),
                        _buildSection(
                          'PopUp 弹窗',
                          Column(
                            children: [
                              NZButton.primary(
                                label: '显示确认弹窗',
                                block: true,
                                onPressed: _showPopUp,
                              ),
                              const SizedBox(height: 12),
                              NZButton.secondary(
                                label: '显示危险操作弹窗',
                                block: true,
                                onPressed: _showDestructivePopUp,
                              ),
                              const SizedBox(height: 12),
                              NZButton.outline(
                                label: '显示多按钮弹窗',
                                block: true,
                                onPressed: _showMultiActionPopUp,
                              ),
                            ],
                          ),
                          code: '''NZPopUp.confirm(
  context,
  title: '确认提交',
  content: '提交后将无法修改，是否确认继续？',
  onConfirm: () => print('已确认'),
);''',
                        ),
                        _buildSection(
                          'Dialog 对话框 (NZDialog)',
                          Column(
                            children: [
                              NZButton.primary(
                                label: '显示基础对话框',
                                block: true,
                                onPressed: _showNZDialog,
                              ),
                              const SizedBox(height: 12),
                              NZButton.secondary(
                                label: '显示输入对话框',
                                block: true,
                                onPressed: _showInputDialog,
                              ),
                              const SizedBox(height: 12),
                              NZButton.outline(
                                label: '显示图片视觉对话框',
                                block: true,
                                onPressed: _showImageDialog,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: NZButton.outline(
                                      label: '成功提示',
                                      onPressed: () =>
                                          NZDialog.success(context, '操作成功完成'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: NZButton.outline(
                                      label: '错误反馈',
                                      onPressed: () =>
                                          NZDialog.error(context, '抱歉，系统出现异常'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: NZButton.outline(
                                      label: '警告提示',
                                      onPressed: () =>
                                          NZDialog.warning(context, '该操作无法撤销'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: NZButton.outline(
                                      label: '详情信息',
                                      onPressed: () =>
                                          NZDialog.info(context, '这是该条目的详细说明'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              NZButton.outline(
                                label: '状态展示',
                                block: true,
                                onPressed: () => NZDialog.status(
                                  context,
                                  title: '系统状态',
                                  message: '所有服务运行正常',
                                  statusWidget: const Center(
                                    child: Icon(
                                      Icons.cloud_done_rounded,
                                      size: 64,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: NZButton.outline(
                                      label: '进度展示',
                                      onPressed: () =>
                                          NZDialog.progress(context, 0.65),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: NZButton.outline(
                                      label: '加载状态',
                                      onPressed: () {
                                        NZDialog.loading(
                                          context,
                                          message: '正在努力同步中...',
                                        );
                                        Future.delayed(
                                          const Duration(seconds: 2),
                                          () {
                                            if (mounted) {
                                              // ignore: use_build_context_synchronously
                                              Navigator.pop(context);
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              NZButton.outline(
                                label: '多按钮排列',
                                block: true,
                                onPressed: () {
                                  NZDialog.show(
                                    context,
                                    title: '选择操作',
                                    message: '请选择你想要执行的后续动作',
                                    actions: [
                                      NZDialogAction(
                                        label: '置顶',
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      NZDialogAction(
                                        label: '加星',
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      NZDialogAction(
                                        label: '删除',
                                        isDestructive: true,
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      NZDialogAction(
                                        label: '取消',
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                          code: '''// 1. 成功提示
NZDialog.success(context, '操作成功');

// 2. 确认操作
bool? ok = await NZDialog.confirm(context, '确认提交？');

// 3. 输入内容
String? val = await NZDialog.input(context, title: '反馈');

// 4. 多按钮模式
NZDialog.show(
  context,
  actions: [
    NZDialogAction(label: '选项一'),
    NZDialogAction(label: '选项二'),
    NZDialogAction(label: '删除', isDestructive: true),
  ],
);''',
                        ),
                        _buildSection(
                          '标签 (NZTag)',
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '不同尺寸',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  NZTag(label: 'Small', size: NZTagSize.small),
                                  NZTag(
                                    label: 'Medium',
                                    size: NZTagSize.medium,
                                  ),
                                  NZTag(label: 'Large', size: NZTagSize.large),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                '不同样式',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  const NZTag(
                                    label: 'Soft (Default)',
                                    style: NZTagStyle.soft,
                                  ),
                                  const NZTag(
                                    label: 'Outline',
                                    style: NZTagStyle.outline,
                                  ),
                                  const NZTag(
                                    label: 'Filled',
                                    style: NZTagStyle.filled,
                                  ),
                                  NZTag(
                                    label: 'Round',
                                    round: true,
                                    color: Colors.purple[400],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                '功能与语义',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  NZTag(
                                    label: '带图标',
                                    leading: const Icon(
                                      Icons.local_offer_rounded,
                                    ),
                                    onTap: () => _showMsg('点击了标签'),
                                  ),
                                  NZTag(
                                    label: '可删除',
                                    color: Colors.blue,
                                    onDeleted: () => _showMsg('删除了标签'),
                                  ),
                                  NZTag.success('成功状态'),
                                  NZTag.warning('警告状态'),
                                  NZTag.error('错误状态'),
                                ],
                              ),
                            ],
                          ),
                          code: '''// 成功状态
NZTag.success('已完成')

// 带删除按钮
NZTag(
  label: '可删除',
  onDeleted: () => print('deleted'),
)''',
                        ),
                        _buildSection(
                          '步骤条 (NZSteps)',
                          const Column(
                            children: [
                              NZSteps(
                                current: 1,
                                steps: [
                                  NZStep(title: '第一步', description: '填写基本信息'),
                                  NZStep(title: '第二步', description: '上传身份证明'),
                                  NZStep(title: '第三步', description: '审核通过'),
                                ],
                              ),
                              SizedBox(height: 32),
                              NZSteps(
                                direction: Axis.vertical,
                                current: 0,
                                steps: [
                                  NZStep(
                                    title: '订单提交',
                                    description: '2024-03-20 10:00',
                                  ),
                                  NZStep(
                                    title: '仓库打包',
                                    description: '预计 1 小时内完成',
                                  ),
                                  NZStep(title: '等待揽收'),
                                ],
                              ),
                            ],
                          ),
                          code: '''// 水平步骤条
NZSteps(
  current: 1,
  steps: [
    NZStep(title: '步骤1'),
    NZStep(title: '步骤2'),
  ],
)

// 垂直步骤条
NZSteps(
  direction: Axis.vertical,
  current: 0,
  steps: [
    NZStep(title: '已完成'),
    NZStep(title: '进行中'),
  ],
)''',
                        ),
                        _buildSection(
                          '分页器 (NZPagination)',
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSubSectionTitle('基础与形状'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: NZPagination(
                                      total: 50,
                                      current: _currentPage,
                                      onPageChanged: (p) =>
                                          setState(() => _currentPage = p),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: NZPagination(
                                      total: 50,
                                      current: _currentPage,
                                      shape: NZPaginationShape.circle,
                                      onPageChanged: (p) =>
                                          setState(() => _currentPage = p),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              _buildSubSectionTitle('样式变体 (描边 & 浅色)'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: NZPagination(
                                      total: 100,
                                      current: _currentPage,
                                      type: NZPaginationType.outline,
                                      showFirstLast: true,
                                      onPageChanged: (p) =>
                                          setState(() => _currentPage = p),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: NZPagination(
                                      total: 100,
                                      current: _currentPage,
                                      type: NZPaginationType.light,
                                      shape: NZPaginationShape.circle,
                                      onPageChanged: (p) =>
                                          setState(() => _currentPage = p),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              _buildSubSectionTitle('快速跳转 & 禁用状态'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: NZPagination(
                                      total: 200,
                                      current: _currentPage,
                                      showQuickJumper: true,
                                      onPageChanged: (p) =>
                                          setState(() => _currentPage = p),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: NZPagination(
                                      total: 50,
                                      current: 2,
                                      disabled: true,
                                      onPageChanged: (p) {},
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              _buildSubSectionTitle('移动端自动滚动模式'),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white.withValues(alpha: 0.05)
                                      : Colors.black.withValues(alpha: 0.02),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).dividerColor.withValues(alpha: 0.05),
                                  ),
                                ),
                                child: NZPagination(
                                  total: 500,
                                  current: _currentPage,
                                  scrollable: true,
                                  onPageChanged: (p) =>
                                      setState(() => _currentPage = p),
                                ),
                              ),
                            ],
                          ),
                          code: '''// 基础用法
NZPagination(
  total: 50,
  current: 1,
  onPageChanged: (page) => print(page),
)

// 开启滚动模式（适配移动端多页码）
NZPagination(
  total: 500,
  scrollable: true,
)''',
                        ),
                        _buildSection(
                          '瀑布流 (NZMasonry)',
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('智能分配列布局，支持交错入场动画，完美适配各类内容展示。'),
                              const SizedBox(height: 16),
                              NZMasonry.builder(
                                itemCount: 5,
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                animate: true,
                                itemBuilder: (context, index) {
                                  final List<Color> colors = [
                                    Colors.blue,
                                    Colors.purple,
                                    Colors.orange,
                                    Colors.green,
                                    Colors.pink,
                                  ];
                                  final color = colors[index % colors.length];

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: color.withValues(alpha: 0.1),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: color.withValues(alpha: 0.1),
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AspectRatio(
                                          aspectRatio: index % 2 == 0
                                              ? 16 / 9
                                              : 4 / 5,
                                          child: Container(
                                            width: double.infinity,
                                            color: color.withValues(
                                              alpha: 0.08,
                                            ),
                                            child: Icon(
                                              Icons.auto_awesome_mosaic_rounded,
                                              color: color.withValues(
                                                alpha: 0.5,
                                              ),
                                              size: 32,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '精选卡片 #$index',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '这里是 NezhaUI 瀑布流组件的内容展示，宽高已设为自适应。',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          code: '''// 推荐用法：Builder 模式 + 宽高自适应
NZMasonry.builder(
  itemCount: 5,
  crossAxisCount: 2,
  mainAxisSpacing: 12,
  crossAxisSpacing: 12,
  animate: true,
  itemBuilder: (context, index) {
    return MyFlexibleCard(index: index);
  },
)''',
                        ),
                        _buildSection(
                          'K线盘面 (NZKPan)',
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '专业级金融 K 线组件，支持红涨绿跌 (中国市场)、空心/实心蜡烛样式以及 MA 均线。',
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                '专业级交互图表 (支持长按显示十字光标):',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              NZKPan(
                                symbol: 'XIAOMI',
                                style: KLineStyle.hollow,
                                height: 450,
                                indicators: const {
                                  KLineIndicator.ma,
                                  KLineIndicator.vol,
                                },
                                data: () {
                                  final List<KLineData> result = [];
                                  double lastClose = 150.0;
                                  final random = Random();
                                  for (int i = 0; i < 500; i++) {
                                    final double open = lastClose;
                                    // 模拟带有随机游走和轻微趋势的市场
                                    final double change =
                                        (random.nextDouble() - 0.48) * 4.0;
                                    final double close = open + change;
                                    final double high =
                                        max(open, close) +
                                        random.nextDouble() * 2.0;
                                    final double low =
                                        min(open, close) -
                                        random.nextDouble() * 2.0;
                                    final double vol =
                                        10000 + random.nextDouble() * 20000;

                                    result.add(
                                      KLineData(
                                        time: DateTime.now().subtract(
                                          Duration(minutes: 500 - i),
                                        ),
                                        open: open,
                                        high: high,
                                        low: low,
                                        close: close,
                                        volume: vol,
                                      ),
                                    );
                                    lastClose = close;
                                  }
                                  return result;
                                }(),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                '不同样式演示 (实心 & 国际配色):',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              NZKPan(
                                symbol: 'XIAOMI',
                                isChinaStyle: false, // 国际配色：绿涨红跌
                                style: KLineStyle.solid,
                                height: 300,
                                indicators: const {KLineIndicator.vol},
                                data: () {
                                  final List<KLineData> result = [];
                                  double lastClose = 68000.0;
                                  final random = Random();
                                  for (int i = 0; i < 300; i++) {
                                    final double open = lastClose;
                                    // 模拟高波动的加密货币市场
                                    final double change =
                                        (random.nextDouble() - 0.5) * 500.0;
                                    final double close = open + change;
                                    final double high =
                                        max(open, close) +
                                        random.nextDouble() * 200.0;
                                    final double low =
                                        min(open, close) -
                                        random.nextDouble() * 200.0;
                                    final double vol =
                                        500 + random.nextDouble() * 1500;

                                    result.add(
                                      KLineData(
                                        time: DateTime.now().subtract(
                                          Duration(minutes: 300 - i),
                                        ),
                                        open: open,
                                        high: high,
                                        low: low,
                                        close: close,
                                        volume: vol,
                                      ),
                                    );
                                    lastClose = close;
                                  }
                                  return result;
                                }(),
                              ),
                            ],
                          ),
                          code: '''NZKPan(
  style: KLineStyle.hollow, // 专业空心样式
  isChinaStyle: true,      // 红涨绿跌
  indicators: {KLineIndicator.ma, KLineIndicator.vol},
  data: klineDataList,
)''',
                        ),
                        _buildSection(
                          'DropDownMenu 下拉菜单',
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '基础用法 (Medium Outline)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              NZDropDownMenu<String>(
                                value: _selectedDropdownValue,
                                hint: '点击展开菜单',
                                isExpanded: true,
                                items: const [
                                  NZDropDownMenuItem(
                                    value: 'option1',
                                    label: '查看个人资料',
                                    icon: Icons.person_outline_rounded,
                                  ),
                                  NZDropDownMenuItem(
                                    value: 'option2',
                                    label: '修改密码',
                                    icon: Icons.lock_outline_rounded,
                                  ),
                                  NZDropDownMenuItem(
                                    value: 'option3',
                                    label: '退出登录',
                                    icon: Icons.logout_rounded,
                                  ),
                                ],
                                onChanged: (val) {
                                  setState(() => _selectedDropdownValue = val);
                                  _showMsg('选择了: $val');
                                },
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                '填充样式 (Small Filled)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              NZDropDownMenu<String>(
                                type: NZDropDownMenuType.filled,
                                size: NZDropDownMenuSize.small,
                                hint: '排序方式',
                                items: const [
                                  NZDropDownMenuItem(
                                    value: 'new',
                                    label: '最新优先',
                                  ),
                                  NZDropDownMenuItem(
                                    value: 'hot',
                                    label: '最热优先',
                                  ),
                                ],
                                onChanged: (val) => _showMsg('排序: $val'),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                '无边框样式 (Large)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              NZDropDownMenu<String>(
                                type: NZDropDownMenuType.borderless,
                                size: NZDropDownMenuSize.large,
                                hint: '选择分类',
                                items: const [
                                  NZDropDownMenuItem(
                                    value: 'tech',
                                    label: '科技资讯',
                                    icon: Icons.computer_rounded,
                                  ),
                                  NZDropDownMenuItem(
                                    value: 'life',
                                    label: '生活百态',
                                    icon: Icons.coffee_rounded,
                                  ),
                                ],
                                onChanged: (val) => _showMsg('分类: $val'),
                              ),
                            ],
                          ),
                          code: '''NZDropDownMenu<String>(
  type: NZDropDownMenuType.filled,
  size: NZDropDownMenuSize.small,
  hint: '排序方式',
  items: const [
    NZDropDownMenuItem(value: 'new', label: '最新优先'),
    NZDropDownMenuItem(value: 'hot', label: '最热优先'),
  ],
  onChanged: (val) => print(val),
)''',
                        ),
                        _buildSection(
                          'Tags 标签',
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  const NZTag(label: '默认样式'),
                                  NZTag(
                                    label: '填充样式',
                                    style: NZTagStyle.filled,
                                    color: NZColor.nezhaPrimary,
                                  ),
                                  const NZTag(
                                    label: '描边样式',
                                    style: NZTagStyle.outline,
                                  ),
                                  NZTag(
                                    label: '浅色填充',
                                    style: NZTagStyle.soft,
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  NZTag(
                                    label: '带图标',
                                    leading: const Icon(
                                      Icons.star_rounded,
                                      size: 14,
                                      color: Colors.amber,
                                    ),
                                    onTap: () => _showMsg('点击了带图标标签'),
                                  ),
                                  NZTag(
                                    label: '可删除',
                                    color: Colors.red,
                                    onDeleted: () => _showMsg('删除了标签'),
                                  ),
                                  const NZTag(label: '胶囊形', round: true),
                                ],
                              ),
                            ],
                          ),
                          code: '''NZTag(
  label: '可删除',
  color: Colors.red,
  onDeleted: () => print('deleted'),
)''',
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // FAB 展示
          Positioned(
            right: 20,
            bottom: 40,
            child: NZFloatingActionButton.standard(
              label: '发布',
              icon: const Icon(Icons.add_rounded),
              scrollController: _scrollController,
              onPressed: () => _showMsg('点击了发布'),
            ),
          ),
          _buildGlobalDraggableButton(),
        ],
      ),
    );
  }

  Widget _buildGlobalDraggableButton() {
    if (!_showDraggable) return const SizedBox.shrink();

    return NZDraggableButton(
      initialPosition: const Offset(300, 600),
      onTap: () => NZToast.show(context, message: '点击了悬浮球'),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: NZColor.nezhaPrimary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.support_agent_rounded, color: Colors.white),
      ),
    );
  }

  List<KLineData> _generateMockKData(int count) {
    final List<KLineData> result = [];
    double lastClose = 150.0;
    final random = Random();
    for (int i = 0; i < count; i++) {
      final double open = lastClose;
      final double change = (random.nextDouble() - 0.48) * 4.0;
      final double close = open + change;
      final double high = max(open, close) + random.nextDouble() * 2.0;
      final double low = min(open, close) - random.nextDouble() * 2.0;
      final double vol = 10000 + random.nextDouble() * 20000;
      result.add(
        KLineData(
          time: DateTime.now().subtract(Duration(minutes: count - i)),
          open: open,
          high: high,
          low: low,
          close: close,
          volume: vol,
        ),
      );
      lastClose = close;
    }
    return result;
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
