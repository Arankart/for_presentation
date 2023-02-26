import 'package:flutter/material.dart';
import 'package:flutter_overtime/ui/pages/timer_page.dart';
import 'package:flutter_overtime/ui/theme/themes_constants.dart';
import 'package:provider/provider.dart';

import '../../domain/view_models/timer_view_model.dart';

class AlerTimeIntervalService {
  int _choiseValue = 0;
  int get choiseValue => _choiseValue;
  set choiseValue(int val) {
    _choiseValue = val;
  }
}

class AlerTimeIntervalDataViewModel extends ChangeNotifier {
  var _service = AlerTimeIntervalService();

  void choiseValueSet(int val) {
    _service.choiseValue = val;
  }
}

class AlerTimeIntervalWidget extends StatelessWidget {
  const AlerTimeIntervalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text("Выбрать интервал"),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WheelScroll(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Выйти",
            style: _textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600, color: colorDark_red),
          ),
        ),
        TextButton(
            onPressed: () {
              var providerTime =
                  Provider.of<TimerViewModel>(context, listen: false);
              var providerWeel = Provider.of<AlerTimeIntervalDataViewModel>(
                  context,
                  listen: false);

              providerTime.setInterval(providerWeel._service.choiseValue);
              Navigator.of(context).pop();
            },
            child: Text(
              "Установить",
              style: _textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: colorDark_primary),
            )),
      ],
    );
  }
}

class WheelScroll extends StatefulWidget {
  const WheelScroll({super.key});

  @override
  State<WheelScroll> createState() => _WheelScrollState();
}

class _WheelScrollState extends State<WheelScroll> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: ListWheelScrollView.useDelegate(
        physics: FixedExtentScrollPhysics(),
        itemExtent: 60,
        perspective: 0.001,
        diameterRatio: 0.9,
        // useMagnifier: true,
        // magnification: 1.5,
        childDelegate: ListWheelChildBuilderDelegate(
            childCount: 60,
            builder: ((context, index) {
              return CountTextWidget(index: index.toString());
            })),
        onSelectedItemChanged: (index) {
          Provider.of<AlerTimeIntervalDataViewModel>(context, listen: false)
              .choiseValueSet(index);
        },
      ),
    );
  }
}

class CountTextWidget extends StatelessWidget {
  String index;
  CountTextWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Container(
      width: 120,
      height: 50,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: colorDark_primary,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          )),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              index,
              style: _textTheme.bodyLarge!.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: colorDark_bg),
            ),
            Text(
              " мин",
              style: _textTheme.bodyLarge!.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: colorDark_bg),
            )
          ],
        ),
      ),
    );
  }
}
