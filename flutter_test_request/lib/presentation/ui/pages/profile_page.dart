import 'package:flutter/material.dart';

import '../../../domain/style.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 48,
            ),
            Container(
              height: MediaQuery.of(context).size.width / 2.5,
              child: Image.asset(
                "assets/images/avatarka_low.jpg",
              ),
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(350)),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Привет, Даниил 🙂",
              style: titlteStyle.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: lightColor,
                // gradient: LinearGradient(
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,
                //     colors: [greyColor, lightColor]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "34",
                      style:
                          titlteStyle.copyWith(fontSize: 72, color: darkColor),
                    ),
                    Text(
                      "Счастливых дней с нами",
                      style: titlteStyle.copyWith(
                          fontSize: 18,
                          color: darkColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: primeryLightColor,
                    // gradient: LinearGradient(
                    //     begin: Alignment.topCenter,
                    //     end: Alignment.bottomCenter,
                    //     colors: [primeryLightColor, lightColor]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "73",
                          style: titlteStyle.copyWith(
                              fontSize: 72, color: primeryDarkColor),
                        ),
                        Text(
                          "Cъедено пицц",
                          style: titlteStyle.copyWith(
                              fontSize: 18,
                              color: primeryDarkColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: yellowLightColor
                      // gradient: LinearGradient(
                      //   begin: Alignment.bottomCenter,
                      //   end: Alignment.topCenter,
                      //   colors: [yellowLightColor, lightColor],
                      // ),
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "∞",
                          style: titlteStyle.copyWith(
                            fontSize: 72,
                            color: yellowDarkColor,
                          ),
                        ),
                        Text(
                          "Полученных эмоций",
                          style: titlteStyle.copyWith(
                            fontSize: 18,
                            color: yellowDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: lightColor,
                // gradient: LinearGradient(
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,
                //     colors: [greyColor, lightColor]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "61",
                      style:
                          titlteStyle.copyWith(fontSize: 72, color: darkColor),
                    ),
                    Text(
                      "Пицц на доставку",
                      style: titlteStyle.copyWith(
                          fontSize: 18,
                          color: darkColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
