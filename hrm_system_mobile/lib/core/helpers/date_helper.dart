import 'package:flutter/material.dart';
import 'package:human_resource_management_system/core/consts/app_const.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static final dateFormatddMMyyy = DateFormat('dd-MM-yyyy');
  static final dateFormatMMddyyy = DateFormat('MM-dd-yyyy');
  static final dateFormatMMMyyy = DateFormat('MMM-yyyy');
  static final dateFormatYYYMMdd = DateFormat('yyyy-MM-dd');
  static final timeFormatHHMMA = DateFormat('hh:mm:ss a');
  static final timeFormatHHMM = DateFormat('hh:mm');
  static final timeFormatddMMyyyHHMMA = DateFormat('dd-MM-yyyy hh:mm:ss a');
  static final sqlFormatddMMyyyHHMMA = DateFormat('yyyy-MM-dd hh:mm:ss');
  static final dateFormatddMMyyySlash = DateFormat('dd/MM/yyyy');
  static final timeFormatddMMyyyHHMMSSA = DateFormat('dd-MM-yyyy hh:mm:ss a');
  static final dateFormatyyyMMddHHMMSS = DateFormat('yyyy-MM-dd hh:mm:ss');

  /// It takes [duration] as a [String] and returns an integer representing the number of seconds
  ///
  /// Args:
  ///   [duration] (String): The duration string to parse.
  static int parseDuration(String duration) {
    return getDuration(duration).inSeconds;
  }

  /// It takes a string, and if it's a valid duration, it returns a Duration object
  ///
  /// Args:
  ///   [duration] (String): The duration string to parse.
  static Duration getDuration(String? duration) {
    if (duration == null || duration == "") return Duration.zero;

    List<String> parts = duration.split(':');
    return Duration(hours: int.parse(parts[0]), minutes: int.parse(parts[1]), seconds: int.parse(parts[2]));
  }

  /// It formats the date to the given format.
  ///
  /// Args:
  ///   [date] (DateTime): The date to be formatted.
  ///   [formater] (DateFormat): The format of the date.
  static String format(DateTime date, DateFormat formater) {
    try {
      return formater.format(date);
    } catch (exception) {
      debugPrint(exception.toString());
      return "";
    }
  }

  /// It formats the date to the local format.
  ///
  /// Args:
  ///   [contex]t (BuildContext): The context of the current screen.
  ///   [date] (String): The date to be formatted.
  ///   [isLocal] (bool): If the date is in the local timezone, set this to true. Defaults to false
  ///   [isGetDate] (bool): If true, it will return the date of the month. Defaults to false
  ///   [isGetMonth] (bool): If true, it will return the month of the date. Defaults to false
  ///   [isGetYear] (bool): If true, it will return the year of the date. Defaults to false
  static String formatLocalDate({required BuildContext context, required String date, bool isLocal = false, bool isGetDate = false, bool isGetMonth = false, bool isGetYear = false}) {
    Locale appLocale = const Locale(AppConst.DEFAULT_LANGUAGE, "");
    try {
      if (isLocal) {
        if (isGetDate) {
          return DateFormat('dd', appLocale.toString()).format(DateTime.parse(date));
        } else if (isGetMonth) {
          return DateFormat('MMM', appLocale.toString()).format(DateTime.parse(date));
        } else if (isGetYear) {
          return DateFormat('yyyy', appLocale.toString()).format(DateTime.parse(date));
        }
        return DateFormat('dd MMM yyyy', appLocale.toString()).format(DateTime.parse(date));
      } else {
        if (isGetDate) {
          return DateFormat('dd').format(DateTime.parse(date));
        } else if (isGetMonth) {
          return DateFormat('MMM').format(DateTime.parse(date));
        } else if (isGetYear) {
          return DateFormat('yyyy').format(DateTime.parse(date));
        }
        return dateFormatddMMyyy.format(DateTime.parse(date));
      }
    } catch (exception) {
      return "";
    }
  }

  /// It returns the time only from a date string.
  ///
  /// Args:
  ///   [date] (String): The date to be formatted.
  static String getTimeOnly(String date) {
    List<String> splitter = date.split(" ");
    if (splitter.length < 3) {
      return date;
    }
    return "${splitter[1]} ${splitter[2]}";
  }

  /// It returns the first date of the month.
  ///
  /// Args:
  ///   [now] (DateTime): The current date.
  static DateTime getFirstDateOfTheMonth(DateTime now) {
    return DateTime(now.year, now.month, 1);
  }

  /// It returns the last date of the month for the given date
  ///
  /// Args:
  ///   [now] (DateTime): The current date.
  static DateTime getLastDateOfTheMonth(DateTime now) {
    var beginningNextMonth = (now.month < 12) ? DateTime(now.year, now.month + 1, 1) : DateTime(now.year + 1, 1, 1);
    var lastDay = beginningNextMonth.subtract(const Duration(days: 1)).day;
    return DateTime(now.year, now.month, lastDay);
  }

  /// It adds a number of seconds to a DateTime object.
  ///
  /// Args:
  ///   [now] (DateTime): The current date and time.
  ///   [second] (int): The number of seconds to add to the current date.
  static DateTime getDatePlusSecond(DateTime now, int second) {
    return now.add(Duration(seconds: second));
  }

  /// This function takes an integer and returns a string of time format.
  ///
  /// Args:
  ///   [seconds] (int): The number of seconds to count down from.
  static String timer({required int seconds}) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }
    return "$hoursStr:$minutesStr:$secondsStr";
  }

  /// It takes a time string in the format of "HH:MM:SS" and returns a string in the format of "HH:MM".
  ///
  /// Args:
  ///   [time] (String): The time to be formatted.
  static String getHourMinute(String time) {
    List<String> times = time.split(":");
    return "${times[0]}:${times[1]}";
  }
}
