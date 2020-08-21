import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rateandreview/screens/home/settings_form.dart';
import 'package:rateandreview/services/auth.dart';
import 'package:rateandreview/services/database.dart';
import 'package:provider/provider.dart';
import 'package:rateandreview/screens/home/rate_list.dart';
import 'package:rateandreview/models/rate.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:rateandreview/screens/home/deleta_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';





class Home extends StatelessWidget {

//  createAlertPopUp(BuildContext context){
//    // ignore: missing_return
//    return showDialog(context: context, builder:(context){
//    return AlertDialog(
//      title: Text("Do you want to close the service ticket ?",style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold),),
//      content:
//
//      Row(
//        mainAxisAlignment:MainAxisAlignment.spaceAround ,
//        children: <Widget>[
//
//          RaisedButton(
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(30.0),
//            ),
//            color: Colors.black12,
//
//            child: Text(
//              'No',
//              style: TextStyle(color: Colors.white, fontSize: 12),
//            ),
//            onPressed: ()async{
//              Navigator.pop(context);
//            },
//          ),
//
//          RaisedButton(
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(30.0),
//            ),
//            color: Colors.redAccent,
//
//            child: Text(
//              'Yes',
//              style: TextStyle(color: Colors.white, fontSize: 14),
//            ),
//            onPressed: ()async{
//              Navigator.pop(context);
//            },
//          ),
//
//        ],
//      ),
//    );
//    },
//    );
//  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

//    void _showSettingsPanel(){
//
//      showModalBottomSheet(context: context, builder: (context){
//        return GestureDetector(
////          onTap: () => Navigator.pop(context),
//          child: Container(
//            padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
//            child: SettingsForm(),
//          ),
//        );
//      }
//      );
//    }
    void _showSettingsPanel(BuildContext context){
      Alert(
        context: context,

        type: AlertType.info,
        title: "Update Profile",
        content: SettingsForm(),

        buttons: [],
      ).show();
    }


    void _deleteService(BuildContext context){
      Alert(
        context: context,

        type: AlertType.error,
        title: "Raise/ Close Ticket" ,

        content: delete_service(),

        buttons: [],
      ).show();
    }

//    void _deleteService(){
////      createAlertPopUp(BuildContext context){
//        // ignore: missing_return
////        return
//          showDialog(context: context, builder:(context){
//          return AlertDialog(
//            title: Text("Do you want to close the service ticket ?",style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold),),
//            content:
//
//            Row(
//              mainAxisAlignment:MainAxisAlignment.spaceAround ,
//              children: <Widget>[
//
//                RaisedButton(
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(30.0),
//                  ),
//                  color: Colors.black12,
//
//                  child: Text(
//                    'No',
//                    style: TextStyle(color: Colors.white, fontSize: 12),
//                  ),
//                  onPressed: ()async{
//                    Navigator.pop(context);
//                  },
//                ),
//
//                RaisedButton(
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(30.0),
//                  ),
//                  color: Colors.redAccent,
//
//                  child: Text(
//                    'Yes',
//                    style: TextStyle(color: Colors.white, fontSize: 14),
//                  ),
//                  onPressed: ()async{
//                    Navigator.pop(context);
//                  },
//                ),
//
//              ],
//            ),
//          );
//        },
//        );
////      }
//    }

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
//
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            curve: Curves.easeInQuad,

            children:[
              SpeedDialChild(
                child: Icon(Icons.add_circle),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                label: "Request Service",
                labelStyle: TextStyle(fontSize: 18),
                onTap: ()=> _showSettingsPanel(context),
              ),

              SpeedDialChild(
                  child: Icon(Icons.delete_sweep),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  label: "Remove Request",
                  labelBackgroundColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 18),
                  onTap: ()=> _deleteService(context),
              )
            ],
          ),

        body:rateList(),

      ),
      ),
    );
  }
}
class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color ;
  final Icon icon;
  final Function onClick;

  CircularButton({this.color,this.width,this.height,this.icon,this.onClick});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color,shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon,enableFeedback: true,onPressed: onClick,),
    );
  }
}

