import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/pizza_model.dart';
import '../../../domain/style.dart';

class PizzaLoadedWidget extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  const PizzaLoadedWidget({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: PizzaInfo(snapshot: snapshot, index: index),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PizzaInfo extends StatelessWidget {
  AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  int index;
  PizzaInfo({super.key, required this.snapshot, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        '/pizza_page',
        arguments: PizzaModel(
          title: snapshot.data!.docs[index]['title'],
          image: snapshot.data!.docs[index]['image'],
          description: snapshot.data!.docs[index]['description'],
          price: snapshot.data!.docs[index]['price'],
          sizeOfPizza: SizeOfPizza.little,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            snapshot.data!.docs[index]['image'],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            snapshot.data!.docs[index]['title'],
            style: titlteStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            snapshot.data!.docs[index]['description'],
            style: descriptionStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
                  child: Text(
                    'от ${snapshot.data!.docs[index]['price']}р',
                    style: menuPriseStyle,
                  ),
                ),
                decoration: BoxDecoration(
                    color: primeryLightColor,
                    borderRadius: BorderRadius.circular(24)),
              )
            ],
          )
        ],
      ),
    );
  }
}
