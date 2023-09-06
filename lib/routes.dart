import 'package:app1flutter/screens/dashboard_screen.dart';
import 'package:flutter/widgets.dart';

Map<String,WidgetBuilder> getRoutes(){
  return{
    '/dash' : (BuildContext context) => const DashboardScreen() 
  };
}