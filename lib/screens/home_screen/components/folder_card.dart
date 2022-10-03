import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xnote/screens/notes_grid_screen/notes_grid_screen.dart';

class FolderCard extends StatelessWidget {
  const FolderCard({
    Key? key,
    required this.size,
    required this.name,
    required this.itemCount,
  }) : super(key: key);

  final Size size;
  final String name;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 8),
      height: size.height * 0.3,
      width: size.width * 0.9,
      decoration: BoxDecoration(color: const Color.fromARGB(255, 18, 18, 18), borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name.toLowerCase(),
                  style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.6), fontSize: 16),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, NotesGridScreen.routeName);
                    },
                    child: const Icon(
                      Icons.chevron_right_outlined,
                      size: 20,
                      color: Colors.white,
                    )),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              itemCount.toString(),
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
