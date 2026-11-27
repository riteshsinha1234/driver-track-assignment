import 'package:driver_track/components/colors.dart';
import 'package:driver_track/components/text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
      borderRadius: BorderRadius.circular(rdus.toDouble()),
      side: BorderSide(color: bdrclr),
    ),
    onPressed: clk,
    child: widget,
  );
}

// Body
Widget customBody({
  PreferredSizeWidget? appBar,
  required Widget child,
  Color backgroundColor = splashBackground,
}) {
  return Scaffold(
    backgroundColor: backgroundColor,
    appBar: appBar,
    body: child,
  );
}

// Bottom Navigation Bar
Widget bottomNavigationBar(
  BuildContext context, {
  required int selectedIndex,
  required VoidCallback onHomeTap,
  required VoidCallback onTrackingTap,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 3.5.w),
    decoration: BoxDecoration(
      color: logoBackground,
      border: Border(top: BorderSide(color: logoBorder)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: onHomeTap,
          child: navItem(Icons.home_rounded, "Home", selectedIndex == 0),
        ),
        GestureDetector(
          onTap: onTrackingTap,
          child: navItem(
            Icons.location_on_outlined,
            "Tracking",
            selectedIndex == 1,
          ),
        ),
      ],
    ),
  );
}

// Navigation Item
Widget navItem(IconData icon, String title, bool selected) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 6.w, color: selected ? splashCyan : loadingText),
      gapH(1.2.w),
      customTxt(
        title,
        14,
        selected ? splashCyan : splashText,
        selected ? FontWeight.w700 : FontWeight.w500,
      ),
    ],
  );
}

// Action Card
Widget actionCard(IconData icon, String title, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 4.5.w, horizontal: 3.w),
    decoration: BoxDecoration(
      color: logoBackground,
      borderRadius: BorderRadius.circular(4.w),
      border: Border.all(color: logoBorder),
    ),
    child: Column(
      children: [
        Icon(icon, size: 7.w, color: color),
        gapH(2.5.w),
        customTxt(title, 12, white, FontWeight.w600),
      ],
    ),
  );
}

// Statistics Card
Widget statCard(IconData icon, String title, String value, Color color) {
  return Container(
    padding: EdgeInsets.all(4.w),
    decoration: BoxDecoration(
      color: logoBackground,
      borderRadius: BorderRadius.circular(4.w),
      border: Border.all(color: logoBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 10.w,
          width: 10.w,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Icon(icon, color: color, size: 5.5.w),
        ),
        gapH(4.w),
        customTxt(value, 20, white, FontWeight.w800),
        gapH(1.2.w),
        customTxt(title, 14, splashText, FontWeight.w500),
      ],
    ),
  );
}

// Overview Item
Widget overviewItem(IconData icon, String title, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(top: 1.5.w),
        child: Icon(icon, color: splashCyan, size: 6.w),
      ),
      gapW(2.w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTxt(value, 20, white, FontWeight.w600),
            gapH(0.8.w),
            customTxt(title, 12.5, splashText, FontWeight.w700),
          ],
        ),
      ),
    ],
  );
}
