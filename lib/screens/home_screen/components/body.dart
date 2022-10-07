import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xnote/componets/xbutton.dart';
import 'package:xnote/model/database_helper.dart';
import 'package:xnote/screens/note_edit/note_edit_screen.dart';
import 'package:xnote/screens/notes_grid_screen/notes_grid_screen.dart';

import '../../../model/model_note.dart';
import 'folder_card.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);
  List<Map<String, String>> folders = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
              top: size.height * 0.04,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "folders",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const Icon(
                      Icons.folder,
                      color: Colors.white,
                      size: 25,
                    )
                  ],
                ),
              )),
          Positioned(
            top: size.height * 0.09,
            child: Container(
              width: size.width,
              height: size.height * 0.88,
              child: SingleChildScrollView(
                child: FutureBuilder(
                  initialData: folders,
                  future: DatabaseHelper().fetchFolderInfo(),
                  builder: (context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...List.generate(
                              snapshot.data!.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        NotesGridScreen.routeName,
                                        arguments: snapshot.data![index]["folder"]!,
                                      );
                                    },
                                    child: FolderCard(
                                        size: size,
                                        name: snapshot.data![index]["folder"]!,
                                        itemCount: int.parse(snapshot.data![index]["count"]!)),
                                  ))
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
              bottom: size.height * 0.03,
              right: size.width * 0.0025,
              child: XButton(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteEditScreen(note: NoteModel.defaultNote())));
                },
                isIcon: true,
                icon: Icons.add,
                color: Colors.pink,
              )),
        ],
      ),
    );
  }
}
