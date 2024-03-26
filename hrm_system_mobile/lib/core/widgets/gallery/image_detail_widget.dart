import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// ignore: constant_identifier_names
enum EImageType { IMAGE_FILE, IMAGE_URL }

class ImageDetailWidget extends StatefulWidget {
  final List<File> imageFiles;
  final List<String> imageUrls;
  final String? defaultUrl;
  final File? defaultFile;
  final Function(int index)? onPressDelete;
  final EImageType imageType;

  const ImageDetailWidget({
    Key? key,
    required this.imageFiles,
    required this.imageUrls,
    required this.imageType,
    this.defaultUrl,
    this.defaultFile,
    this.onPressDelete,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ImageDetailWidget> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.defaultUrl != null && widget.defaultUrl != '') {
        currentIndex = widget.imageUrls.indexOf(widget.defaultUrl!);
      }
      if (widget.defaultFile != null) {
        currentIndex = widget.imageFiles.indexOf(widget.defaultFile!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _buildContent(context, widget.imageFiles, widget.imageUrls, widget.imageType),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 60.0,
                    height: 60.0,
                    child: RawMaterialButton(
                      padding: const EdgeInsets.all(0.0),
                      shape: const CircleBorder(),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            widget.onPressDelete != null
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 60.0,
                      height: 60.0,
                      child: RawMaterialButton(
                        shape: const CircleBorder(),
                        onPressed: () {
                          if (widget.onPressDelete != null) {
                            widget.onPressDelete!(currentIndex);
                          }
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<File> imageFiles, List<String> imageUrls, EImageType imageType) {
    return ExtendedImageGesturePageView.builder(
      itemBuilder: (BuildContext context, int index) {
        Widget image;
        switch (imageType) {
          case EImageType.IMAGE_FILE:
            image = ExtendedImage.file(imageFiles[index], fit: BoxFit.contain, mode: ExtendedImageMode.gesture, initGestureConfigHandler: (state) {
              return GestureConfig(inPageView: true, initialScale: 1.0, cacheGesture: false);
            });
            break;
          case EImageType.IMAGE_URL:
            image = ExtendedImage.network(imageUrls[index], fit: BoxFit.contain, mode: ExtendedImageMode.gesture, initGestureConfigHandler: (state) {
              return GestureConfig(inPageView: true, initialScale: 1.0, cacheGesture: false);
            });
            break;
        }
        image = Container(
          padding: const EdgeInsets.all(5.0),
          child: image,
        );
        if (index == currentIndex) {
          return Hero(
            tag: const Uuid().v1(),
            child: image,
          );
        } else {
          return image;
        }
      },
      itemCount: imageType == EImageType.IMAGE_FILE ? widget.imageFiles.length : widget.imageUrls.length,
      onPageChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      controller: ExtendedPageController(
        initialPage: currentIndex,
      ),
      scrollDirection: Axis.horizontal,
    );
  }
}
