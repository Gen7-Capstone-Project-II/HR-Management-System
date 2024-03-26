import 'package:flutter/cupertino.dart';
import 'package:human_resource_management_system/core/i18n/i18n_translation.dart';

///
/// [GenderHelper]
///
class GenderHelper {
  /// If the gender is null, return male, otherwise return the string "Male" if
  /// the gender is 1, or return the string "Female"
  ///
  /// Args:
  ///   [context] (BuildContext): The context of the widget that is calling this method.
  ///   [gender] (int): The gender to get the description for.
  static String getGenderDescription(BuildContext context, int? gender) {
    String genderDescription = I18NTranslations.of(context).text('male');
    if (gender != null && gender != 1) {
      genderDescription = I18NTranslations.of(context).text('female');
    }
    return genderDescription;
  }
}
