import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoadedStock extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  const LoadedStock({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              const SizedBox(
                width: 24,
              ),
              InkWell(
                onTap: (() => Navigator.of(context).pushNamed('/story_page')),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    snapshot.data!.docs[index]['image'],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              index == snapshot.data!.docs.length - 1
                  ? const SizedBox(
                      width: 24,
                    )
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
