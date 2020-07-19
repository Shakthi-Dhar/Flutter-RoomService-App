import 'package:flutter/material.dart';
import 'package:rateandreview/screens/authenticate/authenticate.dart';
import 'package:rateandreview/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:rateandreview/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return home or authentication
    final user = Provider.of<User>(context);
    if( user== null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
