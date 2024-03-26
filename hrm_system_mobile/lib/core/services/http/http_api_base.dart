/*
 * 
 */

abstract class HttpApiBase {
  bool isProduction = false;

  HttpApiBase(this.isProduction);

  Map<String, dynamic> getConfigPreference() {
    if (!isProduction) {
      return getDevelopmentConfigPreference();
    }
    return getProductionConfigPreference();
  }

  Map<String, dynamic> getProductionConfigPreference();
  Map<String, dynamic> getDevelopmentConfigPreference();
}
