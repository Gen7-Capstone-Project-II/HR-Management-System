// import 'package:flutter/material.dart';
// import 'package:human_resource_management_system/core/consts/app_const.dart';
// import 'package:human_resource_management_system/core/consts/asset_const.dart';
// import 'package:human_resource_management_system/core/enums/enums.dart';
// import 'package:human_resource_management_system/core/helpers/ui_helper.dart';
// import 'package:human_resource_management_system/core/stores/setting/setting_store.dart';
// import 'package:human_resource_management_system/core/widgets/dialogs/dialog_widget.dart';

// class ChooseLanguageDialog {
//   static Widget currentLanguageIcon(SettingStore store, {double width = 50, double height = 25}) {
//     return SizedBox(
//       child: Image.asset(
//         _getFlag(store),
//         fit: BoxFit.cover,
//         width: width,
//         height: height,
//       ),
//     );
//   }

//   static String _getFlag(SettingStore store) {
//     String flag = AssetConst.IMG_CAMBODIA_FLAG_JPG;
//     if (store.locale == 'en') {
//       flag = AssetConst.IMG_UNITED_KINGDOM_FLAG_JPG;
//     } else if (store.locale == 'zh') {
//       flag = AssetConst.IMG_CHINA_FLAG_PNG;
//     }

//     return flag;
//   }

//   static void open(BuildContext context, SettingStore store) {
//     DialogWidget(
//       height: 280,
//       context: context,
//       dialogType: E_DIALOG_TYPE.NONE,
//       i18nTitle: "message.select.language",
//       content: Expanded(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildColumnLanguageChoice(
//                   flagImage: AssetConst.IMG_CAMBODIA_FLAG_JPG,
//                   languageTitle: "ភាសាខ្មែរ",
//                   visible: store.locale == AppConst.DEFAULT_LANGUAGE,
//                   onTap: () {
//                     store.changeLanguage("km");
//                     Navigator.pop(context);
//                   },
//                 ),
//                 UIHelper.horizontalSpace(30),
//                 _buildColumnLanguageChoice(
//                   flagImage: AssetConst.IMG_UNITED_KINGDOM_FLAG_JPG,
//                   languageTitle: "English",
//                   visible: store.locale == 'en',
//                   onTap: () {
//                     store.changeLanguage("en");
//                     Navigator.pop(context);
//                   },
//                 ),
//                 UIHelper.horizontalSpace(30),
//                 _buildColumnLanguageChoice(
//                   flagImage: AssetConst.IMG_CHINA_FLAG_PNG,
//                   languageTitle: "中国人",
//                   visible: store.locale == 'zh',
//                   onTap: () {
//                     store.changeLanguage("zh");
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ).show();
//   }

//   static Widget _buildColumnLanguageChoice({required String flagImage, required String languageTitle, required bool visible, required void Function() onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Column(
//         children: [
//           SizedBox(
//             width: 50,
//             height: 45,
//             child: Image.asset(
//               flagImage,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Text(languageTitle),
//           Visibility(
//             visible: visible,
//             child: Icon(Icons.check_circle, color: Colors.lightBlue[300]),
//           ),
//         ],
//       ),
//     );
//   }
// }
