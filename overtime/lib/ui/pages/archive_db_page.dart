// ignore_for_file: curly_braces_in_flow_control_structures, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_overtime/domain/databases/hive_time_db.dart';
import 'package:flutter_overtime/domain/models/day_time_model.dart';
import 'package:flutter_overtime/domain/models/time_calculate_model.dart';
import 'package:flutter_overtime/ui/pages/archive_day.dart';
import 'package:flutter_overtime/ui/pages/timer_page.dart';
import 'package:flutter_overtime/ui/theme/themes_constants.dart';
import 'package:flutter_overtime/ui/theme/theme_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../domain/services/archive_service.dart';
import '../../domain/view_models/archive_view_model.dart';

ThemeManager _themeManager = ThemeManager();

class SendDataToDayPage {
  DayTimeModel day;
  int indexDataOfDb;
  SendDataToDayPage({required this.day, required this.indexDataOfDb});
}

class ArchiveDbPage extends StatelessWidget {
  const ArchiveDbPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return ChangeNotifierProvider(
      create: (context) => ArchiveDbPageViewModel(),
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
          child: const ArchiveDbPageWidget(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/dataBase.png',
                  ),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  opacity: 0.1),
              gradient: LinearGradient(
                  begin: Alignment(-0.5, 0.1),
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Color.fromARGB(255, 3, 63, 44),
                  ])),
        ),
      ),
    );
  }
}

class ArchiveDbPageWidget extends StatelessWidget {
  const ArchiveDbPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dataDb = HiveDB.db.getTimeData();
    final provider = Provider.of<ArchiveDbPageViewModel>(context);

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
          TextTheme _textTheme = Theme.of(context).textTheme;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      itemCount: provider.servise.dataModel.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 24,
                        childAspectRatio: 3 / 1.9,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final DateFormat formatter = DateFormat('dd.MM.yyyy');

                        var start = provider
                            .servise.dataModel[index].dataList?[0].dataStart;
                        var end = provider
                            .servise.dataModel[index].dataList?[0].dataStart;

                        DateTime dateString =
                            provider.servise.dataModel[index].date;
                        final String formatted = formatter.format(dateString);
                        String countTimeWorkInDay = provider.servise.deltaTime(
                            provider.servise.dataModel[index].dataList!);

                        return InkWell(
                          onTap: (() {
                            provider.servise.selectIndexWrite(index);
                            var obj = SendDataToDayPage(
                              day: provider.servise.dataModel[index],
                              indexDataOfDb: provider.servise.selecionDateIndex,
                            );
                            print("selected id: " +
                                provider.servise.selecionDateIndex.toString());
                            Navigator.of(context)
                                .pushNamed("/archive_day", arguments: obj);
                          }),
                          child: Container(
                            decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? Colors.grey.withOpacity(0.1)
                                    : Colors.black54,
                                border: Border.all(
                                    width: 1,
                                    color: colorDark_primary.withOpacity(0.1)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatted,
                                        style: _textTheme.titleLarge!.copyWith(
                                            color: colorDark_primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Время: ${countTimeWorkInDay}",
                                        style: _textTheme.titleLarge!.copyWith(
                                            fontSize: 16,
                                            color: colorDark_white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Сессий: " +
                                            provider.servise.dataModel[index]
                                                .dataList!.length
                                                .toString(),
                                        style: _textTheme.titleLarge!.copyWith(
                                            fontSize: 16,
                                            color: colorDark_white,
                                            fontWeight: FontWeight.w500),
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
                // Expanded(
                //   child: ListView.separated(
                //       separatorBuilder: ((context, index) =>
                //           const SizedBox(height: 16)),
                //       padding: const EdgeInsets.all(12),
                //       itemCount: provider.servise.dataModel.length,
                //       itemBuilder: (context, index) {
                //         final DateFormat formatter = DateFormat('dd.MM.yyyy');

                //         var start = provider
                //             .servise.dataModel[index].dataList?[0].dataStart;
                //         var end = provider
                //             .servise.dataModel[index].dataList?[0].dataStart;

                //         DateTime dateString =
                //             provider.servise.dataModel[index].date;
                //         final String formatted = formatter.format(dateString);
                //         String countTimeWorkInDay = provider.servise.deltaTime(
                //             provider.servise.dataModel[index].dataList!);

                //         return InkWell(
                //           onTap: (() {
                //             provider.servise.selectIndexWrite(index);
                //             var obj = SendDataToDayPage(
                //               day: provider.servise.dataModel[index],
                //               indexDataOfDb: provider.servise.selecionDateIndex,
                //             );
                //             print("selected id: " +
                //                 provider.servise.selecionDateIndex.toString());
                //             Navigator.of(context)
                //                 .pushNamed("/archive_day", arguments: obj);
                //           }),
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 color: index % 2 == 0
                //                     ? Colors.grey.withOpacity(0.1)
                //                     : Colors.black54,
                //                 border: Border.all(
                //                     width: 1,
                //                     color: colorDark_primary.withOpacity(0.1)),
                //                 borderRadius:
                //                     const BorderRadius.all(Radius.circular(24))),
                //             child: Padding(
                //               padding: const EdgeInsets.symmetric(
                //                   vertical: 8.0, horizontal: 16.0),
                //               child: Row(
                //                 children: [
                //                   Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         formatted,
                //                         style: _textTheme.titleLarge!.copyWith(
                //                             color: colorDark_primary,
                //                             fontWeight: FontWeight.w600,
                //                             fontSize: 20),
                //                       ),
                //                       const SizedBox(
                //                         height: 8,
                //                       ),
                //                       Text(
                //                         "Сессий: " +
                //                             provider.servise.dataModel[index]
                //                                 .dataList!.length
                //                                 .toString() +
                //                             ', ' +
                //                             "Время: ${countTimeWorkInDay}",
                //                         style: _textTheme.titleLarge!.copyWith(
                //                             fontSize: 16,
                //                             color: colorDark_white,
                //                             fontWeight: FontWeight.w500),
                //                       ),
                //                     ],
                //                   ),
                //                   const Expanded(child: SizedBox()),
                //                   const Icon(Icons.arrow_forward_ios_rounded),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         );
                //       }),
                // ),
              ],
            ),
          );
        } else
          return Container(
            decoration: BoxDecoration(color: Colors.grey.shade600),
            child: const Center(
              child: Text(
                textAlign: TextAlign.center,
                "error loading data",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          );
      },
    ));
  }
}
