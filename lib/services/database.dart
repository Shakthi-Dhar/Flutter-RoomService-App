import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rateandreview/models/rate.dart';

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

  //rate list from snapshot
  List<Rate> _rateListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Rate(
        name: doc.data['name'] ?? '',
        num_rooms: doc.data['num_rooms'] ?? 0,
        sqfeet: doc.data['sqfeet']?? 0
      );
    }).toList();
  }


  //get rateing stream

  Stream<List<Rate>>get rate{
    return rateCollection.snapshots()
    .map(_rateListFromSnapshot);
  }
}