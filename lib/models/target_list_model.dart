import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orcun_math/services/time_service.dart';

class TargetListModel {
  final String? date;
  final int? target;
  final int? result;
  final String? reason;

  TargetListModel({this.date, this.target, this.result, this.reason});

  Map<String, dynamic> toMap() => {
        "date": TimeService.dateTimeToTimeStamp(
            TimeService.stringToDatetime(date!)),
        "target": target,
        "result": result,
        "reason": reason,
      };

  factory TargetListModel.fromMap(Map map) => TargetListModel(
        date: map["date"]!,
        target: map["target"]!,
        result: map["result"]!,
        reason: map["reason"]!,
      );

  factory TargetListModel.fromDocument(DocumentSnapshot map) {
    return TargetListModel(
      date: TimeService.dateTimefromTimeStam(map.get("date")).toString(),
      reason: map.get("reason"),
      result: map.get("result"),
      target: map.get("target"),
    );
  }
}
