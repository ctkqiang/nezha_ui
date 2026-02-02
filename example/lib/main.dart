import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nezha_ui/nezha.dart';

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
  int _counter = 0;
  double _downloadProgress = 0.0;
  bool _isDownloading = false;
  bool _isSaving = false;

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

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 18,
              decoration: BoxDecoration(
                color: NZColor.nezhaPrimary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        content,
        const NZDivider(height: 40),
      ],
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
            appBar: AppBar(
              title: const Text('NezhaUI 设计规范'),
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
            body: NZPullToRefresh(
              backgroundColor: NZColor.blueGrey50,
              refreshDelay: const Duration(milliseconds: 1500),
              showIcon: true,
              color: NZColor.blue400,
              onRefresh: _handleRefresh,
              showSpinner: false,
              label: '下拉即可刷新...',
              readyLabel: '释放即可刷新',
              refreshingLabel: '正在刷新中...',
              successLabel: '数据刷新成功啦~',
              successIcon: Icons.done_all_rounded,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2D5AF0), Color(0xFF5E81F4)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF2D5AF0,
                            ).withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NezhaUI',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            '更轻量、更优雅、更专业的\nFlutter 移动端组件库',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1.6,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Button Styles Section
                    _buildSection(
                      '下拉刷新示例 (NZPullToRefresh)',
                      const Text(
                        '你可以尝试下拉整个页面，我已经开启了 noSpinner 模式，并设置了自定义 Label 哦~',
                        style: TextStyle(color: Colors.black45, fontSize: 14),
                      ),
                    ),

                    // Button Styles Section
                    _buildSection(
                      '基础按钮样式 (NZButton)',
                      Column(
                        children: [
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
                          const SizedBox(height: 20),
                          NZButton.primary(
                            label: _isSaving ? '正在保存...' : '通栏加载按钮示例',
                            block: true,
                            isLoading: _isSaving,
                            onPressed: _simulateSave,
                          ),
                        ],
                      ),
                    ),

                    // Custom Colors Section
                    _buildSection(
                      '自定义色彩 (Custom Colors)',
                      Wrap(
                        spacing: 12,
                        runSpacing: 16,
                        children: [
                          NZButton.primary(
                            label: '薄荷绿',
                            color: NZColor.nezhaGreen,
                            onPressed: () => _showMsg('清新薄荷绿'),
                          ),
                          NZButton.primary(
                            label: '活力橙',
                            color: NZColor.nezhaOrange,
                            onPressed: () => _showMsg('活力阳光橙'),
                          ),
                          NZButton.primary(
                            label: '魅惑紫',
                            color: NZColor.nezhaPurple,
                            onPressed: () => _showMsg('神秘魅惑紫'),
                          ),
                          NZButton.outline(
                            label: '樱花粉',
                            color: NZColor.nezhaPink,
                            foregroundColor: NZColor.nezhaPink,
                            onPressed: () => _showMsg('浪漫樱花粉'),
                          ),
                          NZButton.secondary(
                            label: '警告红',
                            color: NZColor.nezhaRed.withValues(alpha: 0.1),
                            foregroundColor: NZColor.nezhaRed,
                            onPressed: () => _showMsg('危险警示红'),
                          ),
                        ],
                      ),
                    ),

                    // Icon Buttons Section
                    _buildSection(
                      '图标与状态',
                      Wrap(
                        spacing: 12,
                        runSpacing: 16,
                        children: [
                          NZButton.primary(
                            label: '添加',
                            icon: const Icon(Icons.add_rounded),
                            onPressed: () => _showMsg('执行添加操作'),
                          ),
                          NZButton.outline(
                            label: '下载',
                            icon: const Icon(Icons.cloud_download_outlined),
                            onPressed: () => _showMsg('开始云端下载'),
                          ),
                          NZButton.text(
                            label: '分享',
                            icon: const Icon(Icons.share_outlined),
                            onPressed: () => _showMsg('准备分享内容'),
                          ),
                        ],
                      ),
                    ),

                    // Progress Button Section
                    _buildSection(
                      '进度按钮 (NZProgressButton)',
                      NZProgressButton(
                        progress: _downloadProgress,
                        block: true,
                        color: NZColor.nezhaIndigo,
                        label: _isDownloading
                            ? '正在极速下载... ${(_downloadProgress * 100).toInt()}%'
                            : '点击体验背景进度',
                        onPressed: _simulateDownload,
                      ),
                    ),

                    // Image Button Section
                    _buildSection(
                      '图片按钮 (NZImageButton)',
                      NZImageButton(
                        image: const NetworkImage(
                          'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=2564&auto=format&fit=crop',
                        ),
                        label: '探索新视界',
                        block: true,
                        borderRadius: 16,
                        onPressed: () => _showMsg('开启视觉盛宴'),
                      ),
                    ),

                    // Interactive Counter
                    _buildSection(
                      '交互反馈',
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '活跃度计数',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '当前数值：$_counter',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black26,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            NZButton.primary(
                              label: '计数',
                              width: 80,
                              height: 40,
                              borderRadius: 20,
                              onPressed: _incrementCounter,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'NezhaUI ',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Version 1.0.0-stable',
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
          // Draggable Float Button
          NZDraggableButton(
            initialPosition: const Offset(300, 600),
            onTap: () {
              _messengerKey.currentState?.showSnackBar(
                const SnackBar(
                  content: Text('已触发悬浮助手回调'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF2D5AF0),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2D5AF0).withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.support_agent_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
