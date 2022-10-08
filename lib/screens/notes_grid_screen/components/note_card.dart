import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xnote/screens/note_edit/note_edit_screen.dart';

import '../../../model/model_note.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({
    Key? key,
    required this.note,
    required this.size,
    required this.index,
  }) : super(key: key);

  final Size size;
  final int index;
  final NoteModel note;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: widget.size.width * 0.45,
      height: widget.index.isEven ? widget.size.height * 0.3 : widget.size.height * 0.15,
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.note.getTitle,
            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            widget.note.getNotePlainText,
            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w200),
            overflow: TextOverflow.ellipsis,
            maxLines: widget.index.isEven ? 8 : 3,
          ),
        ],
      ),
    );
  }
}
