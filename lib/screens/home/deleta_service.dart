import 'package:flutter/material.dart';
import 'package:rateandreview/models/user.dart';
import 'package:rateandreview/services/timing_set.dart';
//import 'package:rateandreview/services/database.dart';
import 'package:provider/provider.dart';
import 'package:rateandreview/shared/loading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class delete_service extends StatefulWidget {
  @override
  _delete_serviceState createState() => _delete_serviceState();
}

class _delete_serviceState extends State<delete_service> {

  final _formKey = GlobalKey<FormState>();
  final List<String> time = ['Morning [9am to 12pm]','Afternoon [12pm to 4pm]','Evening [4pm to 7pm]','Night [7pm to 10pm]','Ticket Closed'];

  String _currenttime = 'Ticket Cancelled';


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

//TODO: A similar situation like settings_form.dart, but here only updating the time
          UserData userData = snapshot.data;
          print(userData);
//          String _currentname = userData.name;
//          String _currentroom = userData.room;
          print(userData);
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
//                Text('Update the Data', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                DropdownButtonFormField(
                  validator: (val) => val.isEmpty ? 'Please Choose suitable Time' : null,
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
                    icon: Icon(Icons.access_time, color: Colors.black,size: 30,),
                    hintText: 'Choose Timing     ',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),

                    errorStyle: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black,
                    ),
                  ),

                  items: time.map((timing){
                    return DropdownMenuItem(
                      value: timing,
                      child: Text('$timing'),
                    );
                  }).toList(),

                  onChanged: (val) => setState(()=>_currenttime=val),

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
//TODO: calling the updateUserData function from timing_set.dart

                        await DatabaseService(uid:  user.uid).updateUserData(
//                            int.parse(_currentroom) ?? userData.room,
//                            _currentname ?? userData.name,
                            _currenttime ?? userData.time,
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
