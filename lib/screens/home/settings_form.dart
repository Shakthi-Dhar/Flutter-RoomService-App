import 'package:flutter/material.dart';
import 'package:rateandreview/models/user.dart';

import 'package:rateandreview/services/profile_set.dart';
//import 'package:rateandreview/services/database.dart';
import 'package:provider/provider.dart';
import 'package:rateandreview/shared/loading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> time = ['Morning [9am to 12pm]','Afternoon [12pm to 4pm]','Evening [4pm to 7pm]','Night [7pm to 10pm]'];

  String _currentName = 'Name';
//  String _currenttime ;
  int _currentroom = 0;
  String _currentreg_no = '00---0000';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return
//      loading ? SpinKitCircle(
//      color: Colors.black.withOpacity(0.6),
//      size: 100,
//    ):
      StreamBuilder<UserData>(

      stream: DatabaseService(uid: user.uid).userData,
      
      builder: (context, snapshot) {

//        if(snapshot.hasData){

      //TODO: The userdata is returning NULL values

          UserData userData = snapshot.data;
//          String _currenttime = snapshot.data.time;
          print(userData);
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
//                Text('Update the Data', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),

                TextFormField(

                  validator: (val) => val.isEmpty ? 'Please enter name' : null,
                  onChanged: (val) => setState(()=>_currentName = val),

                  decoration: InputDecoration(

                    border: InputBorder.none,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    icon: Icon(Icons.person_outline, color: Colors.black,size: 30,),
                    hintText: 'Enter your Name here',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),

                    errorStyle: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                TextFormField(

                  validator: (val) => val.isEmpty ? 'Please enter your Reg_no' : null,
                  onChanged: (val) => setState(()=>_currentreg_no= val),

                  decoration: InputDecoration(

                    border: InputBorder.none,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    icon: Icon(Icons.person_pin, color: Colors.black,size: 30,),
                    hintText: 'Enter Registration number',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),

                    errorStyle: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                TextFormField(

                  validator: (val) => val.isEmpty ? 'Enter Room number' : null,
                  onChanged: (val) => setState(()=>_currentroom = int.parse(val)),

                  decoration: InputDecoration(

                    border: InputBorder.none,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    icon: Icon(Icons.room, color: Colors.black,size: 30,),
                    hintText: 'Enter your Room Number             ',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),

                    errorStyle: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                Align(
                  alignment: Alignment.centerRight,
                  child:
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                    ),
                    color: Colors.black,

                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: ()async{
                      Navigator.pop(context);
//                      setState(() => loading =true);

                      if(_formKey.currentState.validate()){

                        //TODO: updating the userdata by calling the updateUserData function from the profile_set.dart file

                        await DatabaseService(uid:  user.uid).updateUserData(
                           _currentroom ?? snapshot.data.room,
                           _currentName ?? snapshot.data.name,
                           _currentreg_no ?? snapshot.data.reg_no,
                           );
                      }

//                      setState(() => loading =false);
                    },
                  ),
                ),
              ],
            ),
          );

//        }
//
//        else{
//          return Form(
//            child: Text("error"),
//          );
//        }
      }
    );
  }
}
