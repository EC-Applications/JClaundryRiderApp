import 'package:efood_multivendor_driver/helper/route_helper.dart';
import 'package:flutter/material.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  final Function() stopTimer;
  final Function() startTimer;

  CustomNavigatorObserver({@required this.stopTimer, @required this.startTimer});
  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != RouteHelper.getInitialRoute()) {
      stopTimer();
    }
    if(route.settings.name == RouteHelper.getInitialRoute()) {
      startTimer();
    }
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    if (newRoute.settings.name == RouteHelper.getInitialRoute()) {
      startTimer();
    }
  }

}