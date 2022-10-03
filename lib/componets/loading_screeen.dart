import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        const CircularProgressIndicator(
          color: Colors.black,
        ),
        Text(
          "Please wait ...",
          style: GoogleFonts.poppins(fontSize: 14),
        )
      ]),
    );
  }
}
