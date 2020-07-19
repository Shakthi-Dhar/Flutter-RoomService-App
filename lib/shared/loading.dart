import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:new BoxDecoration(
          image:  new DecorationImage(
            image: new AssetImage("images/city.jpg"),
            fit: BoxFit.cover,)
      ),
      child:
      Center(
        child:
        SpinKitPumpingHeart(
          color: Colors.white.withOpacity(0.6),
          size: 300,
        ),
      ),

    );
  }
}
