import 'package:driver_track/components/colors.dart';
import 'package:driver_track/components/text.dart';
import 'package:flutter/material.dart';

// Screen size
SizedBox gapH(double value) => SizedBox(height: value);
SizedBox gapW(double value) => SizedBox(width: value);
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

// Buttons
// ignore: strict_top_level_inference
Widget customButton(ht, wt, btnclr, bdrclr, rdus, clk, widget) {
  return MaterialButton(
    highlightColor: splashCyan,
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

// Body
Widget customBody({
  PreferredSizeWidget? appBar,
  required Widget child,
  Color backgroundColor = white,
}) {
  return Scaffold(
    backgroundColor: backgroundColor,
    appBar: appBar,
    body: child,
  );
}

// Bottom Navigation
Widget bottomNavigation() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 13),
    decoration: BoxDecoration(
      color: white,
      border: Border(top: BorderSide(color: blueGrey.withValues(alpha: 0.15))),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        navItem(Icons.home_rounded, "Home", true),
        navItem(Icons.location_on_outlined, "Tracking", false),
        navItem(Icons.history_rounded, "History", false),
        navItem(Icons.person_outline_rounded, "Profile", false),
      ],
    ),
  );
}

Widget navItem(IconData icon, String title, bool selected) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 23, color: selected ? electricBlue : blueGrey),
      gapH(5),
      customTxt(
        title,
        10,
        selected ? electricBlue : blueGrey,
        selected ? FontWeight.w700 : FontWeight.w500,
      ),
    ],
  );
}

// Action Card
Widget actionCard(IconData icon, String title, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: blueGrey.withValues(alpha: 0.15)),
    ),
    child: Column(
      children: [
        Icon(icon, size: 27, color: color),
        gapH(10),
        customTxt(title, 12, navyBlue, FontWeight.w600),
      ],
    ),
  );
}

// Statistics Card
Widget statCard(IconData icon, String title, String value, Color color) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: blueGrey.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 21),
        ),
        gapH(15),
        customTxt(value, 21, navyBlue, FontWeight.w800),
        gapH(5),
        customTxt(title, 12, blueGrey, FontWeight.w500),
      ],
    ),
  );
}

// Overview Item
Widget overviewItem(IconData icon, String title, String value) {
  return Row(
    children: [
      Icon(icon, color: splashCyan, size: 25),
      gapW(10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTxt(value, 21, white, FontWeight.w800),
            gapH(3),
            customTxt(title, 11, blueGrey, FontWeight.w500),
          ],
        ),
      ),
    ],
  );
}
