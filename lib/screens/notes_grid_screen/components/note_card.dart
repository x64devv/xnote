import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xnote/screens/note_edit/note_edit_screen.dart';

import '../../../model/model_note.dart';

class NoteCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteEditScreen(note: note)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: size.width * 0.45,
        height: index.isEven ? size.height * 0.3 : size.height * 0.15,
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.getTitle,
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const Expanded(
              child: SizedBox(height: 8),
            ),
            Text(
              note.getNotePlainText,
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w200),
              overflow: TextOverflow.ellipsis,
              maxLines: index.isEven ? 8 : 3,
            ),
          ],
        ),
      ),
    );
  }
}
