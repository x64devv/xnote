import 'package:flutter/material.dart';
import 'package:xnote/screens/authentication_screen/components/body.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);
  static String routeName = "/authentication";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
