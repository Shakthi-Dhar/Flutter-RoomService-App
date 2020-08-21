import 'package:flutter/material.dart';
import 'package:rateandreview/models/user.dart';
import 'package:rateandreview/services/database.dart';
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
//  String _currenttime = 'Time';
  int _currentroom = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading ? SpinKitCircle(
      color: Colors.black.withOpacity(0.6),
      size: 100,
    ): StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      
      builder: (context, snapshot) {
//
//        if(snapshot.hasData){
          UserData userData = snapshot.data;
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
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    icon: Icon(Icons.person, color: Colors.black,size: 30,),
                    hintText: 'Enter Name',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),

                    errorStyle: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 10,),

//                DropdownButtonFormField(
//                  validator: (val) => val.isEmpty ? 'Select the Time' : null,
//                  decoration: InputDecoration(
//
//                    border: InputBorder.none,
//                    fillColor: Colors.black,
//                    enabledBorder: OutlineInputBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                      borderSide: BorderSide(color: Colors.black),
//                    ),
//                    focusedBorder: OutlineInputBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                      borderSide: BorderSide(color: Colors.black),
//                    ),
//                    icon: Icon(Icons.access_time, color: Colors.black,size: 30,),
//                    hintText: 'Choose Timings',
//                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
//
//                    errorStyle: TextStyle(
//                      fontSize: 10.0,
//                      color: Colors.black,
//                    ),
//                  ),
//
//                  items: time.map((timing){
//                    return DropdownMenuItem(
//                      value: timing,
//                      child: Text('$timing'),
//                    );
//                  }).toList(),
//
//                  onChanged: (val) => setState(()=>_currenttime=val),
//
//                ),
//
//                SizedBox(height: 10,),

                TextFormField(

                  validator: (val) => val.isEmpty ? 'Enter Room number' : null,
                  onChanged: (val) => setState(()=>_currentroom = int.parse(val)),

                  decoration: InputDecoration(

                    border: InputBorder.none,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    icon: Icon(Icons.home, color: Colors.black,size: 30,),
                    hintText: 'Enter Room Number',
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
                      'Done',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: ()async{
                      Navigator.pop(context);
                      setState(() => loading =true);

                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid:  user.uid).updateUserData(
                           _currentroom ?? userData.room,
                           _currentName ?? userData.name,
                           "Nil" ?? userData.time,
                           );
                      }

                      setState(() => loading =false);
                    },
                  ),


                ),

              ],
            ),
          );

//        }

//        else{
//          return Form(
//            child: Text("error"),
//          );
//        }
      }
    );
  }
}
