import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rateandreview/services/auth.dart';
import 'package:rateandreview/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rateandreview/screens/home/rate_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().rate,
      child: Container(
          decoration:new BoxDecoration(
          image:  new DecorationImage(
          image: new AssetImage("images/city.jpg"),
      fit: BoxFit.cover,)
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.85),

        appBar:
        AppBar(
          title:
          Align(alignment:Alignment.topLeft, child: Text("Rate & Review")),

          backgroundColor: Colors.black,

          actions: <Widget>[

            Align(
              alignment: Alignment.topRight,
              child:
              FlatButton.icon(
                color: Colors.black.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white,),
                ),
                icon: Icon(Icons.backspace, color: Colors.white,size: 20,),
                label: Text('Log Out',
                  style: TextStyle(color: Colors.white, fontSize: 15,),

                ),
                onPressed: () async{
                  await _auth.signOut();
                },
              ),
            ),

          ],
        ),
        body:
        rateList(),



      ),
      ),
    );
  }
}
