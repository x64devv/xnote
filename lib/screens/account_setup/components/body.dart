import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xnote/componets/xbutton.dart';
import 'package:xnote/screens/login/login_screen.dart';

import 'account_setup_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    return AccoutSetUp( size: size);
  }
}
