import 'package:driver_track/components/colors.dart';
import 'package:driver_track/components/text.dart';
import 'package:flutter/material.dart';

//screen size
SizedBox gapH(double value) => SizedBox(height: value);
SizedBox gapW(double value) => SizedBox(width: value);
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

//Buttons
// ignore: strict_top_level_inference
Widget customButton(ht, wt, btnclr, bdrclr, rdus, clk, widget) {
  return MaterialButton(
    highlightColor: Colors.black,
    elevation: 0.0,
    height: ht,
    minWidth: wt,
    color: btnclr,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(rdus),
      side: BorderSide(color: bdrclr),
    ),
    onPressed: clk,
    child: widget,
  );
}

// AppBar
AppBar customAppBar(String title, Color color) {
  return AppBar(
    backgroundColor: black,
    title: customTxt(title, 20, color, FontWeight.w500),
    centerTitle: true,
    automaticallyImplyLeading: false,
  );
}

//body
Widget customBody({PreferredSizeWidget? appBar, required Widget child}) {
  return Scaffold(backgroundColor: white, appBar: appBar, body: child);
}
