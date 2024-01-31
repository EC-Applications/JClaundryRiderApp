import 'dart:core';

import 'package:efood_multivendor_driver/controller/splash_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static String dateTimeStringToDateTime(String dateTime) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static DateTime dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime);
  }

  static DateTime stringTimeToDate(String dateTime) {
    return DateFormat('HH:mm:ss').parse(dateTime);
  }

  static String isoStringToTime(String dateTime) {
    return DateFormat(_timeFormatter()).format(stringTimeToDate(dateTime));
  }

  static String dateTimeToStringTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat(_timeFormatter()).format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateAnTime(String dateTime) {
    return DateFormat('dd/MMM/yyyy ${_timeFormatter()}').format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime);
  }

  static String convertTimeToTime(String time) {
    return DateFormat(_timeFormatter()).format(DateFormat('hh:mm:ss').parse(time));
  }

  static int timeDistanceInMin(String time) {
    DateTime _currentTime = Get.find<SplashController>().currentTime;
    DateTime _rangeTime = dateTimeStringToDate(time);
    return _currentTime.difference(_rangeTime).inMinutes;
  }

  static String _timeFormatter() {
    return Get.find<SplashController>().configModel.timeformat == '24' ? 'HH:mm' : 'hh:mm a';
  }


  static String getRemainingTime(String dateTimeStr) {
    DateTime givenDateTime = dateTimeStr != null ? DateTime.parse(dateTimeStr) : DateTime.now();
    DateTime currentDateTime = DateTime.now();

    Duration remaining = givenDateTime.difference(currentDateTime);

    if (remaining.isNegative) {
      return 'Time passed';
    } else if (remaining.inDays > 0) {
      return '${remaining.inDays} days, ${remaining.inHours % 24} hrs, ${remaining.inMinutes % 60} mins';
    } else if (remaining.inHours > 0) {
      return '${remaining.inHours} hours, ${remaining.inMinutes % 60} mins';
    } else if (remaining.inMinutes > 0) {
      return '${remaining.inMinutes} mins';
    } else {
      return '0 min';
    }
  }




  static String formatTimestamp(String timestamp) {

    DateTime dateTime = DateTime.parse(timestamp);
    dateTime = dateTime.toLocal();
    String formattedString = DateFormat("EEEE, d MMMM yyyy 'at' hh:mm a").format(dateTime);
    String finalString = formattedString.toLowerCase().split(' ').map((word) => word.capitalize).join(' ');

    return finalString;
  }




}
