import 'package:flutter/material.dart';
import 'package:human_resource_management_system/core/theme/theme.dart';

InputDecoration loginTextField = InputDecoration(
  fillColor: const Color(0xffEEEEEE),
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: appTheme.primaryColor,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.white,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
);

ButtonStyle rectangleButton = ButtonStyle(
  elevation: MaterialStateProperty.all<double>(0.0),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  ),
);
