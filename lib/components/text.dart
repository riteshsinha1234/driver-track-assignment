import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Text customTxt(
  String text,
  double size,
  Color clr,
  FontWeight weight, {
  double? letterSpacing,
}) {
  return Text(
    text,
    style: TextStyle(
      color: clr,
      fontSize: size.sp,
      fontWeight: weight,
      fontFamily: "PlusJakartaSans",
      letterSpacing: letterSpacing,
    ),
  );
}

Text customParaTxt(
  String txt,
  double size,
  Color clr,
  FontWeight weight,
  TextAlign align, {
  double? letterSpacing,
}) {
  return Text(
    txt,
    textAlign: align,
    style: TextStyle(
      color: clr,
      fontSize: size.sp,
      fontWeight: weight,
      fontFamily: "PlusJakartaSans",
      letterSpacing: letterSpacing,
    ),
  );
}
