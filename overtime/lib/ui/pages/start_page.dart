import 'package:flutter/material.dart';
import 'package:flutter_overtime/domain/data_providers/telegram_bot.dart';
import 'package:flutter_overtime/domain/databases/hive_time_db.dart';
import 'package:flutter_overtime/ui/theme/themes_constants.dart';
import 'package:flutter_overtime/ui/theme/theme_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../domain/view_models/timer_view_model.dart';

ThemeManager _themeManager = ThemeManager();
// TelegramBot telegramBot = TelegramBot.telegramBot;

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Задержун",
            style: _textTheme.bodyMedium
                ?.copyWith(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(
            width: 58,
          )
        ],
      )),
      drawer: Drawer(
          backgroundColor: colorDark_bg,
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: colorDark_primary),
                child: Center(
                  child: Text(
                    'Задержун',
                    style: TextStyle(
                        color: colorDark_bg,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              button(
                "Архив записей",
                Icons.bar_chart,
                _textTheme,
                context,
                "/archive_page",
              ),
              // button("Уведомления", Icons.notifications_active_rounded,
              //     _textTheme, context),
              // button("О разработчике", Icons.info_outline_rounded, _textTheme,
              //     context),
              // button("Настройки", Icons.settings, _textTheme, context),
            ],
          )),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/spaceman.png',
              ),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              opacity: 0.1),
          gradient: LinearGradient(
            begin: Alignment(0.4, 0.1),
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color.fromARGB(255, 3, 63, 44),
            ],
          ),
        ),
        child: const StartPageWidget(),
      ),
    );
  }

  Widget button(
      String title, IconData icon, TextTheme style, BuildContext context,
      [String? path]) {
    return ElevatedButton(
      onPressed: (() {
        path != '' ? Navigator.of(context).pushNamed(path!) : null;
      }),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black.withAlpha(0)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: colorDark_primary,
          ),
          const SizedBox(
            width: 24,
          ),
          Text(
            title,
            style:
                style.bodyMedium?.copyWith(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class StartPageWidget extends StatelessWidget {
  const StartPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              builder: ((context, value, child) {
                return Text(
                  "Кого задерживают на работе, тот не опаздывает на свидание",
                  style: GoogleFonts.montserrat(
                    color: Colors.white.withOpacity(value),
                    fontSize: 32,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                );
              })),
          const Expanded(flex: 3, child: SizedBox()),
          ElevatedButton(
              onPressed: () {
                var providerTime =
                    Provider.of<TimerViewModel>(context, listen: false);
                Navigator.of(context).pushNamed("/timer_page");
              },
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size(256, 48))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Посчитать бабки",
                    style: _textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/timer_page");
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: colorDark_primary,
                    ),
                  )
                ],
              )),
          const Expanded(child: SizedBox()),
          Text(
            "разрабочик — Афанасьев Даниил",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 48,
          )
        ],
      ),
    );
  }
}
