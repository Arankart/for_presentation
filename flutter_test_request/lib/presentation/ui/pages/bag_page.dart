// ignore_for_file: curly_braces_in_flow_control_structures, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_request/domain/repositories/bag_repositiry.dart';

import '../../../domain/models/pizza_model.dart';
import '../../../domain/style.dart';
import '../../cubit/bag_cubit/bag_page_cubit.dart';

class BagPage extends StatelessWidget {
  const BagPage({super.key});

  @override
  Widget build(BuildContext context) {
    BagRepository bagRepository = BagRepository.instance;

    return BlocProvider<BagPageCubit>(
      create: (context) => BagPageCubit(),
      child: BagPageWrappetr(bagRepository: bagRepository),
    );
  }
}

class BagPageWrappetr extends StatelessWidget {
  BagRepository bagRepository;

  BagPageWrappetr({super.key, required this.bagRepository});

  @override
  Widget build(BuildContext context) {
    if (context.watch<BagPageCubit>().bagRepository.model.pizzesInBag.length ==
        0)
      return Center(
        child: Text(
          "В корзине пока пусто",
          textAlign: TextAlign.center,
          style: titlteStyle,
        ),
      );
    else
      return SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            PizzaWidget(
              bagRepository: bagRepository,
            ),
          ],
        ),
      );
  }
}

class PizzaWidget extends StatefulWidget {
  BagRepository bagRepository;

  PizzaWidget({super.key, required this.bagRepository});

  @override
  State<PizzaWidget> createState() => _PizzaWidgetState();
}

class _PizzaWidgetState extends State<PizzaWidget> {
  int amountPurchase = 0;

  final GlobalKey<FormState> _cardKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _cvvKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dateKey = GlobalKey<FormState>();

  final TextEditingController _cardEditingController = TextEditingController();
  final TextEditingController _cvvEditingController = TextEditingController();
  final TextEditingController _dateEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<PizzaModel> model =
        context.watch<BagPageCubit>().bagRepository.model.pizzesInBag;

    amountPurchase = 0;
    for (var e in model) {
      amountPurchase += int.parse(e.price);
    }

    return Column(
      children: [
        SizedBox(
          height: 96,
        ),
        Text(
          "В корзине ${model.length} пиццы\n на ${amountPurchase}р",
          textAlign: TextAlign.center,
          style: titlteStyle,
        ),
        SizedBox(
          height: 48,
        ),
        PizzaListWidget(bagRepository: widget.bagRepository),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 72,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                cardFunc();
              },
              child: Text(
                "Оформить",
                style: buttonStyle,
              ),
              style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(
                    Colors.black.withOpacity(0.04),
                  ),
                  backgroundColor: MaterialStateProperty.all(primeryColor)),
            ),
          ),
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }

  void cardFunc() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext contextBottomSheet) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(contextBottomSheet).viewInsets.bottom),
        child: SizedBox(
          height: 300,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    Container(
                      decoration: bagBoxDecoration,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.0,
                          right: 8,
                          bottom: 8,
                        ),
                        child: TextFormField(
                          key: _cardKey,
                          controller: _cardEditingController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(16),
                            CardNumberFormat(),
                          ],
                          decoration: InputDecoration(
                            hintText: 'Номер карты',
                            prefixIcon: Icon(Icons.credit_card_rounded),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Введите номер карты";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: bagBoxDecoration,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: TextFormField(
                                key: _cvvKey,
                                controller: _cvvEditingController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  hintText: 'CVV',
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Введите cvv код";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            decoration: bagBoxDecoration,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: TextFormField(
                                key: _dateKey,
                                controller: _dateEditingController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(4),
                                  MontYearNumberFormat(),
                                ],
                                decoration: InputDecoration(
                                  hintText: 'ММ/ГГ',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Введите дату";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 72,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Назад",
                                  style: buttonStyle.copyWith(
                                      color: Colors.grey.shade400),
                                ),
                                style: ButtonStyle(
                                    shadowColor: MaterialStateProperty.all(
                                      Colors.black.withOpacity(0.04),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all(greyColor)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 72,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  print(_cardEditingController.text.length);
                                  print(_cvvEditingController.text.length);
                                  print(_dateEditingController.text.length);

                                  if (_cardEditingController.text.isNotEmpty &&
                                      _cardEditingController.text.length ==
                                          22 &&
                                      _cvvEditingController.text.isNotEmpty &&
                                      _cvvEditingController.text.length == 3 &&
                                      _dateEditingController.text.isNotEmpty &&
                                      _dateEditingController.text.length == 5) {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/pizza_check_order_page',
                                            (route) => false);
                                  }
                                },
                                child: Text(
                                  "Оплатить ${amountPurchase}р",
                                  style: buttonStyle,
                                ),
                                style: ButtonStyle(
                                    shadowColor: MaterialStateProperty.all(
                                      Colors.black.withOpacity(0.04),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        primeryColor)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardNumberFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;

      if (index % 4 == 0 && inputData.length != index) {
        buffer.write("  ");
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}

class MontYearNumberFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    List<String> dateList = [];
    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      dateList = inputData.split("");

      int index = i + 1;
      dateList.add(inputData[inputData.length - 1]);

      int.parse(dateList[0]) > 1 ? dateList[0] = "1" : null;
      inputData.length > 1
          ? int.parse(dateList[1]) > 2
              ? dateList[1] = "2"
              : null
          : null;

      buffer.write(dateList[i]);

      if (index % 2 == 0 && inputData.length != index) {
        buffer.write("/");
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}

class PizzaListWidget extends StatelessWidget {
  BagRepository bagRepository;

  PizzaListWidget({super.key, required this.bagRepository});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final PizzaModel model = bagRepository.model.pizzesInBag[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: bagBoxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Image.network(
                            model.image,
                            alignment: Alignment.topCenter,
                          ),
                          title: Text(
                            model.title,
                            style: descriptionStyle,
                          ),
                          subtitle: Text(
                            model.description,
                            maxLines: 2,
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              Text(
                                model.sizeOfPizza == SizeOfPizza.little
                                    ? "Маленькая " + model.price + "р"
                                    : "Большая " + model.price + "р",
                                style: descriptionStyle,
                              ),
                              Expanded(
                                  child: SizedBox(
                                width: 10,
                              )),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<BagPageCubit>()
                                      .deletePizzeFromList(index);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: greyDarkColor,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 8,
                ),
            itemCount: context
                .watch<BagPageCubit>()
                .bagRepository
                .model
                .pizzesInBag
                .length),
      ],
    );
  }
}
