import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeService {
  static DateTime stringToDatetime(String date) {
    DateTime formattedDate = DateTime.parse(date);
    return formattedDate;
  }

  ///DateTime'ı string'e çeviren method
  static String dateTimeToString(DateTime dateTime) {
    String formattedDate = DateFormat("yyyy-MM-dd").format(dateTime);
    return formattedDate;
  }

  ///DateTime'ı TimeStamp'e çeviren method

  static Timestamp dateTimeToTimeStamp(DateTime dateTime) {
    return Timestamp.fromMillisecondsSinceEpoch(
        dateTime.millisecondsSinceEpoch);
  }

  ///TimeStamp'i DateTime'a çeviren method

  static DateTime dateTimefromTimeStam(Timestamp timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
  }
}
