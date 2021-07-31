import 'package:flutter/material.dart';
import 'package:pharmacy_store/UI/login/splash_screen.dart';

void main()=>runApp(MyApp());

class  MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          // Define the default brightness and colors.
          primaryColor: Color(0xff59bfff),
          accentColor: Color(0xff59bfff),
        ),
        home: SplashScreen()
    );
  }
}




