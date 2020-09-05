import 'package:codelab_register_login/view/home_page.dart';
import 'package:codelab_register_login/view/login_page.dart';
import 'package:codelab_register_login/view/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    Register.tag: (context) => Register(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Register Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}