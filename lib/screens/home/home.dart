import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rateandreview/screens/home/settings_form.dart';
import 'package:rateandreview/services/auth.dart';
import 'package:rateandreview/services/database.dart';
import 'package:provider/provider.dart';
import 'package:rateandreview/screens/home/rate_list.dart';
import 'package:rateandreview/models/rate.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){

      showModalBottomSheet(context: context, builder: (context){
        return GestureDetector(
//          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
            child: SettingsForm(),
          ),
        );
      }
      );
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
          Align(alignment:Alignment.topLeft, child: Text("Room Service")),

          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
            icon: Icon(
              Icons.exit_to_app,
              size: 35,
              color: Colors.white,
            ),
              onPressed: ()async{
                await _auth.signOut();
              },
            ),
          ],

        ),
        floatingActionButton: FloatingActionButton.extended(
          highlightElevation: 100 ,
          backgroundColor: Colors.white70,
          onPressed: () => _showSettingsPanel(),
          icon: Icon(Icons.update,size: 30,color: Colors.black,),
          label: Text(" Update ", style: TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold),),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


        body:
        rateList(),



      ),
      ),
    );
  }
}
