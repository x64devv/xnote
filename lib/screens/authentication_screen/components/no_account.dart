import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xnote/screens/account_setup/account_setup.dart';

import '../../../componets/xbutton.dart';

class NoAccount extends StatelessWidget {
  const NoAccount({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              "assets/icons/journal-richtext.svg",
              height: size.width * 0.2,
              width: size.width * 0.2,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Text(
              "No Account found!",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AnimatedTextKit(repeatForever: true, animatedTexts: [
              TyperAnimatedText("1. Tap Setup Account,",
                  textAlign: TextAlign.center,
                  textStyle: GoogleFonts.poppins(fontSize: 18),
                  speed: const Duration(milliseconds: 40)),
              TyperAnimatedText("2. Enter your details and get setup,",
                  textAlign: TextAlign.center,
                  textStyle: GoogleFonts.poppins(fontSize: 18),
                  speed: const Duration(milliseconds: 40)),
              TyperAnimatedText("3. Start entering your notes with xnote,",
                  textAlign: TextAlign.center,
                  textStyle: GoogleFonts.poppins(fontSize: 18),
                  speed: const Duration(milliseconds: 40)),
            ]),
          ),
          SizedBox(
            height: size.height * .25,
          ),
          XButton(
            onTap: () {
              Navigator.pushNamed(context, AccountSetup.routeName);
            },
            isIcon: false,
            text: "Setup Account",
          )
        ]);
  }
}
