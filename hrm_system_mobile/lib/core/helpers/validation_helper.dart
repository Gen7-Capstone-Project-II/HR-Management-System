import 'package:flutter/material.dart';
import 'package:human_resource_management_system/core/i18n/i18n_translation.dart';

Map<String, RegExp> uuidRegex = {
  '3': RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-3[0-9A-F]{3}-[0-9A-F]{4}-[0-9A-F]{12}$'),
  '4': RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$'),
  '5': RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-5[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$'),
  'all': RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$')
};

class ValidationHelper {
  /// If the value is null, empty, or contains only whitespace, then return a localized error message.
  /// Otherwise, return null
  ///
  /// Args:
  ///   [context] (BuildContext): The context of the widget that called the validation.
  ///   [value] (String): The value of the input field.
  static String? validateName(BuildContext context, String value) {
    if (value.isEmpty) {
      return I18NTranslations.of(context).text('Name is required.');
    }
    final RegExp nameExp = RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return I18NTranslations.of(context).text('Please enter only alphabetical characters.');
    }
    return null;
  }

  /// If the value is null, return a string that says "Country is required." Otherwise, return null
  ///
  /// Args:
  ///   [context] (BuildContext): The context of the widget that called the validation.
  ///   [value] (String): The value of the field.
  static String? validateCountry(BuildContext context, String value) {
    if (value.isEmpty) {
      return I18NTranslations.of(context).text('Country  is required.');
    }
    final RegExp nameExp = RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return I18NTranslations.of(context).text('Please enter only alphabetical characters.');
    }
    return null;
  }

  /// If the value is null, empty, or contains only whitespace, then return a localized error message.
  /// Otherwise, return null
  ///
  /// Args:
  ///   [context] (BuildContext): The context of the widget that is calling the validation function.
  ///   [value] (String): The value of the input field.
  static String? validateState(BuildContext context, String value) {
    if (value.isEmpty) {
      return I18NTranslations.of(context).text('State  is required.');
    }
    final RegExp nameExp = RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return I18NTranslations.of(context).text('Please enter only alphabetical characters.');
    }
    return null;
  }

  /// If the value is null, empty, or contains only whitespace, then return a localized error message.
  /// Otherwise, return null
  ///
  /// Args:
  ///   [context] (BuildContext): The context of the widget that called the validation.
  ///   [value] (String): The value of the field.
  static String? validateCity(BuildContext context, String value) {
    if (value.isEmpty) {
      return I18NTranslations.of(context).text('City  is required.');
    }
    final RegExp nameExp = RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return I18NTranslations.of(context).text('Please enter only alphabetical characters.');
    }
    return null;
  }

  /// If the value is null, return the string "Email can't be empty", otherwise return null
  ///
  /// Args:
  ///   [context] (BuildContext): The context of the widget that is calling the validation function.
  ///   [value] (String): The value of the input field.
  static String? validateEmail(BuildContext context, String value) {
    if (value.isEmpty) {
      return I18NTranslations.of(context).text('Email is required.');
    }
    final RegExp nameExp = RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');
    if (!nameExp.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  /// If the value is null, empty, or not a valid phone number, return an error message. Otherwise,
  /// return null
  ///
  /// Args:
  ///   [context] (BuildContext): The context of the widget that called the validation function.
  ///   [value] (String): The value of the field.
  static String? validatePhoneNumber(BuildContext context, String value) {
    if (value.isEmpty) {
      return I18NTranslations.of(context).text('Number is required.');
    }
    return null;
  }

  /// It validates the password.
  ///
  /// Args:
  ///   [context] (BuildContext): The context of the widget that is calling the validation function.
  ///   [value] (String): The value of the password field.
  ///   [isCurrentPass] (bool): If the password is the current password, set this to true.
  ///   [isNewPass] (bool): If the password is a new password, then this should be true.
  ///   [isCofirmPass] (bool): If the password is the confirm password field, then this should be true.
  ///   [newPass] (String): The new password that the user is trying to change to.
  static String? validatePassword(BuildContext context, String value, {bool? isCurrentPass, bool? isNewPass, bool? isCofirmPass, String? newPass}) {
    if (isCurrentPass == true) {
      if (value.isEmpty) {
        return I18NTranslations.of(context).text('message.require.current.password');
      }
    } else if (isNewPass == true) {
      if (value.isEmpty) {
        return I18NTranslations.of(context).text('message.require.new.password');
      }
    } else if (isCofirmPass == true) {
      if (value.isEmpty) {
        return I18NTranslations.of(context).text('message.require.new.password');
      } else {
        if (value != newPass) {
          return I18NTranslations.of(context).text('message.confirm.wrong.password');
        }
      }
    }
    return null;
  }

  /// If the value is null, empty, or not a valid address, return an error message. Otherwise, return
  /// null
  ///
  /// Args:
  ///   [context] (BuildContext): The context of the widget that called the validation.
  ///   [value] (String): The value of the input field.
  static String? validateAddress(BuildContext context, String value) {
    if (value.isEmpty) {
      return I18NTranslations.of(context).text('Address cannnot be Empty!.');
    }
    return null;
  }

  /// If the value is null, empty, or not a valid date, return an error message. Otherwise, return null
  ///
  /// Args:
  ///   [context] (BuildContext): The context of the widget that called the validation.
  ///   [value] (String): The value of the field.
  static String? validateDate(BuildContext context, String value) {
    if (value.isEmpty) {
      return 'Date is required.';
    }
    final RegExp nameExp = RegExp(r'^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$');
    if (!nameExp.hasMatch(value)) {
      return 'Date format should be dd-mm-yyyy.';
    }
    return null;
  }

  /// If the value is null or empty, return the message. Otherwise, return null
  ///
  /// Args:
  ///   [value] (String): The value to validate.
  ///   [message] (String): The error message to display if the value is null or empty.
  static String? validateEmptyText(String? value, String message) {
    if (value == null || value == "") {
      return message;
    }
    return null;
  }

  /// Returns true if the given string is a valid UUID.
  ///
  /// Args:
  ///   [uuidStr] (String): The string to check.
  ///   [version]: The version of the UUID to validate against. If no version is specified, any version is
  /// accepted.
  static bool isUUID(String uuidStr, [version]) {
    if (version == null) {
      version = 'all';
    } else {
      version = version.toString();
    }
    RegExp? pattern = uuidRegex[version];
    return (pattern != null && pattern.hasMatch(uuidStr.toUpperCase()));
  }
}
