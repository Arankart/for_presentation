import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_overtime/domain/models/day_time_model.dart';
import 'package:flutter_overtime/domain/models/time_calculate_model.dart';
import 'package:flutter_overtime/domain/services/timer_service.dart';
import 'package:flutter_overtime/ui/theme/themes_constants.dart';
import 'package:flutter_overtime/ui/theme/theme_manager.dart';
import 'package:flutter_overtime/ui/widgets/alert_message_write_data_widget.dart';
import 'package:flutter_overtime/ui/widgets/alert_time_interval_choise_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../domain/view_models/timer_view_model.dart';
import '../widgets/alert_message_cancel_data_widget.dart';

// ThemeManager _themeManager = ThemeManager();

class TimerWrapPage extends StatelessWidget {
  const TimerWrapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TimerPage();
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/clock.png',
                ),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                opacity: 0.1),
            gradient: LinearGradient(
              begin: Alignment(-0.6, -0.2),
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Color.fromARGB(255, 3, 63, 44),
              ],
            ),
          ),
          child: const TimerPageWidget(),
        ),
      ),
    );
  }
}

class TimerPageWidget extends StatefulWidget {
  const TimerPageWidget({super.key});

  @override
  State<TimerPageWidget> createState() => _TimerPageWidgetState();
}

class _TimerPageWidgetState extends State<TimerPageWidget> {
  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<TimerViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          provider.state.timeRun == true
              ? Text(
                  provider.state.clockTikText[2],
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                )
              : const SizedBox(),
          Text(
            provider.state.countText,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 32,
              height: 1.3,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Сегодня ${provider.state.data}",
            style: _textTheme.bodyMedium?.copyWith(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          provider.state.timeRun == true
              ? Text(
                  "Запись идёт с ${provider.state.timeRunText}",
                  style: _textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )
              : const SizedBox(),
          const Expanded(flex: 4, child: SizedBox()),
          const Statistic(),
          const SizedBox(
            height: 24,
          ),
          provider.state.timeRun == false
              ? const StartTimer()
              : const RunTimer(),
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

class RunTimer extends StatelessWidget {
  const RunTimer({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<TimerViewModel>(context);

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => const AlerCanselSessionWidget());
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(colorDark_red)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Отмена",
                    style: _textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )),
        ),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => const AlerWriteSessionWidget());
                // provider.onStopButton();
              },
              style: const ButtonStyle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Записать",
                    style: _textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

class StartTimer extends StatelessWidget {
  const StartTimer({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<TimerViewModel>(context);
    return Container(
      child: ElevatedButton(
          onPressed: () {
            provider.onStartButton();
          },
          style: const ButtonStyle(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Начать запись",
                style: _textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )),
    );
  }
}

class Statistic extends StatelessWidget {
  const Statistic({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<TimerViewModel>(context);
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const AlerTimeIntervalWidget(),
                );
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.withOpacity(0.1))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "${provider.state.interval} мин",
                            style: _textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                              color: colorDark_primary,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "Интервал напоминаний",
                            style: _textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
        // const SizedBox(
        //   width: 24,
        // ),
        // Expanded(
        //   child: ElevatedButton(
        //       onPressed: () {},
        //       style: ButtonStyle(
        //         backgroundColor:
        //             MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
        //       ),
        //       child: Row(
        //         children: [
        //           Expanded(
        //             child: Padding(
        //               padding: const EdgeInsets.all(16.0),
        //               child: Column(
        //                 children: [
        //                   Text(
        //                     "в ${provider.state.newNotification}",
        //                     style: _textTheme.bodyLarge?.copyWith(
        //                       fontWeight: FontWeight.w700,
        //                       fontSize: 18,
        //                       color: colorDark_red,
        //                     ),
        //                   ),
        //                   const SizedBox(
        //                     height: 8,
        //                   ),
        //                   Text(
        //                     textAlign: TextAlign.center,
        //                     "Следующее напоминание",
        //                     style: _textTheme.bodyLarge?.copyWith(
        //                         fontWeight: FontWeight.w600,
        //                         fontSize: 12,
        //                         color: Colors.white),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ],
        //       )),
        // ),
      ],
    );
  }
}
