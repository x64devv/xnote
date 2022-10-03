import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xnote/model/database_helper.dart';
import 'package:xnote/model/model_user.dart';
import 'package:xnote/screens/authentication_screen/components/no_account.dart';
import 'package:xnote/screens/login/components/log_in.dart';

import '../../../componets/loading_screeen.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<UserModel> data = [];

  bool loading = true;

  getUser() async {
    if (!loading) {
      return;
    }
    return await DatabaseHelper().fetchUser().then((value) {
      data = value;
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getUser();
    return SafeArea(
        child: loading
            ? const LoadingScreen()
            : Container(
                child: data.isEmpty ? NoAccount(size: size) : LogIn(),
              ));
  }
}
