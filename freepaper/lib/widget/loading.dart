import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:freepaper/widget/custom.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(

          children: [
            Container(
              child: SpinKitRing(
                color: white,
                size: MediaQuery.of(context).size.height/10,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text("Please wait", style: TextStyle(color: white, fontSize: 16, ),),
            ),
          ],
        ),
      ),
    );
  }
}
