import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_overtime/domain/services/timer_service.dart';
import 'package:flutter_overtime/ui/theme/temes_constants.dart';
import 'package:flutter_overtime/ui/theme/theme_manager.dart';
import 'package:flutter_overtime/ui/widgets/alert_message_write_data_widget.dart';
import 'package:flutter_overtime/ui/widgets/alert_time_interval_choise_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ThemeManager _themeManager = ThemeManager();

class TimerViewModelState {
  final String countText;
  final bool timeRun;
  final String timeRunText;
  final String data;
  final String timeStart;
  final String interval;
  late final String newNotification;

  TimerViewModelState(
      {required this.countText,
      required this.timeRun,
      required this.timeRunText,
      required this.data,
      required this.timeStart,
      required this.interval,
      required this.newNotification});
}

class TimerViewModel extends ChangeNotifier {
  var _service = TimerService();

  var _state = TimerViewModelState(
      countText: "",
      timeRun: false,
      timeRunText: "",
      data: "",
      timeStart: "",
      interval: "",
      newNotification: "");
  TimerViewModelState get state => _state;
  late Timer timerTic = Timer(Duration(seconds: 0), () {});

  TimerViewModel() {
    loadValue();
  }

  void setInterval(int val) {
    _service.interval = val;
    updateState();
  }

  void startTimer() {
    timerTic = Timer.periodic(Duration(seconds: 1), (t) {
      _service.date;
      _service.newNotification;
      print(timerTic.tick);
      print(_service.newNotification);
      updateState();
    });
  }

  Future<void> timerStop() async {
    timerTic.cancel();
    print('timer stop');
  }

  void loadValue() {
    _state = TimerViewModelState(
      countText: _service.count.toString(),
      timeRun: _service.isRun,
      timeRunText: _service.isRun.toString(),
      data: _service.date,
      timeStart: _service.timeStart,
      interval: _service.interval.toString(),
      newNotification: _service.newNotification,
    );
  }

  void updateState() {
    final count = _service.count;
    final isRun = _service.isRun;

    _state = TimerViewModelState(
      countText: _service.count.toString(),
      timeRun: _service.isRun,
      timeRunText: _service.isRun.toString(),
      data: _service.date,
      timeStart: _service.timeStart,
      interval: _service.interval.toString(),
      newNotification: _service.newNotification,
    );

    notifyListeners();
  }

  void onStartButton() {
    _service.startTimer();
    updateState();
  }

  void onStopButton() {
    _service.stopTimer();
    updateState();
  }
}

class TimerWrapPage extends StatelessWidget {
  const TimerWrapPage({super.key});
  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return TimerPage();
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
        Provider.of<TimerViewModel>(context, listen: false).timerStop();
        return true;
      },
      child: Scaffold(
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
        body: TimerPageWidget(),
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
          Expanded(child: SizedBox()),
          Text(
            "0 часов",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 32,
              height: 1.3,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "0 минут",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 32,
              height: 1.3,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "Сегодня ${provider.state.data}",
            style: _textTheme.bodyMedium?.copyWith(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          provider.state.timeRun == true
              ? Text(
                  "Перерабатываем с ${provider.state.timeStart}",
                  style: _textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )
              : SizedBox(),
          Expanded(flex: 3, child: SizedBox()),
          Statistic(),
          SizedBox(
            height: 24,
          ),
          // StartTimer(),
          provider.state.timeRun == false ? StartTimer() : RunTimer(),
          // runTimer(_textTheme),
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
                provider.onStopButton();
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
        SizedBox(
          width: 24,
        ),
        Expanded(
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context, builder: (_) => AlerWriteSessionWidget());
                // provider.onStopButton();
              },
              style: ButtonStyle(),
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
    return Expanded(
      child: ElevatedButton(
          onPressed: () {
            provider.onStartButton();
          },
          style: ButtonStyle(),
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
                  builder: (_) => AlerTimeIntervalWidget(),
                );
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade900)),
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
                          SizedBox(
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
        SizedBox(
          width: 24,
        ),
        Expanded(
          child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.grey.shade900),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "в ${provider.state.newNotification}",
                            style: _textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: colorDark_red,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "Следующее напоминание",
                            style: _textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
