import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/style.dart';
import '../widgets/pizza_loaded_widget.dart';
import '../widgets/pizza_loading_widget.dart';
import '../widgets/stock_loaded_widget.dart';
import '../widgets/stock_loading_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 48,
          ),
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                width: 24,
              ),
              Text(
                "Акции",
                style: categoryNameStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),

          // ignore: prefer_const_constructors
          FutureBuilder(
            future: FirebaseFirestore.instance.collection('stock').get(),
            builder: (BuildContext contextStock,
                AsyncSnapshot<QuerySnapshot> snapshotStock) {
              if (snapshotStock.connectionState == ConnectionState.done) {
                return LoadedStock(snapshot: snapshotStock);
              }
              return LoadingStock();
            },
          ),

          const SizedBox(
            height: 24,
          ),

          Row(
            children: [
              const SizedBox(
                width: 24,
              ),
              Text(
                "Пицца",
                style: categoryNameStyle,
              ),
            ],
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance.collection('pizza').get(),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (snapshot.hasData) {
                return PizzaLoadedWidget(snapshot: snapshot);
              }
              return PizzaLoadingWidget();
            },
          ),
        ],
      ),
    );
  }
}
