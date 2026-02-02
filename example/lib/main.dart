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
            body: SingleChildScrollView(
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
                          color: const Color(0xFF2D5AF0).withValues(alpha: 0.3),
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
                    '基础按钮样式 (NZButton)',
                    Column(
                      children: [
                        Wrap(
                          spacing: 12,
                          runSpacing: 16,
                          children: [
                            NZButton.primary(
                              label: '主要操作',
                              onPressed: _incrementCounter,
                            ),
                            NZButton.secondary(label: '次要操作', onPressed: () {}),
                            NZButton.outline(label: '描边按钮', onPressed: () {}),
                            NZButton.text(label: '文字按钮', onPressed: () {}),
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
                          onPressed: () {},
                        ),
                        NZButton.outline(
                          label: '下载',
                          icon: const Icon(Icons.cloud_download_outlined),
                          onPressed: () {},
                        ),
                        NZButton.text(
                          label: '分享',
                          icon: const Icon(Icons.share_outlined),
                          onPressed: () {},
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
                      onPressed: () {},
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '活跃度',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            '$_counter',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF2D5AF0),
                            ),
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
                          'NezhaUI Design System',
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
          // Draggable Float Button
          NZDraggableButton(
            initialPosition: const Offset(300, 600),
            onTap: () {
              _messengerKey.currentState?.showSnackBar(
                const SnackBar(
                  content: Text('你点击了悬浮助手！姐姐一直在你身边哦~'),
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
