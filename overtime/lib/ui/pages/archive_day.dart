// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_new, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_overtime/domain/databases/hive_time_db.dart';
import 'package:flutter_overtime/domain/models/day_time_model.dart';
import 'package:flutter_overtime/domain/models/time_calculate_model.dart';
import 'package:flutter_overtime/ui/pages/archive_db_page.dart';
import 'package:flutter_overtime/ui/pages/timer_page.dart';
import 'package:flutter_overtime/ui/theme/themes_constants.dart';
import 'package:flutter_overtime/ui/theme/theme_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../domain/view_models/archive_day_view_model.dart';
import '../../domain/view_models/archive_view_model.dart';

ThemeManager _themeManager = ThemeManager();

class ArchiveDayPage extends StatelessWidget {
  const ArchiveDayPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    RouteSettings settings = ModalRoute.of(context)!.settings;
    final data = settings.arguments;
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
      body: Container(
        child: StatictisDayPageWidget(
            selecionDate: settings.arguments as SendDataToDayPage),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/dataBaseArchive.png',
                ),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                opacity: 0.1),
            gradient: LinearGradient(
                begin: Alignment(0.4, 0.2),
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Color.fromARGB(255, 3, 63, 44),
                ])),
      ),
    );
  }
}

class StatictisDayPageWidget extends StatelessWidget {
  SendDataToDayPage selecionDate;
  late int selecionDateindex;

  StatictisDayPageWidget({super.key, required this.selecionDate}) {
    selecionDateindex = selecionDate.indexDataOfDb;
  }

  @override
  Widget build(BuildContext context) {
    final provider_db = Provider.of<ArchiveDbPageViewModel>(context);
    TextTheme _textTheme = Theme.of(context).textTheme;
    final dataBase = HiveDB.db;
    final dataDb = dataBase.getTimeData();
    final provider = Provider.of<ArchiveDayPageViewModel>(context);

    return Center(
        child: FutureBuilder(
      future: dataDb,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const CircularProgressIndicator();
        else if (snapshot.data!.length == 0 || snapshot.data == null)
          return const Text(
            textAlign: TextAlign.center,
            "Пока нет ни одной переработки!",
            style: TextStyle(color: Colors.white, fontSize: 24),
          );
        else if (snapshot.connectionState == ConnectionState.done) {
          snapshot.hasData ? provider.servise.initData(snapshot.data!) : null;

          final selectionObject = provider.servise.dataModel[selecionDateindex];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.separated(
                    separatorBuilder: ((context, index) =>
                        const SizedBox(height: 16)),
                    padding: const EdgeInsets.all(12),
                    itemCount: selectionObject.dataList!.length,
                    itemBuilder: (context, index) {
                      final DateFormat formatter = DateFormat('HH:mm');

                      final String start = formatter.format(selectionObject
                          .dataList?[index].dataStart as DateTime);

                      var end = formatter.format(
                          selectionObject.dataList?[index].dataEnd as DateTime);

                      print("length ${selectionObject.dataList!.length}");

                      var difCount = selectionObject.dataList?[index].dataEnd
                          ?.difference(selectionObject
                              .dataList?[index].dataStart as DateTime);
                      var difMinutes = difCount!.inMinutes;

                      while (difMinutes > 60) {
                        difMinutes -= 60;
                      }

                      return InkWell(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(
                                      "Удалить сессию?",
                                      style: _textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Назад",
                                            style: _textTheme.bodyMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: colorDark_primary),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            provider.onButtonDelete(
                                                selecionDateindex, index);

                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Удалить",
                                            style: _textTheme.bodyMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: colorDark_red),
                                          )),
                                    ],
                                  ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? Colors.grey.withOpacity(0.1)
                                  : Colors.black54,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Сессия ${index + 1}\n",
                                  style: _textTheme.titleLarge!.copyWith(
                                      color: colorDark_primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Время сессии: ${difCount.inHours} часов, ${difMinutes} минут",
                                  style: _textTheme.titleLarge!.copyWith(
                                      fontSize: 16,
                                      color: colorDark_white,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      // ignore: prefer_const_constructors
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      child: Text(
                                        "Старт в ${start}",
                                        style: _textTheme.titleLarge!.copyWith(
                                            fontSize: 14,
                                            color: colorDark_white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      decoration: BoxDecoration(
                                          color: colorDark_primary
                                              .withOpacity(0.1),
                                          border: Border.all(
                                              width: 1,
                                              color: colorDark_primary
                                                  .withOpacity(0.4)),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(24))),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      child: Text(
                                        "Стоп в ${end}",
                                        style: _textTheme.titleLarge!.copyWith(
                                            fontSize: 14,
                                            color: colorDark_white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      decoration: BoxDecoration(
                                          color: colorDark_red.withOpacity(0.1),
                                          border: Border.all(
                                              width: 1,
                                              color: colorDark_red
                                                  .withOpacity(0.4)),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(24))),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.info_outline_rounded,
                    size: 24,
                  ),
                  title: Text(
                    "Для удаления сессии, выполните долгое нажатие на нужном блоке",
                    style: _textTheme.bodyLarge!.copyWith(
                        color: colorDark_white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          );
        } else
          return Container(
            decoration: BoxDecoration(color: Colors.grey.shade600),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                "error loading data",
                style: _textTheme.bodySmall,
              ),
            ),
          );
      },
    ));
  }
}
