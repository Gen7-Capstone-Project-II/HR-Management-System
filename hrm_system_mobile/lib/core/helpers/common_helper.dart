
// ignore_for_file: avoid_print

///
/// CommonHelper
///
class CommonHelper {

  /// If the object is of type T, return it, otherwise return the defaultFallback
  /// 
  /// Args:
  ///   [object] (dynamic): The object to try to cast.
  ///   [defaultFallback] (T): The value to return if the object is not of type T.
  static T? tryCast<T>(dynamic object, {T? defaultFallback}) {
    try {
      return (object as T);
    } on TypeError catch (e) {
      print('CastError $e when trying to cast $object to $T!');
      return defaultFallback;
    }
  }
}
