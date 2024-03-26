// // ignore_for_file: constant_identifier_names

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:human_resource_management_system/core/enums/enums.dart';
// import 'package:human_resource_management_system/core/i18n/i18n_translation.dart';

// class DialogWidget {
//   final BuildContext context;
//   final E_DIALOG_TYPE? dialogType;
//   final String? i18nTitle;
//   final Color? i18nTitleColor;
//   final String? desc;
//   final Widget? content;
//   final List<Widget>? buttons;
//   final Function? onDismiss;
//   final double? width;
//   final double? height;
//   final double? alertIconSize;
//   final bool? showDefaultDismissButton;

//   DialogWidget({
//     required this.context,
//     required this.dialogType,
//     this.i18nTitle,
//     this.i18nTitleColor,
//     this.desc,
//     this.content,
//     this.buttons,
//     this.onDismiss,
//     this.width = 400.0,
//     this.height = 320.0,
//     this.alertIconSize = 50.0,
//     this.showDefaultDismissButton = true,
//   });

//   Future<void> show() async {
//     return _buildDialog();
//   }

//   _buildDialog() {
//     showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return simpleCustomDialogStyle2(context);
//       },
//     );
//   }

//   Widget simpleCustomDialogStyle2(BuildContext context) {
//     if (kDebugMode) {
//       print(onDismiss.runtimeType);
//     }
//     List<Widget> _dialogColumnWidgets = <Widget>[];
//     _dialogColumnWidgets.add(
//       Column(
//         children: <Widget>[
//           Visibility(
//             visible: showDefaultDismissButton!,
//             child: Container(
//               alignment: Alignment.topRight,
//               padding: const EdgeInsets.all(8),
//               child: InkWell(
//                 onTap: () {
//                   if (onDismiss != null) {
//                     onDismiss!();
//                   } else {
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: const Icon(
//                   Typicons.cancel_circled,
//                   color: Colors.red,
//                   size: 26,
//                 ),
//               ),
//             ),
//           ),
//           (i18nTitle != null)
//               ? Center(
//                   child: Text(
//                     I18NTranslations.of(context).text(i18nTitle ?? ''),
//                     style: TextStyle(fontSize: 25, color: i18nTitleColor),
//                   ),
//                 )
//               : const SizedBox.shrink(),
//           (dialogType != null)
//               ? Center(
//                   child: Container(
//                     child: _getAlertTypeIcon(),
//                   ),
//                 )
//               : const SizedBox.shrink(),
//         ],
//       ),
//     );
//     if (content != null) {
//       if (i18nTitle != null) {
//         _dialogColumnWidgets.add(Container(
//           height: 12.0,
//         ));
//       }
//       _dialogColumnWidgets.add(content!);
//     }
//     _dialogColumnWidgets.add(_getDescription());
//     _dialogColumnWidgets.add(_getButtons());
//     Dialog simpleDialog = Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: SizedBox(
//         height: height,
//         width: width,
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: _dialogColumnWidgets,
//           ),
//         ),
//       ),
//     );
//     return simpleDialog;
//   }

//   Widget _getDescription() {
//     if (desc != null && desc != "") {
//       return Flexible(
//         child: SingleChildScrollView(
//           child: Text(
//             desc!,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 18, color: DialogWidgetConfiguration.SECONDARY_COLOR),
//           ),
//         ),
//       );
//     } else {
//       return const SizedBox.shrink();
//     }
//   }

//   Widget _getButtons() {
//     List<Widget> expandedButtons = [];
//     if (buttons != null) {
//       for (var button in buttons!) {
//         var buttonWidget = Padding(
//           padding: const EdgeInsets.only(left: 5, right: 5),
//           child: button,
//         );
//         if (buttons!.length == 1) {
//           expandedButtons.add(Expanded(child: buttonWidget));
//         } else {
//           expandedButtons.add(Expanded(
//             child: buttonWidget,
//           ));
//         }
//       }
//     }

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: expandedButtons,
//     );
//   }

//   Widget _getAlertTypeIcon() {
//     Widget widget;
//     switch (dialogType) {
//       case E_DIALOG_TYPE.ERROR:
//         widget = _icon(FontAwesome5.times_circle, _getColor());
//         break;
//       case E_DIALOG_TYPE.SUCCESS:
//         widget = _icon(FontAwesome5.check_circle, _getColor());
//         break;
//       case E_DIALOG_TYPE.INFO:
//         widget = _icon(FontAwesome5.info_circle, _getColor());
//         break;
//       case E_DIALOG_TYPE.WARNING:
//         widget = _icon(FontAwesome5.info_circle, _getColor());
//         break;
//       case E_DIALOG_TYPE.NONE:
//         widget = const SizedBox.shrink();
//         break;
//       default:
//         widget = const SizedBox.shrink();
//         break;
//     }

//     return widget;
//   }

//   Widget _icon(IconData icon, Color color) {
//     return Icon(
//       icon,
//       color: color,
//       size: alertIconSize,
//     );
//   }

//   Color _getColor() {
//     Color color;
//     switch (dialogType) {
//       case E_DIALOG_TYPE.ERROR:
//         color = const Color(0xffED5C4D);
//         break;
//       case E_DIALOG_TYPE.SUCCESS:
//         color = const Color(0XFF2DB94D);
//         break;
//       case E_DIALOG_TYPE.INFO:
//         color = const Color(0xff57B5ED);
//         break;
//       case E_DIALOG_TYPE.WARNING:
//         color = const Color(0xffFBBE4B);
//         break;
//       case E_DIALOG_TYPE.NONE:
//         color = const Color(0xff57B5ED);
//         break;
//       default:
//         color = const Color(0xff57B5ED);
//         break;
//     }
//     return color;
//   }
// }

// Widget dialogButtonWidget({String? dialogButtonTitle, Color? dialogButtonColor, Function? onTap}) {
//   return SizedBox(
//     child: Material(
//       elevation: 2,
//       borderRadius: BorderRadius.circular(40.0),
//       child: SizedBox(
//         width: double.infinity,
//         height: 40,
//         child: MaterialButton(
//           textColor: DialogWidgetConfiguration.WHITE_COLOR,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
//           color: dialogButtonColor,
//           onPressed: () => onTap!(),
//           child: Text(
//             dialogButtonTitle!,
//             style: const TextStyle(fontSize: 18),
//           ),
//         ),
//       ),
//     ),
//   );
// }

// /*
//  * 
//  */
// class DialogWidgetConfiguration {
//   static const PRIMARY_COLOR = Color(0XFF007BFF);
//   static const INFO_COLOR = Color(0XFF17A2B8);
//   static const ERROR_COLOR = Color(0XFFDC3545);
//   static const SUCCESS_COLOR = Color(0XFF28A745);
//   static const WARNING_COLOR = Color(0XFFFFC107);
//   static const SECONDARY_COLOR = Color(0XFF6C757D);
//   static const BLACK_COLOR = Color(0XFF333333);
//   static const WHITE_COLOR = Color(0XFFFFFFFF);

//   static Widget cancelButton({required BuildContext context, Function? onTap, String? cacenTitle}) {
//     return dialogButtonWidget(
//       dialogButtonTitle: cacenTitle ?? I18NTranslations.of(context).text("cancel"),
//       dialogButtonColor: DialogWidgetConfiguration.ERROR_COLOR,
//       onTap: () {
//         if (onTap != null) {
//           onTap();
//         } else {
//           Navigator.pop(context);
//         }
//       },
//     );
//   }

//   static Widget confirmButton({required BuildContext context, Function? onTap, String? confirmTitle}) {
//     return dialogButtonWidget(
//       dialogButtonTitle: confirmTitle ?? I18NTranslations.of(context).text("confirm"),
//       dialogButtonColor: DialogWidgetConfiguration.SUCCESS_COLOR,
//       onTap: () {
//         onTap!();
//       },
//     );
//   }
// }
