import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xffF6F6FA),
  primaryColor: const Color(0xFF265ccf),
  primaryColorLight: const Color(0xFF6F94E4),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  // fontFamily: GoogleFonts.poppins().fontFamily,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    color: Color(0xFF265ccf),
    titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  ),
  tabBarTheme: const TabBarTheme(labelColor: Colors.black),
  cardTheme: const CardTheme(color: Colors.white),
  iconTheme: const IconThemeData(color: Color(0xFF2E3033)),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Color(0xFF2E3033)),
    titleSmall: TextStyle(color: Color(0xFF757575)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.fromLTRB(26, 16, 4, 16),
    labelStyle: const TextStyle(
      color: Colors.grey,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: const TextStyle(
      color: Colors.grey,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: const TextStyle(
      color: Colors.grey,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: const TextStyle(
      color: Colors.redAccent,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    isDense: false,
    isCollapsed: false,
    prefixStyle: const TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: const TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: const TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: true,
    fillColor: Colors.grey[100],
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[100]!),
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[100]!),
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[100]!),
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    ),
  ),
);
