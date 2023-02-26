import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_request/domain/style.dart';
import 'package:flutter_test_request/presentation/cubit/bag_cubit/bag_page_cubit.dart';

class PizzaChekOrderPage extends StatelessWidget {
  const PizzaChekOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BagPageCubit(),
      child: Scaffold(
        body: PizzaChekOrderPageWrapper(),
      ),
    );
  }
}

class PizzaChekOrderPageWrapper extends StatefulWidget {
  const PizzaChekOrderPageWrapper({super.key});

  @override
  State<PizzaChekOrderPageWrapper> createState() =>
      _PizzaChekOrderPageWrapperState();
}

class _PizzaChekOrderPageWrapperState extends State<PizzaChekOrderPageWrapper> {
  Timer? _timer;
  int _secondsWait = 0;
  ConfettiController? _confettiController;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (tik) {
      if (_secondsWait < 3)
        setState(() {
          _secondsWait += 1;
        });
      else
        _timer!.cancel();
    });

    _confettiController = ConfettiController(duration: Duration(seconds: 1));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_secondsWait < 3) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Идёт проверка данных",
              style: titlteStyle,
            ),
            // Text("$_secondsWait"),
            SizedBox(
              height: 16,
            ),
            CircularProgressIndicator(
              color: primeryColor,
            ),
          ],
        ),
      );
    } else {
      _confettiController!.play();
      return Stack(children: [
        Positioned(
          top: 0,
          left: MediaQuery.of(context).size.width / 2,
          child: ConfettiWidget(
            confettiController: _confettiController!,
            blastDirection: pi / 2,
            numberOfParticles: 20,
            colors: [primeryColor],
          ),
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Зыказ успешно оплачен!",
              style: titlteStyle,
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<BagPageCubit>().cleanBag();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/", (route) => false);
              },
              child: Text(
                'Вернуться на главную страницу',
                style: buttonStyle,
              ),
              style: buttonStyleOrder,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     _confettiController!.play();
            //   },
            //   child: Text(
            //     'Вернуться на главную страницу',
            //     style: buttonStyle,
            //   ),
            //   style: buttonStyleOrder,
            // )
          ],
        )),
      ]);
    }
  }
}
