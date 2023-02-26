import 'package:flutter/animation.dart';

enum SizeOfPizza { little, big }

class PizzaModel {
  final String title;
  final String description;
  final String image;
  String price;
  SizeOfPizza sizeOfPizza = SizeOfPizza.little;

  PizzaModel({
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.sizeOfPizza,
  });

  PizzaModel copyWith({
    String? title,
    String? description,
    String? image,
    String? price,
    SizeOfPizza sizeOfPizza = SizeOfPizza.little,
  }) {
    return PizzaModel(
      title: title!,
      description: description!,
      image: image!,
      price: price!,
      sizeOfPizza: sizeOfPizza,
    );
  }
}
