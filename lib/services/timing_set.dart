import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rateandreview/models/rate.dart';
import 'package:rateandreview/models/user.dart';

class DatabaseService{

  final String uid;
  String curr_name;
  int curr_room;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference rateCollection = Firestore.instance.collection('rating');

  Future updateUserData(String time) async{
    return await rateCollection.document(uid).updateData({
      'Time':time,
//      'Name': curr_name,
//      'Room': curr_room,
    });
  }

  //rate list from snapshot
  List<Rate> _rateListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      curr_name = doc.data['Name'];
      curr_room = doc.data['Room'];
      return Rate(
          time: doc.data['Time'] ?? 'Ticket Cancelled',
          name: doc.data['Name'] ?? 'New Member',
          room: doc.data['Room'] ?? 0,
        reg_no: doc.data['Reg_no']??'00---0000',
        category: doc.data['Category']??'Student',
      );
    }).toList();
  }
  //userData from snapshots
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