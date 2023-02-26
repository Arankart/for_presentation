import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primeryColor = Color(0xFF5D50EB);
final Color profileColor = Color(0xFF50EBCF);
final Color yellowColor = Color(0xFFEBD250);

final Color primeryDarkColor = Color(0xFF2D1FCE);
final Color profileDarkColor = Color(0xFF1FCEAF);
final Color yellowDarkColor = Color(0xFFCEB21F);

Color primeryLightColor = Color(0xFFEFEEF9);
final Color profileLightColor = Color(0xFFEBFCF7);
final Color yellowLightColor = Color(0xFFFCFAEC);

final Color lightColor = Colors.grey.shade100;
final Color greyColor = Colors.grey.shade200;
final Color greyDarkColor = Colors.grey.shade400;

final Color darkColor = Colors.black;

final TextStyle labelAppStyle =
    GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600);

final TextStyle categoryNameStyle =
    GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w600);

final TextStyle titlteStyle =
    GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w500);

final TextStyle descriptionStyle =
    GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w400);

final TextStyle menuPriseStyle = GoogleFonts.montserrat(
    fontSize: 24, fontWeight: FontWeight.w600, color: primeryDarkColor);

final TextStyle chipStyle = GoogleFonts.montserrat(
    fontSize: 16, fontWeight: FontWeight.w500, color: darkColor);

final TextStyle buttonStyle = GoogleFonts.montserrat(
    fontSize: 16, fontWeight: FontWeight.w600, color: lightColor);

final BoxDecoration bagBoxDecoration = BoxDecoration(
  color: lightColor,
  borderRadius: BorderRadius.all(Radius.circular(24)),
);

final ButtonStyle buttonStyleOrder = ButtonStyle(
  shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.04)),
  backgroundColor: MaterialStateProperty.all(primeryColor),
);
