import 'package:flutter/material.dart';
import 'package:flutter_overtime/ui/pages/timer_page.dart';
import 'package:flutter_overtime/ui/theme/temes_constants.dart';
import 'package:flutter_overtime/ui/theme/theme_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

ThemeManager _themeManager = ThemeManager();

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      // backgroundColor: Colors.black,
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
          SizedBox(
            width: 58,
          )
        ],
      )),
      drawer: Drawer(
          backgroundColor: colorDark_bg,
          child: ListView(
            children: [
              DrawerHeader(
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
              button("Статистика", Icons.bar_chart, _textTheme),
              button("Уведомления", Icons.notifications_active_rounded,
                  _textTheme),
              button("О разработчике", Icons.info_outline_rounded, _textTheme),
              button("Настройки", Icons.settings, _textTheme),
            ],
          )),
      body: const StartPageWidget(),
    );
  }

  Widget button(String title, IconData icon, TextTheme style) {
    return ElevatedButton(
      onPressed: (() {}),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black.withAlpha(0)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: colorDark_primary,
          ),
          SizedBox(
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
          Expanded(child: SizedBox()),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(seconds: 1),
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
          Expanded(flex: 3, child: SizedBox()),
          ElevatedButton(
              onPressed: () {
                var providerTime =
                    Provider.of<TimerViewModel>(context, listen: false);
                providerTime.startTimer();
                Navigator.of(context).pushNamed("/timer_page");
              },
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(256, 48))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Посчитать бабки",
                    style: _textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/timer_page");
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: colorDark_primary,
                    ),
                  )
                ],
              )),
          Expanded(child: SizedBox()),
          Text(
            "разрабочик — Афанасьев Даниил",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 48,
          )
        ],
      ),
    );
  }
}
