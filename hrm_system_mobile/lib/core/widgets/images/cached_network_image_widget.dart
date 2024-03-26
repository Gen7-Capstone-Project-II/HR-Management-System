import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:human_resource_management_system/core/consts/asset_const.dart';
import 'package:human_resource_management_system/core/helpers/custom_cache_manager_helper.dart';

/*
 * CacheNetworkImageWidget
 */
class CacheNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final BoxShape? boxShape;

  const CacheNetworkImageWidget(this.imageUrl, {Key? key, this.width = 30.0, this.height = 30.0, this.boxFit = BoxFit.fitHeight, this.boxShape = BoxShape.rectangle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: CustomCacheManager(),
      imageUrl: imageUrl,
      imageBuilder: (BuildContext context, ImageProvider imageProvider) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: boxShape!,
            image: DecorationImage(fit: boxFit, image: imageProvider),
          ),
        );
      },
      placeholder: (context, imageUrl) => _placeHolderWidget(AssetConst.IMG_PLACEHOLDER, width!, height!, boxFit!),
      errorWidget: (context, imageUrl, error) => _placeHolderWidget(AssetConst.IMG_PLACEHOLDER, width!, height!, boxFit!),
    );
  }

  /*
   * 
   */
  Widget _placeHolderWidget(String placeholder, double width, double height, BoxFit boxFit) {
    return Container(
      height: width,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(shape: boxShape!),
      child: Image.asset(placeholder, width: width, height: height, fit: boxFit),
    );
  }
}
