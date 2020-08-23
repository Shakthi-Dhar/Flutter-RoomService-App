import 'package:flutter/material.dart';
import 'package:rateandreview/models/rate.dart';
class rateTile extends StatelessWidget {

  final Rate rate;
  rateTile({this.rate});


  @override
  Widget build(BuildContext context) {
//    if(rate.room == 620) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        child: Card(
          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
          color: Colors.white.withOpacity(0.7),
          child:
          ListTile(
            leading:
            Icon(Icons.local_hotel, color: Colors.black, size: 35,),
            title:
            RichText(text: TextSpan(children: [
              TextSpan(text: '${rate.name}  ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
              TextSpan(text: '${rate.reg_no}', style: TextStyle(color: Colors.black, fontSize: 16)),
            ])),
//            Text('${rate.name} | ${rate.reg_no}'),
            subtitle:
            RichText(text: TextSpan(children: [
              TextSpan(text: '${rate.room}  |  ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14)),
              TextSpan(text: '${rate.time}', style: TextStyle(color: Colors.black, fontSize: 14))
            ])),
//            Text('Room: ${rate.room} | Time: ${rate.time}'),
//          title: Text(userData.name),
//          subtitle: Text('Room no: ${userData.room} | Time: ${userData.time}  '),
          ),
        ),
      );
//    }
//    else{
//      return Container(
//
//      );
//    }
  }
}
