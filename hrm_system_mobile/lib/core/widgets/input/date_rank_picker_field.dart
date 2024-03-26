// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:human_resource_management_system/core/helpers/date_helper.dart';
// import 'package:human_resource_management_system/core/widgets/dialogs/month_picker_dialog.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';
// import 'package:fluttericon/font_awesome_icons.dart';

// // ignore: constant_identifier_names
// enum DateRankPickerMode { DATE_PICKER, DATETIME_PICKER, MONTH_PICKER, RANK_PICKER }

// // ignore: must_be_immutable
// class DateRankPickerField extends StatefulWidget {
//   DateTime startDate;
//   DateTime? endDate;
//   DateRankPickerMode mode;
//   bool enabled;
//   bool fullDateTimeFormat;
//   Color? bgColor;

//   void Function(DateTime startDate, DateTime endDate) onDateChanged;

//   int nbIncrement = 0;

//   DateRankPickerField({Key? key, required this.startDate, this.endDate, required this.onDateChanged, this.nbIncrement = 6, this.mode = DateRankPickerMode.DATE_PICKER, this.enabled = true, this.fullDateTimeFormat = false, this.bgColor})
//       : super(key: key) {
//     if (endDate == null) {
//       if (nbIncrement == 0) {
//         endDate = startDate;
//       } else {
//         endDate = startDate.add(Duration(days: nbIncrement));
//       }
//       onDateChanged(startDate, endDate!);
//     }
//   }

//   @override
//   State<StatefulWidget> createState() => _DateRankPickerFieldState();
// }

// class _DateRankPickerFieldState extends State<DateRankPickerField> {
//   Widget _getWrapContainer({required Widget child}) {
//     return Container(
//       height: 60,
//       padding: const EdgeInsets.all(7),
//       decoration: BoxDecoration(
//         color: widget.enabled ? widget.bgColor ?? Colors.white : Colors.grey[200],
//         border: Border.all(width: 1, color: widget.bgColor ?? Colors.grey),
//         borderRadius: const BorderRadius.all(Radius.circular(3)),
//       ),
//       child: child,
//     );
//   }

//   Widget _getDatePicker() {
//     return _getWrapContainer(
//       child: InkWell(
//         onTap: () async {
//           final DateTime? picked = await showDatePicker(
//               context: context,
//               initialDate: widget.startDate,
//               firstDate: DateTime(1900),
//               lastDate: DateTime(2100),
//               builder: (context, child) {
//                 return Theme(
//                   data: Theme.of(context).copyWith(
//                     primaryColor: Colors.blue,
//                     textTheme: const TextTheme(
//                       headlineMedium: TextStyle(fontSize: 20.0),
//                     ),
//                   ),
//                   child: child!,
//                 );
//               });
//           if (picked != null) {
//             setState(() {
//               widget.startDate = picked;
//             });
//             widget.onDateChanged(widget.startDate, widget.endDate!);
//           }
//         },
//         child: Row(
//           children: <Widget>[
//             const SizedBox(
//               width: 5,
//             ),
//             Text(
//               DateHelper.format(widget.startDate, widget.fullDateTimeFormat ? DateHelper.timeFormatddMMyyyHHMMA : DateHelper.dateFormatddMMyyy),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _getMonthPicker() {
//     final MaterialLocalizations localizations = MaterialLocalizations.of(context);
//     return _getWrapContainer(
//       child: InkWell(
//         onTap: () async {
//           final DateTime? picked = await showMonthPicker(
//             context: context,
//             initialDate: widget.startDate,
//             firstDate: DateTime(1900),
//             lastDate: DateTime(2100),
//           );
//           if (picked != null) {
//             setState(() {
//               widget.startDate = picked;
//             });
//             widget.onDateChanged(widget.startDate, widget.endDate!);
//           }
//         },
//         child: Row(
//           children: <Widget>[
//             const SizedBox(
//               width: 5,
//             ),
//             Text(
//               localizations.formatMonthYear(widget.startDate),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _getRankPicker() {
//     return SizedBox(
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: _getWrapContainer(
//               child: InkWell(
//                 onTap: widget.enabled
//                     ? () async {
//                         final DateTime? picked = await showDatePicker(
//                             context: context,
//                             initialDate: widget.startDate,
//                             firstDate: DateTime(1900),
//                             lastDate: DateTime(2100),
//                             builder: (context, child) {
//                               return Theme(
//                                 data: Theme.of(context).copyWith(
//                                   primaryColor: Colors.blue,
//                                   textTheme: const TextTheme(
//                                     headlineMedium: TextStyle(fontSize: 20.0),
//                                   ),
//                                 ),
//                                 child: child!,
//                               );
//                             });
//                         if (picked != null) {
//                           setState(() {
//                             widget.startDate = picked;
//                             if (widget.nbIncrement > 0) {
//                               widget.endDate = widget.startDate.add(Duration(days: widget.nbIncrement));
//                             } else {
//                               widget.endDate = picked;
//                             }
//                           });
//                           widget.onDateChanged(widget.startDate, widget.endDate!);
//                         }
//                       }
//                     : null,
//                 child: Row(
//                   children: <Widget>[
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       DateHelper.format(widget.startDate, DateHelper.dateFormatddMMyyy),
//                       style: TextStyle(fontSize: 13, color: widget.enabled ? Colors.black : Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 5, right: 5),
//             child: const Text(">"),
//           ),
//           Expanded(
//             child: _getWrapContainer(
//               child: InkWell(
//                 onTap: widget.enabled
//                     ? () async {
//                         final DateTime? picked = await showDatePicker(
//                             context: context,
//                             initialDate: widget.endDate!,
//                             firstDate: DateTime(1900),
//                             lastDate: DateTime(2100),
//                             builder: (context, child) {
//                               return Theme(
//                                 data: Theme.of(context).copyWith(
//                                   primaryColor: Colors.blue,
//                                   textTheme: const TextTheme(
//                                     headlineMedium: TextStyle(fontSize: 20.0),
//                                   ),
//                                 ),
//                                 child: child!,
//                               );
//                             });
//                         if (picked != null) {
//                           setState(() {
//                             widget.endDate = picked;
//                           });
//                           widget.onDateChanged(widget.startDate, widget.endDate!);
//                         }
//                       }
//                     : null,
//                 child: Row(
//                   children: <Widget>[
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       DateHelper.format(widget.endDate!, DateHelper.dateFormatddMMyyy),
//                       style: TextStyle(fontSize: 13, color: widget.enabled ? Colors.black : Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.mode == DateRankPickerMode.DATE_PICKER) {
//       return _getDatePicker();
//     } else if (widget.mode == DateRankPickerMode.MONTH_PICKER) {
//       return _getMonthPicker();
//     } else {
//       return _getRankPicker();
//     }
//   }
// }

// // ignore: must_be_immutable
// class InlineDateRankPickerField extends StatefulWidget {
//   DateTime startDate;
//   DateTime? endDate;
//   DateRankPickerMode mode;
//   bool enabled;

//   void Function(DateTime startDate, DateTime endDate) onDateChanged;

//   int nbIncrement = 0;

//   InlineDateRankPickerField({
//     Key? key,
//     required this.startDate,
//     this.endDate,
//     required this.onDateChanged,
//     this.nbIncrement = 6,
//     this.mode = DateRankPickerMode.DATE_PICKER,
//     this.enabled = true,
//   }) : super(key: key) {
//     if (endDate == null) {
//       if (nbIncrement == 0) {
//         endDate = startDate;
//       } else {
//         endDate = startDate.add(Duration(days: nbIncrement));
//       }
//       onDateChanged(startDate, endDate!);
//     }
//   }

//   @override
//   State<StatefulWidget> createState() => _InlineDateRankPickerFieldState();
// }

// class _InlineDateRankPickerFieldState extends State<InlineDateRankPickerField> {
//   Widget _getWrapContainer({required Widget child}) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: widget.enabled ? Colors.white : Colors.grey[200],
//         border: Border.all(width: 0.5, color: Colors.grey[300]!),
//         borderRadius: const BorderRadius.all(Radius.circular(3)),
//       ),
//       child: child,
//     );
//   }

//   Widget _getDatePicker() {
//     return _getWrapContainer(
//       child: InkWell(
//         onTap: () async {
//           final DateTime? picked = await showDatePicker(
//               context: context,
//               initialDate: widget.startDate,
//               firstDate: DateTime(1900),
//               lastDate: DateTime(2100),
//               builder: (context, child) {
//                 return Theme(
//                   data: Theme.of(context).copyWith(
//                     primaryColor: Colors.blue,
//                     textTheme: const TextTheme(
//                       headlineMedium: TextStyle(fontSize: 20.0),
//                     ),
//                   ),
//                   child: child!,
//                 );
//               });
//           if (picked != null) {
//             setState(() {
//               widget.startDate = picked;
//             });
//             widget.onDateChanged(widget.startDate, widget.endDate!);
//           }
//         },
//         child: Row(
//           children: <Widget>[
//             Icon(
//               FontAwesome.calendar,
//               color: Theme.of(context).primaryColorDark,
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             Text(
//               DateHelper.format(widget.startDate, DateHelper.dateFormatddMMyyy),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _getDateTimePicker() {
//     return _getWrapContainer(
//       child: InkWell(
//         onTap: () async {
//           DatePicker.showDateTimePicker(
//             context,
//             showTitleActions: true,
//             minTime: DateTime(1900),
//             maxTime: DateTime(2100),
//             currentTime: widget.startDate,
//             locale: LocaleType.en,
//             //theme: DatePickerTheme(headerColor: Colors.orange, backgroundColor: Colors.blue, itemStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18), doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
//             onChanged: (date) {
//               if (kDebugMode) {
//                 print('change $date in time zone ${date.timeZoneOffset.inHours}');
//               }
//             },
//             onConfirm: (DateTime? date) {
//               if (date != null) {
//                 setState(() {
//                   widget.startDate = date;
//                 });
//                 widget.onDateChanged(widget.startDate, widget.endDate!);
//               }
//             },
//           );
//         },
//         child: Row(
//           children: <Widget>[
//             Icon(
//               FontAwesome.calendar,
//               color: Theme.of(context).primaryColorDark,
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             Text(
//               DateHelper.format(widget.startDate, DateHelper.timeFormatddMMyyyHHMMSSA),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _getMonthPicker() {
//     final MaterialLocalizations localizations = MaterialLocalizations.of(context);
//     return _getWrapContainer(
//       child: InkWell(
//         onTap: () async {
//           final DateTime? picked = await showMonthPicker(
//             context: context,
//             initialDate: widget.startDate,
//             firstDate: DateTime(1900),
//             lastDate: DateTime(2100),
//           );
//           if (picked != null) {
//             setState(() {
//               widget.startDate = picked;
//             });
//             widget.onDateChanged(widget.startDate, widget.endDate!);
//           }
//         },
//         child: Row(
//           children: <Widget>[
//             Icon(
//               FontAwesome5.calendar_check,
//               color: Theme.of(context).primaryColorDark,
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             Text(
//               localizations.formatMonthYear(widget.startDate),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _getRankPicker() {
//     return SizedBox(
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: _getWrapContainer(
//               child: InkWell(
//                 onTap: widget.enabled
//                     ? () async {
//                         final DateTime? picked = await showDatePicker(
//                             context: context,
//                             initialDate: widget.startDate,
//                             firstDate: DateTime(1900),
//                             lastDate: DateTime(2100),
//                             builder: (context, child) {
//                               return Theme(
//                                 data: Theme.of(context).copyWith(
//                                   primaryColor: Colors.blue,
//                                   textTheme: const TextTheme(
//                                     headlineMedium: TextStyle(fontSize: 20.0),
//                                   ),
//                                 ),
//                                 child: child!,
//                               );
//                             });
//                         if (picked != null) {
//                           setState(() {
//                             widget.startDate = picked;
//                             if (widget.nbIncrement > 0) {
//                               widget.endDate = widget.startDate.add(Duration(days: widget.nbIncrement));
//                             } else {
//                               widget.endDate = picked;
//                             }
//                           });
//                           widget.onDateChanged(widget.startDate, widget.endDate!);
//                         }
//                       }
//                     : null,
//                 child: Row(
//                   children: <Widget>[
//                     Icon(
//                       FontAwesome5.calendar_alt,
//                       color: widget.enabled ? Colors.lightBlue : Colors.grey[600],
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       DateHelper.format(widget.startDate, DateHelper.dateFormatddMMyyySlash),
//                       style: TextStyle(fontSize: 14, color: widget.enabled ? Colors.black : Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 5, right: 5),
//             child: const Text("-"),
//           ),
//           Expanded(
//             child: _getWrapContainer(
//               child: InkWell(
//                 onTap: widget.enabled
//                     ? () async {
//                         final DateTime? picked = await showDatePicker(
//                             context: context,
//                             initialDate: widget.endDate!,
//                             firstDate: DateTime(1900),
//                             lastDate: DateTime(2100),
//                             builder: (context, child) {
//                               return Theme(
//                                 data: Theme.of(context).copyWith(
//                                   primaryColor: Colors.blue,
//                                   textTheme: const TextTheme(
//                                     headlineMedium: TextStyle(fontSize: 20.0),
//                                   ),
//                                 ),
//                                 child: child!,
//                               );
//                             });
//                         if (picked != null) {
//                           setState(() {
//                             widget.endDate = picked;
//                           });
//                           widget.onDateChanged(widget.startDate, widget.endDate!);
//                         }
//                       }
//                     : null,
//                 child: Row(
//                   children: <Widget>[
//                     Icon(
//                       FontAwesome5.calendar_alt,
//                       color: widget.enabled ? Colors.lightBlue : Colors.grey[600],
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       DateHelper.format(widget.endDate!, DateHelper.dateFormatddMMyyySlash),
//                       style: TextStyle(fontSize: 12, color: widget.enabled ? Colors.black : Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.mode == DateRankPickerMode.DATE_PICKER) {
//       return _getDatePicker();
//     } else if (widget.mode == DateRankPickerMode.DATETIME_PICKER) {
//       return _getDateTimePicker();
//     } else if (widget.mode == DateRankPickerMode.MONTH_PICKER) {
//       return _getMonthPicker();
//     } else {
//       return _getRankPicker();
//     }
//   }
// }
