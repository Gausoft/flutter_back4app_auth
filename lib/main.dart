import 'package:flutter/material.dart';
import 'package:flutter_back4app_auth/screens/login_screen.dart';

void main() => runApp(AuthApp());

class AuthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Back4App Auth',
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(248, 249, 250, 1),
        primaryColor: Color.fromRGBO(81, 81, 81, 1),
        accentColor: Color.fromRGBO(207, 207, 207, 1),
        buttonColor: Colors.white,
        bottomAppBarColor: Color.fromRGBO(0, 123, 255, 1),
        fontFamily: 'GoogleSans',
        textTheme: TextTheme(
          headline: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w500,
          ),
          body1: TextStyle(
            fontSize: 15.0,
            fontStyle: FontStyle.normal,
          ),
          title: TextStyle(
            fontSize: 18.0,
            fontStyle: FontStyle.normal,
          ),
          subtitle: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.normal,
          ),
          display1: TextStyle(
            fontSize: 13.0,
            fontStyle: FontStyle.normal,
            color: Color.fromRGBO(81, 81, 81, 1),
          ),
          button: TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}
