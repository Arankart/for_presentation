import 'package:flutter/material.dart';
import 'package:flutter_overtime/ui/pages/start_page.dart';
import 'package:flutter_overtime/ui/pages/timer_page.dart';
import 'package:flutter_overtime/ui/theme/temes_constants.dart';
import 'package:flutter_overtime/ui/theme/theme_manager.dart';
import 'package:flutter_overtime/ui/widgets/alert_time_interval_choise_widget.dart';
import 'package:provider/provider.dart';

void main() {
  hiveInit();
  runApp(const MyApp());
}

Future<void> hiveInit() async {
  // await Hive.initFlutter();
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TimerViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => AlerTimeIntervalDataViewModel(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeManager.themeMode,
        debugShowCheckedModeBanner: false,
        routes: {
          "/start_page": (context) => StartPage(),
          "/timer_page": (context) => TimerWrapPage(),
        },
        initialRoute: "/start_page",
        home: const StartPage(),
      ),
    );
  }
}
