import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_request/domain/models/pizza_model.dart';
import 'package:flutter_test_request/domain/style.dart';
import 'package:flutter_test_request/presentation/cubit/bag_cubit/bag_page_cubit.dart';

import '../../../domain/repositories/bag_repositiry.dart';

class PizzaPage extends StatelessWidget {
  const PizzaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    BagRepository bagRepository = BagRepository();

    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => BagPageCubit(),
        child: PizzaPageWidget(
          model: arguments as PizzaModel,
        ),
      ),
    );
  }
}

class PizzaPageWidget extends StatefulWidget {
  PizzaModel model;
  PizzaPageWidget({super.key, required this.model});

  @override
  State<PizzaPageWidget> createState() => _PizzaPageWidgetState();
}

class _PizzaPageWidgetState extends State<PizzaPageWidget> {
  final Color choiseColor = primeryLightColor;
  final Color unchoiseColor = lightColor;
  final Color choiseTextColor = primeryDarkColor;
  final Color unchoiseTextColor = greyDarkColor;

  late int pizzaPrice;

  @override
  Widget build(BuildContext context) {
    pizzaPrice = widget.model.sizeOfPizza == SizeOfPizza.little
        ? int.parse(widget.model.price)
        : int.parse(widget.model.price) * 2;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.model.image,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.model.title,
                      style: titlteStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.model.description,
                      style: descriptionStyle,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.model.sizeOfPizza = SizeOfPizza.little;
                            });
                          },
                          child: Text(
                            'Маленькая',
                            style: chipStyle.copyWith(
                              color:
                                  widget.model.sizeOfPizza == SizeOfPizza.little
                                      ? choiseTextColor
                                      : unchoiseTextColor,
                            ),
                          ),
                          style: ButtonStyle(
                            shadowColor: MaterialStateProperty.all(
                              Colors.black.withOpacity(0.04),
                            ),
                            backgroundColor:
                                widget.model.sizeOfPizza == SizeOfPizza.little
                                    ? MaterialStateProperty.all(choiseColor)
                                    : MaterialStateProperty.all(unchoiseColor),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.model.sizeOfPizza = SizeOfPizza.big;
                            });
                          },
                          child: Text(
                            'Большая',
                            style: chipStyle.copyWith(
                              color: widget.model.sizeOfPizza == SizeOfPizza.big
                                  ? choiseTextColor
                                  : unchoiseTextColor,
                            ),
                          ),
                          style: ButtonStyle(
                            shadowColor: MaterialStateProperty.all(
                              Colors.black.withOpacity(0.04),
                            ),
                            backgroundColor:
                                widget.model.sizeOfPizza == SizeOfPizza.big
                                    ? MaterialStateProperty.all(choiseColor)
                                    : MaterialStateProperty.all(unchoiseColor),
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
        Container(
          width: MediaQuery.of(context).size.width,
          height: 72,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                if (widget.model.sizeOfPizza == SizeOfPizza.big) {
                  widget.model = context
                      .read<BagPageCubit>()
                      .changePizzaPrice(widget.model);
                }
                context.read<BagPageCubit>().changePizzaPrice;
                context.read<BagPageCubit>().addPizzaToBag(widget.model);
                Navigator.of(context).pop();
              },
              child: Text(
                "Добавить в корзину ${pizzaPrice}р",
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
          height: 10,
        ),
      ],
    );
  }
}
