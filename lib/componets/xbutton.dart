import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class XButton extends StatelessWidget {
  VoidCallback onTap;
  IconData? icon;
  String? text;
  bool isIcon;
  Color? color;
  Color? textColor;

  XButton({
    Key? key,
    required this.onTap,
    this.icon,
    this.text,
    this.color = Colors.black,
    this.textColor = Colors.white,
    required this.isIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          width: isIcon ? 60 : double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: isIcon
                ? Icon(
                    icon,
                    color: textColor,
                  )
                : Text(
                    text!,
                    style: GoogleFonts.poppins(fontSize: 18, color: textColor),
                  ),
          ),
        ));
  }
}
