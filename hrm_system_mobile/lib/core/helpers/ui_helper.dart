// // ignore_for_file: constant_identifier_names

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:human_resource_management_system/core/consts/asset_const.dart';
// import 'package:human_resource_management_system/core/i18n/i18n_translation.dart';
// import 'package:human_resource_management_system/core/widgets/dialogs/dialog_widget.dart';
// import 'package:human_resource_management_system/core/widgets/dialogs/progress_dialog.dart';
// import 'package:lottie/lottie.dart';
// import '../enums/enums.dart';
// import 'custom_cache_manager_helper.dart';

// ///
// /// [UIHelper] Contains useful functions to reduce boilerplate code
// ///
// class UIHelper {
//   /// Vertical spacing constants. Adjust to your liking.
//   static const double _VerticalSpaceSmall = 10.0;
//   static const double _VerticalSpaceMedium = 20.0;
//   static const double _VerticalSpaceLarge = 60.0;

//   /// Vertical spacing constants. Adjust to your liking.
//   static const double _HorizontalSpaceSmall = 10.0;
//   static const double _HorizontalSpaceMedium = 20.0;
//   static const double HorizontalSpaceLarge = 60.0;

//   /// Returns a vertical space with height set to [_VerticalSpaceSmall]
//   static Widget verticalSpaceSmall() {
//     return verticalSpace(_VerticalSpaceSmall);
//   }

//   /// Returns a vertical space with height set to [_VerticalSpaceMedium]
//   static Widget verticalSpaceMedium() {
//     return verticalSpace(_VerticalSpaceMedium);
//   }

//   /// Returns a vertical space with height set to [_VerticalSpaceLarge]
//   static Widget verticalSpaceLarge() {
//     return verticalSpace(_VerticalSpaceLarge);
//   }

//   /// Returns a vertical space equal to the [height] supplied
//   static Widget verticalSpace(double height) {
//     return Container(height: height);
//   }

//   /// Returns a vertical space with height set to [_HorizontalSpaceSmall]
//   static Widget horizontalSpaceSmall() {
//     return horizontalSpace(_HorizontalSpaceSmall);
//   }

//   /// Returns a vertical space with height set to [_HorizontalSpaceMedium]
//   static Widget horizontalSpaceMedium() {
//     return horizontalSpace(_HorizontalSpaceMedium);
//   }

//   /// Returns a vertical space with height set to [HorizontalSpaceLarge]
//   static Widget horizontalSpaceLarge() {
//     return horizontalSpace(HorizontalSpaceLarge);
//   }

//   /// Returns a vertical space equal to the [width] supplied
//   static Widget horizontalSpace(double width) {
//     return Container(width: width);
//   }

//   /// Returns CachedNetworkImage with default Placeholder
//   static Widget cachedNetworkImage(String imageUrl, int gender, double width, double height) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10.0),
//         child: CachedNetworkImage(
//           cacheManager: CustomCacheManager(),
//           height: 40,
//           imageUrl: imageUrl,
//           imageBuilder: (context, imageProvider) => Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: imageProvider,
//                 fit: BoxFit.fitHeight,
//               ),
//             ),
//           ),
//           placeholder: (context, url) => Image.asset(
//             gender == 0 ? AssetConst.IMG_MALE_PLACEHOLDER : AssetConst.IMG_FEMALE_PLACEHOLDER,
//             height: height,
//           ),
//           errorWidget: (context, url, error) => Image.asset(
//             gender == 0 ? AssetConst.IMG_MALE_PLACEHOLDER : AssetConst.IMG_FEMALE_PLACEHOLDER,
//             height: height,
//           ),
//         ),
//       ),
//     );
//   }

//   ///
//   static showConfirmDialog(BuildContext context, E_DIALOG_TYPE type, String title, String desc, Function? cancelAction, Function confirmAction) {
//     return DialogWidget(
//       context: context,
//       dialogType: type,
//       i18nTitle: title,
//       desc: desc,
//       buttons: [
//         DialogWidgetConfiguration.cancelButton(
//             context: context,
//             onTap: () {
//               if (cancelAction != null) {
//                 cancelAction();
//               }
//               Navigator.pop(context);
//             }),
//         DialogWidgetConfiguration.confirmButton(
//           context: context,
//           onTap: () {
//             confirmAction();
//           },
//         ),
//       ],
//     ).show();
//   }

//   ///
//   static showSuccessDialog(BuildContext context, String i18nMessage) {
//     // DialogWidget(
//     //   context: context,
//     //   dialogType: E_DIALOG_TYPE.SUCCESS,
//     //   i18nTitleColor: DialogWidgetConfiguration.SUCCESS_COLOR,
//     //   i18nTitle: "message.info",
//     //   desc: I18NTranslations.of(context).text(i18nMessage),
//     // ).show();
//   }

//   ///
//   static showInfoDialog(BuildContext context, String i18nMessage) {
//     // DialogWidget(
//     //   context: context,
//     //   dialogType: E_DIALOG_TYPE.INFO,
//     //   i18nTitleColor: DialogWidgetConfiguration.PRIMARY_COLOR,
//     //   i18nTitle: "message.info",
//     //   desc: I18NTranslations.of(context).text(i18nMessage),
//     // ).show();
//   }

//   ///
//   static showWarningDialog(BuildContext context, String i18nMessage) {
//     DialogWidget(
//       context: context,
//       dialogType: E_DIALOG_TYPE.WARNING,
//       i18nTitleColor: DialogWidgetConfiguration.WARNING_COLOR,
//       i18nTitle: "message.info",
//       desc: I18NTranslations.of(context).text(i18nMessage),
//     ).show();
//   }

//   ///
//   static showErrorDialog(BuildContext context, String? i18nMessage, {String message = ''}) {
//     DialogWidget(
//       context: context,
//       dialogType: E_DIALOG_TYPE.ERROR,
//       i18nTitleColor: DialogWidgetConfiguration.ERROR_COLOR,
//       i18nTitle: "message.info",
//       desc: i18nMessage != null ? I18NTranslations.of(context).text(i18nMessage) : message,
//     ).show();
//   }

//   ///
//   static showWorkUnderDevelopmentDialog(BuildContext context) {
//     DialogWidget(
//       context: context,
//       dialogType: E_DIALOG_TYPE.INFO,
//       i18nTitleColor: DialogWidgetConfiguration.PRIMARY_COLOR,
//       i18nTitle: "message.info",
//       desc: I18NTranslations.of(context).text("message.show.work.under.development"),
//     ).show();
//   }

//   /// It shows a loading dialog while a task is running, and then closes the dialog and calls a callback
//   /// when the task is completed
//   ///
//   /// Args:
//   ///   [context] (BuildContext): The context of the widget that will be used to show the dialog.
//   ///   [message] (String): The message to show in the dialog.
//   ///   [task] (Future<T>): The task to be executed.
//   ///   [onCompleted] (Function(T result)): This is the function that will be called when the task is completed.
//   ///   [onError] (Function(dynamic error)): This is a function that will be called if the task fails.
//   static showLazyLoadingDialog<T>(BuildContext context, {String? message, required Future<T> task, required Function(T result) onCompleted, required Function(dynamic error) onError}) {
//     ProgressDialog prDialog = ProgressDialog(context, ProgressDialogType.Normal);
//     prDialog.setMessage(message ?? I18NTranslations.of(context).text("message.please.wait"));
//     prDialog.show();

//     task.then((T value) {
//       Future.delayed(Duration.zero, () {
//         prDialog.hide();
//         onCompleted(value);
//       });
//     }).catchError((error) {
//       prDialog.hide();
//       onError(error);

//       DialogWidget(
//         context: context,
//         dialogType: E_DIALOG_TYPE.ERROR,
//         i18nTitle: "message.info",
//         desc: I18NTranslations.of(context).textLocale(error.message, error.messageEn),
//       ).show();
//     });
//   }

//   /// It takes a task, executes it, and then calls either onCompleted or onError depending on the result
//   ///
//   /// Args:
//   ///   [context] (BuildContext): The BuildContext of the widget that is calling this method.
//   ///   [message] (String): The message to show in the progress dialog.
//   ///   [task] (Future<T>): The task to be executed.
//   ///   [onCompleted] (Function(T result)): This is the function that will be called when the task is completed successfully.
//   ///   [onError] (Function(dynamic error)): This is a function that will be called if the task fails.
//   static executeTask<T>(BuildContext context, {String? message, required Future<T> task, required Function(T result) onCompleted, required Function(dynamic error) onError}) {
//     task.then((T value) {
//       Future.delayed(Duration.zero, () {
//         onCompleted(value);
//       });
//     }).catchError((error) {
//       onError(error);
//       DialogWidget(
//         context: context,
//         dialogType: E_DIALOG_TYPE.ERROR,
//         i18nTitle: "message.info",
//         desc: I18NTranslations.of(context).textLocale(error.message, error.messageEn),
//       ).show();
//     });
//   }

//   ///
//   static Widget buildFormLayout({required Widget label, required Widget input, bool isExpanded = true, bool isInline = true}) {
//     return Container(
//       decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey[300]!))),
//       padding: const EdgeInsets.only(top: 3, bottom: 3),
//       child: isInline
//           ? Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 const SizedBox(width: 3),
//                 label,
//                 const SizedBox(width: 5),
//                 const Text("  "),
//                 const SizedBox(width: 5),
//                 isExpanded ? Expanded(child: input) : input,
//               ],
//             )
//           : Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     const SizedBox(width: 3),
//                     label,
//                     const SizedBox(width: 5),
//                     const Text("  "),
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 input,
//               ],
//             ),
//     );
//   }

//   ///
//   static Widget item({required BuildContext context, required IconData icon, required Color color, required String fileName, required String label, double iconSize = 18, double fontSize = 12}) {
//     return Row(
//       children: <Widget>[
//         Icon(icon, size: iconSize, color: color),
//         UIHelper.horizontalSpace(8),
//         Expanded(
//           child: Text(
//             label,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(color: color, fontSize: fontSize),
//           ),
//         ),
//       ],
//     );
//   }

//   ///
//   static Widget emptyWidget({required BuildContext context, double height = double.infinity}) {
//     return Container(
//       margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
//       height: height,
//       child: ListView(
//         children: <Widget>[
//           Lottie.asset(AssetConst.ANIM_LOTTIE_EMPTYBOX, height: 180, width: 180, repeat: false),
//           UIHelper.verticalSpaceMedium(),
//           Column(
//             children: <Widget>[
//               Text(
//                 I18NTranslations.of(context).text('message.empty.screen'),
//                 style: const TextStyle(fontSize: 18),
//               ),
//               UIHelper.verticalSpace(8),
//               Text(
//                 I18NTranslations.of(context).text('message.thank.you'),
//                 style: const TextStyle(fontSize: 18),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   ///
//   static Widget customeRaisedButton({
//     required BuildContext context,
//     required String text,
//     required void Function() onPressed,
//     double? radius,
//     Color textColor = Colors.white,
//     Color buttonColor = Colors.blue,
//   }) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: buttonColor,
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 0)),
//         ),
//         onPressed: onPressed,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               text,
//               style: const TextStyle(fontSize: 16, color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ///
//   static Widget buildHeader({
//     required BuildContext context,
//     required Color backgroundColor,
//     required Color bgColor1,
//     required Color bgColor2,
//     required Color bgColor3,
//     required String title,
//     String? subTitle,
//     bool showSearch = false,
//     double height = 160,
//     Function? btnSearchClick,

//     /// when subTitle is empty
//     Widget childSubtitle = const SizedBox.shrink(),

//     /// override back button
//     Widget? customBackButton = const SizedBox.shrink(),

//     /// override search button
//     Widget customSearchButton = const SizedBox.shrink(),
//   }) {
//     double width = MediaQuery.of(context).size.width;
//     return ClipRRect(
//       borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
//       child: Container(
//         height: height,
//         width: width,
//         decoration: BoxDecoration(
//           color: backgroundColor,
//         ),
//         child: Stack(
//           fit: StackFit.expand,
//           alignment: Alignment.center,
//           children: <Widget>[
//             Positioned(top: 30, right: -100, child: circularContainer(300, bgColor1)),
//             Positioned(top: -100, left: -45, child: circularContainer(width * .5, bgColor2)),
//             Positioned(
//               top: -180,
//               right: -30,
//               child: circularContainer(width * .7, bgColor3, borderColor: Colors.white38),
//             ),
//             Positioned(
//               top: 40,
//               left: 0,
//               child: Container(
//                 width: width,
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         customBackButton != null && customBackButton != const SizedBox.shrink()
//                             ? customBackButton
//                             : InkWell(
//                                 onTap: () => Navigator.pop(context),
//                                 child: const Icon(
//                                   Icons.keyboard_arrow_left,
//                                   color: Colors.white,
//                                   size: 40,
//                                 ),
//                               ),
//                         Text(
//                           title,
//                           style: const TextStyle(fontSize: 22, color: Colors.white70, fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     UIHelper.verticalSpace(20),
//                     Visibility(
//                       visible: subTitle != null && subTitle != "",
//                       child: Container(
//                         alignment: Alignment.center,
//                         child: Text(
//                           subTitle ?? "",
//                           style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 80,
//               child: Visibility(
//                 visible: (subTitle == null || subTitle == ""),
//                 child: childSubtitle,
//               ),
//             ),
//             Positioned(
//               top: 40,
//               right: 10,
//               child: Visibility(
//                 visible: showSearch,
//                 child: IconButton(
//                   icon: const Icon(Icons.search, color: Colors.white),
//                   onPressed: () {
//                     if (btnSearchClick != null) btnSearchClick();
//                   },
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 40,
//               right: 10,
//               child: Visibility(visible: !showSearch, child: customSearchButton),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ///
//   static Widget circularContainer(double height, Color color, {Color borderColor = Colors.transparent, double borderWidth = 2}) {
//     return Container(
//       height: height,
//       width: height,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: color,
//         border: Border.all(color: borderColor, width: borderWidth),
//       ),
//     );
//   }

//   ///
//   static Widget loadingWidget({double? height}) {
//     return Center(
//       child: SizedBox(
//         height: height ?? double.infinity,
//         child: Lottie.asset(AssetConst.ANIM_LOTTIE_LOADING, height: 150, width: 150),
//       ),
//     );
//   }

//   static Widget shadowButton(Color btncolor, String btntext, Color textcolor, double radius, Color bordercolor) {
//     return IntrinsicWidth(
//       child: Container(
//         padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
//         alignment: Alignment.center,
//         decoration: buttonShadow(btncolor, radius, bordercolor),
//         child: Text(
//           btntext,
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: textcolor,
//           ),
//         ),
//       ),
//     );
//   }

//   static Widget shadowButtonFullwidgth(Color btncolor, String btntext, Color textcolor, double radius, Color bordercolor, BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 12, bottom: 12),
//       alignment: Alignment.center,
//       decoration: buttonShadow(btncolor, radius, bordercolor),
//       child: Text(
//         btntext,
//         style: Theme.of(context).textTheme.titleMedium!.merge(
//               TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: textcolor,
//               ),
//             ),
//       ),
//     );
//   }

//   static BoxDecoration buttonShadow(Color btncolor, double radius, Color bordercolor) {
//     return BoxDecoration(
//       color: btncolor,
//       borderRadius: BorderRadius.all(
//         Radius.circular(radius),
//       ),
//       border: Border.all(color: bordercolor),
//       boxShadow: [
//         BoxShadow(
//           color: btncolor.withOpacity(0.2),
//           spreadRadius: 4,
//           blurRadius: 10,
//           offset: const Offset(0, 3),
//         ),
//       ],
//     );
//   }
// }
