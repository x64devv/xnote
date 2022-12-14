import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xnote/model/database_helper.dart';

import '../../../model/model_note.dart';
import '../../note_edit/note_edit_screen.dart';
import 'note_card.dart';
import 'tag_pill.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.folder}) : super(key: key);
  final String folder;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> tags = [
    "filters",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "${widget.folder} notes",
                style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(
                        tags.length,
                        (index) => TagPill(
                              text: tags[index],
                              showIcon: (index == 0),
                            ))
                  ],
                ),
              ),
              FutureBuilder(
                future: DatabaseHelper().fetchFolderNotes(widget.folder),
                initialData: const <NoteModel>[],
                builder: (context, AsyncSnapshot<List<NoteModel>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      padding: const EdgeInsets.only(top: 16),
                      width: size.width * 0.95,
                      height: size.height * 0.7725,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
                      child: MasonryGridView.count(
                          itemCount: snapshot.data!.length,
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NoteEditScreen(note: snapshot.data![index]))).then((value) {
                                        setState(() {});
                                      });
                                    },
                            child: NoteCard(
                                  size: size,
                                  index: index,
                                  note: snapshot.data![index],
                                ),
                          )));
                } else
                  return Container();
              })
            ])));
  }
}
