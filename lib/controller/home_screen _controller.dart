import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenController {
  static final studentCollection =
      FirebaseFirestore.instance.collection("students");
  static addData(
      {required String name, required String ph, required String sub}) {
    studentCollection.add({"name": name, "sub": sub, "ph": ph});
  }

  static editData() {}

  static Future<void> deleteDAta(String id) async {
    await studentCollection.doc(id).delete();
  }
}
