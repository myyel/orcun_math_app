import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:orcun_math/models/target_list_model.dart';

import '../models/target_list_model2.dart';
import '../services/database.dart';
import '../services/time_service.dart';

class HomePageViewModel extends ChangeNotifier {
  Database _database = Database();
  String _resolvedQuestionRef = "resolvedQuestions";
  String _target = "target";

  int result = 0;
  int target = 0;
  int count = 0;

  bool changeColor() {
    return false;
  }

  Stream<List<TargetListModel>> getTargetList() {
    Stream<List<DocumentSnapshot>> streamListDocument = _database
        .getTargetListFromApi(_resolvedQuestionRef)
        .map((querySnapshot) => querySnapshot.docs);

    Stream<List<TargetListModel>> streamListTarget = streamListDocument.map(
        (listOfDocSnap) => listOfDocSnap
            .map((docSnap) => TargetListModel.fromDocument(docSnap))
            .toList());

    return streamListTarget;
  }

  Stream<List<TargetListModel>> getTarget() {
    Stream<List<DocumentSnapshot>> streamDocument = _database
        .getTargetListFromApi(_target)
        .map((querySnapshot) => querySnapshot.docs);

    Stream<List<TargetListModel>> streamTarget = streamDocument.map(
        (listOfDocSnap) => listOfDocSnap
            .map((docSnap) => TargetListModel(target: docSnap.get("target")))
            .toList());

    return streamTarget;
  }

  Future<void> addResult(
      {required int result,
      required int target,
      required DateTime dateTime,
      required String reason}) async {
    TargetListModel2 newResult = TargetListModel2(
      date: dateTime,
      target: target,
      result: result,
      reason: reason,
    );

    await _database.deleteDocument(
        referencePath: _resolvedQuestionRef,
        id: TimeService.dateTimeToString(newResult.date!).substring(0, 10));

    await _database.setTargetData(
        collectionRef: _resolvedQuestionRef, targetAsMap: newResult.toMap());
  }
}
