import 'package:flutter/material.dart';
import 'package:flutter_overtime/ui/pages/timer_page.dart';
import 'package:flutter_overtime/ui/theme/temes_constants.dart';
import 'package:provider/provider.dart';

class AlerWriteSessionWidget extends StatelessWidget {
  const AlerWriteSessionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<TimerViewModel>(context, listen: false);

    return AlertDialog(
      title: Text(
        "Записать результат?",
        style: _textTheme.bodyLarge
            ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
      ),
      // content: Text("Записать результат?"),
      actions: [
        TextButton(
            onPressed: () {
              provider.onStopButton();
              Navigator.of(context).pop();
            },
            child: Text(
              "Записать",
              style: _textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: colorDark_primary),
            )),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Назад",
              style: _textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: colorDark_primary),
            ))
      ],
    );
  }
}
