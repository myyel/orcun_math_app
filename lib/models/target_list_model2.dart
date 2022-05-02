class TargetListModel2 {
  final DateTime? date;
  final int? target;
  final int? result;
  final String? reason;

  TargetListModel2({this.date, this.target, this.result, this.reason});

  Map<String, dynamic> toMap() => {
        "date": date,
        "target": target,
        "result": result,
        "reason": reason,
      };

  factory TargetListModel2.fromMap(Map map) => TargetListModel2(
        date: map["date"]!,
        target: map["target"]!,
        result: map["result"]!,
        reason: map["reason"]!,
      );
}
