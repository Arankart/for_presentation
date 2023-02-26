import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingStock extends StatelessWidget {
  const LoadingStock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Row(
            children: [
              const SizedBox(
                width: 24,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.white,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 200,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              index == 5 - 1
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
