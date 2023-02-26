import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const color_primary = Colors.blue;
const colorDark_bg = Colors.black;
const colorDark_primary = Color(0xFFd9fd41);
const colorDark_red = Color(0xFFff6b41);
const colorDark_white = Colors.white;

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
);

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      shadowColor: Colors.black.withOpacity(0),
      backgroundColor: Colors.black.withOpacity(0),
    ),
    brightness: Brightness.dark,
    primaryColor: colorDark_primary,
    scaffoldBackgroundColor: colorDark_bg,
    backgroundColor: colorDark_bg,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(colorDark_primary),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        )),
      ),
    ),
    textTheme: GoogleFonts.openSansTextTheme(),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.grey.shade900,
      iconColor: Colors.red,
      titleTextStyle: GoogleFonts.openSans(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    ));
