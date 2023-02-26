import 'package:flutter/material.dart';
import 'package:flutter_overtime/domain/models/day_time_model.dart';
import 'package:flutter_overtime/domain/models/time_calculate_model.dart';
import 'package:flutter_overtime/ui/pages/grid_view.dart';
import 'package:flutter_overtime/ui/pages/start_page.dart';
import 'package:flutter_overtime/ui/pages/archive_day.dart';
import 'package:flutter_overtime/ui/pages/archive_db_page.dart';
import 'package:flutter_overtime/ui/pages/timer_page.dart';
import 'package:flutter_overtime/ui/theme/themes_constants.dart';
import 'package:flutter_overtime/ui/theme/theme_manager.dart';
import 'package:flutter_overtime/ui/widgets/alert_time_interval_choise_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

import 'domain/view_models/archive_day_view_model.dart';
import 'domain/view_models/archive_view_model.dart';
import 'domain/view_models/timer_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // telegramBot.initBot();
  hiveInit();

  runApp(const MyApp());
}

Future<void> hiveInit() async {
  await Hive.initFlutter();
  adaptersReg();
}

Future<void> deleteDbFromDisk() async {
  await Hive.deleteBoxFromDisk("timeDataDB");
}

void adaptersReg() {
  Hive.registerAdapter(DayTimeModelAdapter());
  Hive.registerAdapter(TimeDataModelAdapter());
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
        ),
        ChangeNotifierProvider(
          create: (_) => ArchiveDbPageViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ArchiveDayPageViewModel(),
        ),
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
          "/archive_page": (context) => ArchiveDbPage(),
          "/archive_day": (context) => ArchiveDayPage(),
          '/grid_view': (context) => GridViewPage(),
        },
        initialRoute: "/start_page",
        home: const StartPage(),
      ),
    );
  }
}
