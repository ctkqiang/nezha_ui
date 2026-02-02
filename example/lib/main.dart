import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nezha_ui/nezha.dart';
import 'package:nezha_ui/components/code_view.dart';

void main() {
  runApp(const NezhaUIExample());
}

class NezhaUIExample extends StatelessWidget {
  const NezhaUIExample({super.key});

  @override
  Widget build(BuildContext context) {
    return NezhaApp(
      title: 'NezhaUI Example',
      theme: NZTheme.lightTheme,
      darkTheme: NZTheme.darkTheme,
      showPerformanceOverlay: kProfileMode,
      debugShowCheckedModeBanner: kDebugMode,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldMessengerState> _messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final ScrollController _scrollController = ScrollController();
  int _counter = 0;
  double _downloadProgress = 0.0;
  bool _isDownloading = false;
  bool _isSaving = false;
  double _appBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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
    _messengerKey.currentState?.clearSnackBars();
    _messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(20),
      ),
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

  Widget _buildSection(String title, Widget content, {String? code}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
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
    return ScaffoldMessenger(
      key: _messengerKey,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: const Color(0xFFF7F8FA),
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
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    elevation: 0,
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
                      title: Opacity(
                        opacity: _appBarOpacity,
                        child: const Text(
                          'NezhaUI 设计规范',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      centerTitle: true,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
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
                          '悬浮按钮 (NZFloatingActionButton)',
                          const Text(
                            '悬浮按钮支持标准、图标和图片三种模式，并且可以随滚动自动隐藏或支持自由拖拽。',
                            style: TextStyle(color: Colors.black54),
                          ),
                          code: '''// 标准悬浮按钮 (带文字)
NZFloatingActionButton.standard(
  label: '发布',
  icon: const Icon(Icons.add_rounded),
  scrollController: _scrollController,
  onPressed: () => _showMsg('点击了发布'),
),

// 图片悬浮按钮 (支持拖拽)
NZFloatingActionButton.image(
  initialPosition: const Offset(20, 350),
  draggable: true,
  image: NetworkImage('...'),
  icon: const Icon(Icons.auto_awesome_rounded),
  onPressed: () => _showMsg('触发了图片 FAB'),
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
          NZFloatingActionButton.image(
            initialPosition: const Offset(20, 350),
            draggable: true,
            image: const NetworkImage(
              'https://images.unsplash.com/photo-1550684848-fac1c5b4e853?q=80&w=2070&auto=format&fit=crop',
            ),
            icon: const Icon(Icons.palette_rounded, color: Colors.white),
            onPressed: () => _showMsg('进入创意调色盘'),
          ),
        ],
      ),
    );
  }
}
