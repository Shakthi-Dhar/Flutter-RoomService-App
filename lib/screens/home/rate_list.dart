import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class rateList extends StatefulWidget {
  @override
  _rateListState createState() => _rateListState();
}

class _rateListState extends State<rateList> {
  @override
  Widget build(BuildContext context) {
    final rate = Provider.of<QuerySnapshot>(context);
//    print(rate.documents);
    for(var doc in rate.documents){
      print(doc.data);
    }
    return Container();
  }
}
