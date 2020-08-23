import 'package:flutter/material.dart';
import 'package:rateandreview/models/rate.dart';
import 'package:provider/provider.dart';

import 'package:rateandreview/screens/home/rate_tile.dart';

class rateList extends StatefulWidget {
  @override
  _rateListState createState() => _rateListState();
}

class _rateListState extends State<rateList> {
  @override
  Widget build(BuildContext context) {
    final rate = Provider.of<List<Rate>>(context) ??[] ;

    return ListView.builder(
      itemCount: rate.length,

      itemBuilder:(context,index){
        return rateTile(rate : rate[index]);

      }
    );
  }
}
