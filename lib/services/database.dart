import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference rateCollection = Firestore.instance.collection('rating');

  Future updateUserData(int sqfeet, String name,int num_rooms) async{
    return await rateCollection.document(uid).setData({
      'sqfeet':sqfeet,
      'name':name,
      'num_rooms':num_rooms,
    });
  }

  //get rateing stream

  Stream<QuerySnapshot> get rate{
    return rateCollection.snapshots();
  }
}