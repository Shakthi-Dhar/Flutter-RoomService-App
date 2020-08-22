//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rateandreview/models/rate.dart';
import 'package:rateandreview/models/user.dart';

class DatabaseService{

  final String uid;
  String curr_time;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference rateCollection = Firestore.instance.collection('rating');

  Future updateUserData(int room, String name,
//      String time
      ) async{
    return await rateCollection.document(uid).updateData({
      'Room':room,
      'Name':name,
//      'Time':curr_time,
    });
  }

  //rate list from snapshot
  List<Rate> _rateListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
//      curr_time = doc.data['Time'];
      return Rate(
          name: doc.data['Name'] ?? 'New Member',
          time: doc.data['Time'] ?? 'Ticket Canceled',
          room: doc.data['Room']?? 0
      );
    }).toList();
  }
  //userData from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
//    curr_time = snapshot.data['Time'];

    return UserData(
      uid: uid,
      name: snapshot.data['Name'],
      time: snapshot.data['Time'],
      room: snapshot.data['Room'],
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