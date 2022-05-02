import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/target_list_model2.dart';

class Database {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getTargetListFromApi(String referencePath) {
    return _fireStore.collection(referencePath).snapshots();
  }

  /// Veriyi silme hizmeti
  Future<void> deleteDocument(
      {required String referencePath, required String id}) async {
    await _fireStore.collection(referencePath).doc(id).delete();
  }

  ///Yeni veri ekleme ve güncelleme
  Future<void> setTargetData(
      {required String collectionRef,
      required Map<String, dynamic> targetAsMap}) async {
    await _fireStore
        .collection(collectionRef)
        .doc(TargetListModel2.fromMap(targetAsMap)
            .date
            .toString()
            .substring(0, 10))
        .set(targetAsMap);
  }
}
