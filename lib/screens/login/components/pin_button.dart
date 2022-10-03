import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PinButton extends StatelessWidget {
  PinButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  VoidCallback onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          width: size.width * 0.25,
          height: size.height * 0.1,
          // decoration: const BoxDecoration(color: Colors.black),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
