import 'package:flutter/material.dart';
import 'package:xnote/routes.dart';
import 'package:xnote/screens/authentication_screen/authentication_screen.dart';
import 'package:xnote/screens/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: AuthenticationScreen.routeName,
    );
  }
}