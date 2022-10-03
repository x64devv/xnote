import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/body.dart';

class AccountSetup extends StatelessWidget {
  const AccountSetup({Key? key}) : super(key: key);
  static String routeName = "/account_setup";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black.withOpacity(0.8),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Body(),
    );
  }
}
