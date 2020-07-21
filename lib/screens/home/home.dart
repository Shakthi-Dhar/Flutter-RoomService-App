import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rateandreview/services/auth.dart';
import 'package:rateandreview/services/database.dart';
import 'package:provider/provider.dart';
import 'package:rateandreview/screens/home/rate_list.dart';
import 'package:rateandreview/models/rate.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){

      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Text('Bottom sheet'),
        );
      });
    }

    return StreamProvider<List<Rate>>.value(
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
          centerTitle: true,
          title:
          Align(alignment:Alignment.topLeft, child: Text("Rate & Review")),

          backgroundColor: Colors.white12,

        ),

        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.white24,
          color: Colors.white12,
          height: 60,
          index: 0,
          animationDuration: Duration(seconds: 1),
          items: <Widget>[
            Icon(Icons.hotel, color:Colors.white,size: 30, ),
            Icon(Icons.settings, color:Colors.white,size: 30, ),
            Icon(Icons.backspace,color: Colors.white, size: 30),
          ],

          onTap: (index) {
            //Handle button tap
            if(index==2){
              Future.delayed(Duration(milliseconds: 980), ()async{
                await _auth.signOut();
              },);
            };
            if(index==1){
              Future.delayed(Duration(milliseconds: 980), ()=>_showSettingsPanel(),);
            };
          },
        ),

        body:
        rateList(),



      ),
      ),
    );
  }
}
