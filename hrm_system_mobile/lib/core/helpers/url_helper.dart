import 'package:human_resource_management_system/core/consts/app_const.dart';
import 'package:human_resource_management_system/core/services/http/http_config.dart';

///
/// [URLHelper]
///
class URLHelper {
  /// If the photoUrl is null, return the default image, otherwise return the photoUrl
  ///
  /// Args:
  ///   [photoUrl] (String): The URL of the photo to be displayed.
  static String getImageUrl(String? photoUrl) {
    String baseUrl = "${HttpConfig.getInstance().getBaseUrl()}/";
    final regex = RegExp(r'^storage');

    if (photoUrl != null && photoUrl != '') {
      if (!regex.hasMatch(photoUrl)) {
        photoUrl = "storage/$photoUrl";
      }
    }

    return AppConst.APP_PRODUCTION_MODE ? baseUrl + (photoUrl ?? '') : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzp1HbkI2ZCN60HwQKR35teN7mdA1ruNeLl0UApRv7oXBcIUDskOEEzGCDuWpp0TTJoHs&usqp=CAU";
  }
}
