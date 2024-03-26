// // ignore_for_file: constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:human_resource_management_system/core/i18n/i18n_translation.dart';
// import 'package:human_resource_management_system/core/stores/setting/setting_store.dart';
// import 'package:human_resource_management_system/core/utils/page_navaigator_utils.dart';
// import 'package:human_resource_management_system/core/widgets/gallery/image_detail_widget.dart';
// import 'package:human_resource_management_system/core/widgets/images/cached_network_image_widget.dart';
// import 'package:path/path.dart' as path;

// import 'ui_helper.dart';

// const List<String> FILE_DOC_EXT = ['doc', 'docx', 'odt', 'ods', 'odp'];
// const List<String> FILE_EXCEL_EXT = ['xls', 'xlsx', 'csv'];
// const List<String> FILE_POWER_POINT_EXT = ['ppt', 'pptx'];
// const List<String> FILE_IMAGE_EXT = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
// const List<String> FILE_PDF_EXT = ['pdf'];
// const List<String> FILE_AUDIO_EXT = ['wav', 'mp3'];

// const List<String> ALLOW_FILE_UPLOAD_EXT = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'odt', 'ods', 'odp'];

// class FileInfo {
//   Color color;
//   IconData iconData;
//   String label;
//   FileInfo({required this.color, required this.label, required this.iconData});
// }

// class FileHelper {
//   /// It returns the file extension of a file path
//   ///
//   /// Args:
//   ///   [filePath] (String): The path of the file.
//   static String getFileExtension(String filePath) {
//     String fileName = path.basename(filePath);
//     String fileExtension = path.extension(fileName);
//     return fileExtension;
//   }

//   /// It checks if the file name contains any of the file extensions in the list
//   ///
//   /// Args:
//   ///   [fileName] (String): The name of the file to be checked.
//   static bool isContainAnyFileExtensions(String fileName) {
//     String fileExtension = path.extension(fileName);
//     fileExtension = fileExtension.replaceAll(".", "");
//     return FILE_AUDIO_EXT.contains(fileExtension) ||
//         FILE_IMAGE_EXT.contains(fileExtension) ||
//         FILE_DOC_EXT.contains(fileExtension) ||
//         FILE_EXCEL_EXT.contains(fileExtension) ||
//         FILE_POWER_POINT_EXT.contains(fileExtension) ||
//         FILE_PDF_EXT.contains(fileExtension);
//   }

//   /// It checks if the file extension is an image file extension.
//   ///
//   /// Args:
//   ///   [fileExtension] (String): The file extension of the file you want to check.
//   static bool isFileImage(String fileExtension) {
//     return isAllowFileExtension(FILE_IMAGE_EXT, fileExtension.trim().toLowerCase());
//   }

//   /// It checks if the file extension is pdf.
//   ///
//   /// Args:
//   ///   [fileExtension] (String): The file extension of the file you want to check.
//   static bool isFilePdf(String fileExtension) {
//     return isAllowFileExtension(FILE_PDF_EXT, fileExtension.trim().toLowerCase());
//   }

//   ///
//   ///
//   /// Args:
//   ///   [listExtension] (List<String>): List of file extensions that are allowed to be uploaded
//   ///   [fileExtension] (String): The file extension to be checked.
//   static bool isAllowFileExtension(List<String> listExtension, String fileExtension) {
//     fileExtension = fileExtension.replaceAll(".", "");
//     return listExtension.contains(fileExtension.trim().toLowerCase());
//   }

//   /// It returns a FileInfo object with the file extension, the file icon,
//   /// and the file color
//   ///
//   /// Args:
//   ///   [context] (BuildContext): The context of the widget that is calling this method.
//   ///   [fileExtension] (String): The file extension of the file you want to get the icon for.
//   static FileInfo getFileInfo(BuildContext context, String fileExtension) {
//     Color color;
//     IconData? iconData;
//     String label;

//     fileExtension = fileExtension.replaceAll(".", "");

//     if (FILE_AUDIO_EXT.contains(fileExtension)) {
//       iconData = Icons.volume_up;
//       color = Colors.orange[800]!;
//       label = I18NTranslations.of(context).text("audio");
//     } else if (FILE_IMAGE_EXT.contains(fileExtension)) {
//       iconData = Icons.filter;
//       color = Colors.green;
//       label = I18NTranslations.of(context).text("image");
//     } else if (FILE_DOC_EXT.contains(fileExtension)) {
//       iconData = Icons.file_present_rounded;
//       color = Colors.blue;
//       label = I18NTranslations.of(context).text("file");
//     } else if (FILE_EXCEL_EXT.contains(fileExtension)) {
//       // iconData = FontAwesome.file_excel;
//       color = Colors.green;
//       label = I18NTranslations.of(context).text("file");
//     } else if (FILE_POWER_POINT_EXT.contains(fileExtension)) {
//       // iconData = FontAwesome.file_powerpoint;
//       color = Colors.orange[800]!;
//       label = I18NTranslations.of(context).text("file");
//     } else if (FILE_PDF_EXT.contains(fileExtension)) {
//       // iconData = FontAwesome.file_pdf;
//       color = Colors.red;
//       label = I18NTranslations.of(context).text("file");
//     } else {
//       // iconData = FontAwesome.doc;
//       color = Colors.grey;
//       label = I18NTranslations.of(context).text("file");
//     }
//     return FileInfo(label: label, color: color, iconData: iconData!);
//   }

//   /// It shows the attachment icon.
//   ///
//   /// Args:
//   ///   [context] (BuildContext): The context of the widget that calls this function.
//   ///   [fileName] (String): The name of the file to be displayed.
//   ///   [iconSize] (double): The size of the icon. Defaults to 17
//   ///   [fontSize] (double): The size of the font used to display the file name. Defaults to 12
//   static Widget showAttachementIcon({required BuildContext context, required String fileName, double iconSize = 17, double fontSize = 12}) {
//     String extension = path.extension(fileName).toLowerCase();
//     FileInfo fileInfo = getFileInfo(context, extension);
//     return UIHelper.item(context: context, fileName: fileName, label: fileInfo.label, icon: fileInfo.iconData, color: fileInfo.color, iconSize: iconSize, fontSize: fontSize);
//   }

//   /// It shows an attachment with an action.
//   ///
//   /// Args:
//   ///   [context] (BuildContext): The context of the widget.
//   ///   [store] (SettingStore): The settingstore of the app
//   ///   [fileName] (String): The name of the file to be displayed
//   ///   [fileUrl] (String): The url of the file to be downloaded
//   ///   [imageSize] (double): The size of the image to be displayed. Defaults to 50
//   ///   [iconSize] (double): The size of the icon that will be displayed. Defaults to 25
//   static Widget showAttachementWithAction({required BuildContext context, required SettingStore store, required String fileName, required String fileUrl, double imageSize = 50, double iconSize = 25}) {
//     String extension = path.extension(fileName).toLowerCase();
//     if (FileHelper.isAllowFileExtension(FILE_AUDIO_EXT, extension)) {
//       return Container();
//     } else {
//       FileInfo fileInfo = getFileInfo(context, extension);
//       bool isImage = FileHelper.isFileImage(extension);

//       Widget fileIconItem;
//       if (isImage) {
//         fileIconItem = CacheNetworkImageWidget(
//           fileUrl,
//           height: imageSize,
//           width: imageSize,
//           boxFit: BoxFit.cover,
//         );
//       } else {
//         fileIconItem = Icon(fileInfo.iconData, size: iconSize, color: fileInfo.color);
//       }
//       return InkWell(
//         onTap: () {
//           if (isImage) {
//             pushWidgetWithFade(context, ImageDetailWidget(imageFiles: const [], imageUrls: [fileUrl], imageType: EImageType.IMAGE_URL));
//           } else {
//             // pushWidgetWithFade(context, PDFViewerScreen(store, fileName, fileUrl));
//           }
//         },
//         child: Builder(
//           builder: (context) {
//             if (isImage) {
//               return fileIconItem;
//             } else {
//               return Row(
//                 children: <Widget>[
//                   fileIconItem,
//                   Expanded(
//                       child: Text(
//                     fileName,
//                     overflow: TextOverflow.ellipsis,
//                   ))
//                 ],
//               );
//             }
//           },
//         ),
//       );
//     }
//   }
// }
