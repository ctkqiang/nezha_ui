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
  int _counter = 0;
  double _downloadProgress = 0.0;
  bool _isDownloading = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _simulateDownload() async {
    if (_isDownloading) return;
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
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
        const NZDivider(height: 48),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('NezhaUI Showcase'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    NZColor.nezhaPrimary,
                    NZColor.nezhaPrimary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: NZColor.nezhaPrimary.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
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
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '专为 Flutter 打造的高性能组件库\n轻量、灵活、极简',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.5,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Button Styles Section
            _buildSection(
              '按钮样式 (NZButton)',
              Wrap(
                spacing: 12,
                runSpacing: 16,
                children: [
                  NZButton(
                    onPressed: _incrementCounter,
                    child: const Text('主要按钮'),
                  ),
                  NZButton(
                    onPressed: () {},
                    style: NZButtonStyle.secondary,
                    child: const Text('次要按钮'),
                  ),
                  NZButton(
                    onPressed: () {},
                    style: NZButtonStyle.outline,
                    child: const Text('描边按钮'),
                  ),
                  NZButton(
                    onPressed: () {},
                    style: NZButtonStyle.text,
                    child: const Text('文字按钮'),
                  ),
                ],
              ),
            ),

            // Icon Buttons Section
            _buildSection(
              '带图标按钮',
              Wrap(
                spacing: 12,
                runSpacing: 16,
                children: [
                  NZButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_rounded),
                    child: const Text('添加数据'),
                  ),
                  NZButton(
                    onPressed: () {},
                    style: NZButtonStyle.text,
                    icon: const Icon(Icons.share_rounded),
                    child: const Text('分享内容'),
                  ),
                  NZButton(
                    onPressed: () {},
                    style: NZButtonStyle.outline,
                    icon: const Icon(Icons.cloud_download_rounded),
                    child: const Text('下载文件'),
                  ),
                ],
              ),
            ),

            // Progress Button Section
            _buildSection(
              '进度按钮 (NZProgressButton)',
              Column(
                children: [
                  NZProgressButton(
                    progress: _downloadProgress,
                    width: double.infinity,
                    onPressed: _simulateDownload,
                    child: Text(_isDownloading
                        ? '正在处理... ${(_downloadProgress * 100).toInt()}%'
                        : '开始异步任务'),
                  ),
                  if (_isDownloading)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        '任务执行中，请稍候...',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Counter Card
            _buildSection(
              '交互状态示例',
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: NZColor.nezhaPrimary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.touch_app_rounded,
                        color: NZColor.nezhaPrimary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      '累计点击次数',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$_counter',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: NZColor.nezhaPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            Center(
              child: Text(
                'NezhaUI Version 0.0.1',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        backgroundColor: NZColor.nezhaPrimary,
        elevation: 4,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('快速增加', style: TextStyle(color: Colors.white)),
      ),
    );
  }
