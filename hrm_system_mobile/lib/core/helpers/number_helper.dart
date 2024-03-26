
///
/// [NumberHelper]
///
class NumberHelper {

  /// It takes a string, and returns an integer
  /// 
  /// [Args:
  ///   [version] (String): The version of the package to be installed.
  static int versionToNumber(String? version) {
    if (version != null && version != '') {
      String value = version.replaceAll(".", "").trim();
      return int.parse(value);
    }
    return 0;
  }
  
  /// Convert a string to an integer.
  /// 
  /// Args:
  ///   [str] (String): The string to convert to an integer.
  static int stringToInt(String? str) {
    final RegExp nameExp = RegExp(r'^[a-zA-Z ]+$');
    if (str != null || str != "" || !nameExp.hasMatch(str!)) {
      return int.parse(str!);
    }
    return 0;
  }
}
