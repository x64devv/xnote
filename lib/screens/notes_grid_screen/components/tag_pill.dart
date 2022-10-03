import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagPill extends StatelessWidget {
  final String text;
  final bool showIcon;

  const TagPill({
    Key? key,
    required this.text,
    required this.showIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Visibility(
            visible: showIcon,
            child: Icon(
              Icons.filter_alt_outlined,
              size: 16,
              color: Colors.grey.withOpacity(0.6),
            ),
          ),
          Text(text, style: GoogleFonts.poppins(fontSize: 12)),
        ],
      ),
    );
  }
}
