//import 'dart:html';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rateandreview/models/rate.dart';
import 'package:rateandreview/models/user.dart';

class DatabaseService{
  
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference rateCollection = Firestore.instance.collection('rating');

  Future<void> updateUserData(int room, String name,String time,String reg_no,String category) async{
    return await rateCollection.document(uid).setData({
      'Room':room,
      'Name':name,
      'Time':time,
      'Reg_no':reg_no,
      'Category':category,
    },
    );
  }

  //rate list from snapshot
  List<Rate> _rateListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Rate(
        name: doc.data['Name'] ?? 'New Member',
        time: doc.data['Time'] ?? 'Ticket Closed',
        room: doc.data['Room']?? 0,
        reg_no: doc.data['Reg_no']??'00---0000',
        category: doc.data['Category']??'Student',
      );
    }).toList();
  }
//  userData from snapshots

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['Name'],
      time: snapshot.data['Time'],
      room: snapshot.data['Room'],
      reg_no: snapshot.data['Reg_no'],
      category: snapshot.data['Category'],
    );
  }

  //get rateing stream

  Stream<List<Rate>>get rate{
    return rateCollection.snapshots()
    .map(_rateListFromSnapshot);
  }


  //get user doc stream
  Stream<UserData>get userData{
    return rateCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}