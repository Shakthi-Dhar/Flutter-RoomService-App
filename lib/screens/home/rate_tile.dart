import 'package:flutter/material.dart';
import 'package:rateandreview/models/rate.dart';

class rateTile extends StatelessWidget {

  final Rate rate;
  rateTile({this.rate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3,vertical: 5),
      child: Card(
        margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
        color: Colors.white.withOpacity(0.7),
        child: ListTile(
          leading: Icon(Icons.local_hotel, color: Colors.black,size: 35,),
          title: Text(rate.name),
          subtitle: Text('Room no: ${rate.room} | Time: ${rate.time}  '),
          
        ),
      ),
    );
  }
}
