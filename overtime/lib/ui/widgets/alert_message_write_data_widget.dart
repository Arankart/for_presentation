import 'package:flutter/material.dart';
import 'package:flutter_overtime/ui/pages/timer_page.dart';
import 'package:flutter_overtime/ui/theme/themes_constants.dart';
import 'package:provider/provider.dart';

import '../../domain/view_models/timer_view_model.dart';

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
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Назад",
              style: _textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600, color: colorDark_red),
            )),
        TextButton(
            onPressed: () {
              provider.onStopButton();
              provider.addDataToDB();
              Navigator.of(context).pop();
            },
            child: Text(
              "Записать",
              style: _textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: colorDark_primary),
            )),
      ],
    );
  }
}
