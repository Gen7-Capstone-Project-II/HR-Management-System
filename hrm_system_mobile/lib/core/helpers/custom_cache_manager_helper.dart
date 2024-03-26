
// ignore: depend_on_referenced_packages
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// 
/// [CacheManagerHelper]
/// caching object: e.g. image network for 2 minutes
/// 
class CustomCacheManager extends CacheManager {
  static const key = "customCache";

  static final Config _config = Config(
    key,
    stalePeriod: const Duration(minutes: 2),
    maxNrOfCacheObjects: 20
  );

  CustomCacheManager() : super(_config);
}