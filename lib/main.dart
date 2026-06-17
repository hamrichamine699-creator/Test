import 'package:flutter/material.dart';

void main() {
  runApp(const WarshQuranApp());
}

class WarshQuranApp extends StatefulWidget {
  const WarshQuranApp({super.key});

  @override
  State<WarshQuranApp> createState() => _WarshQuranAppState();
}

class _WarshQuranAppState extends State<WarshQuranApp> {
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مصحف ورش الذكي',
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0C1018),
        cardColor: const Color(0xFF131B26),
        primaryColor: const Color(0xFFD4AF50),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F0E8),
        cardColor: Colors.white,
        primaryColor: const Color(0xFF8B6010),
      ),
      home: MainNavigationScreen(
        isDarkMode: _isDarkMode,
        onThemeToggle: () => setState(() => _isDarkMode = !_isDarkMode),
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const MainNavigationScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.cardColor,
          elevation: 0.5,
          title: Text(
            'مصحف ورش عن نافع',
            style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.brightness_3),
              onPressed: widget.onThemeToggle,
            )
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const SurahListView(),
            const Center(child: Text('شاشة البحث')),
            const Center(child: Text('شاشة الإحصائيات والأخطاء')),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: theme.primaryColor,
          backgroundColor: theme.cardColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'إحصائيات'),
          ],
        ),
      ),
    );
  }
}

class SurahListView extends StatelessWidget {
  const SurahListView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // قائمة تجريبية لأول سورتين لتوليد الـ APK واختبار الواجهة
    final surahs = [
      {"id": 1, "name": "الفاتحة", "type": "مكية", "verses": 7},
      {"id": 67, "name": "الملك", "type": "مكية", "verses": 30},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: surahs.length,
      itemBuilder: (context, index) {
        final s = surahs[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.primaryColor.withOpacity(0.1),
              child: Text('${s["id"]}', style: TextStyle(color: theme.primaryColor)),
            ),
            title: Text('${s["name"]}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: Text('${s["type"]} · ${s["verses"]} آية'),
            trailing: const Icon(Icons.mic, color: Colors.grey),
            onTap: () {
              // مسار الميكروفون والتسميع الذكي لورش
            },
          ),
        );
      },
    );
  }
}
