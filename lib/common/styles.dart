import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Color(0xFFF6F8FA);
Color darkPrimaryColor = Color(0xFF191720);
Color secondaryColor = Color(0xFF4d6dd9);
Color whiteBackground = Color(0xFFF2F4F6);
Color greyButton = Color(0xFF1E1C24);
Color greyOutline = Color(0xFF3B3A42);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.25,
    color: secondaryColor),
  headline2: GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.25,
    color: darkPrimaryColor),
  headline3: GoogleFonts.poppins(
    fontSize: 23,
    fontWeight: FontWeight.bold,
    color: primaryColor),
  headline4: GoogleFonts.poppins(
    fontSize: 21,
    fontWeight: FontWeight.bold,
    color: primaryColor),
  headline5: GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: darkPrimaryColor),
  headline6: GoogleFonts.rubik(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: primaryColor,
      letterSpacing: 0.15),
  subtitle1: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: darkPrimaryColor),
  subtitle2: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1,
      color: primaryColor),
  bodyText1: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: darkPrimaryColor,
      letterSpacing: 0.5),
  bodyText2: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white),
);

final themeData = ThemeData(
  textTheme: myTextTheme,
  primaryColor: primaryColor,
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        primary: secondaryColor,
        textStyle: TextStyle(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)))),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: secondaryColor,
    unselectedItemColor: Colors.grey,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.amber,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: greyOutline),
      borderRadius: BorderRadius.circular(12),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: Colors.red),
      borderRadius: BorderRadius.circular(12),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: greyOutline, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: primaryColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: Colors.red, width: 2.0),
    ),
  ),
);
