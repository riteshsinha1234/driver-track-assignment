import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void routePush(Widget screen) {
  navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => screen));
}

void routePushReplacement(Widget screen) {
  navigatorKey.currentState?.pushReplacement(
    MaterialPageRoute(builder: (_) => screen),
  );
}

void routePushRemoveUntil(Widget screen) {
  navigatorKey.currentState?.pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => screen),
    (route) => false,
  );
}

void kNavigationPop() {
  navigatorKey.currentState?.pop();
}
