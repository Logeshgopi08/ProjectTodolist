import 'package:cloud_firestore/cloud_firestore.dart';

class Databasemethods{

  Future addemployeedetails( Map<String,dynamic> employeeinfomap, String id) async{
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(employeeinfomap);
  }

  Future<Stream<QuerySnapshot>>getemployeedetail()async{
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  }
  Future updateemployeedetail (String id, Map<String, dynamic>updateinfo) async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).update(updateinfo);
  }

  Future deleteinfo(String id)async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).delete();
  }
}