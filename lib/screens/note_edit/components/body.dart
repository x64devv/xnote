import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:xnote/model/database_helper.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../componets/loading_screeen.dart';
import '../../../model/model_note.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final QuillController _quillController = QuillController.basic();


  bool loading = true;
  List<NoteModel> note = [];

  Future<List<NoteModel>> fetchNote(int id) async {
    note = await DatabaseHelper().fetchNote(id);
    setState(() {
      loading = false;
    });
    return note;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> id = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    fetchNote(id["id"]!);
    
    return loading ? LoadingScreen() : renderBody(note);
  }

  Column renderBody(List<NoteModel> note) {
    if (note.isEmpty){
      note.add(NoteModel(id: 0, folder: "unassigned", dateCreated: DateFormat.yMMMMd().format(DateTime.now()), title: "", notePath: "", notePlainText: ""));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: TextField(
                
                decoration: InputDecoration(
                    hintText: "Enter note title",
                    contentPadding: const EdgeInsets.all(8),
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.poppins(
                        color: Colors.black.withOpacity(0.6), fontSize: 22, fontWeight: FontWeight.w800)),
              ),
            ),
            Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.save_outlined,
                      color: Colors.black,
                      size: 16,
                    ))),
            Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_rounded,
                      color: Colors.black,
                      size: 16,
                    ))),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Colors.black.withOpacity(0.6),
                  size: 16,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    text: "${note[0].getFolder} ~ ",
                    style: GoogleFonts.poppins(
                        color: Colors.black.withOpacity(0.4), fontSize: 12, fontWeight: FontWeight.w800),
                    children: [
                      TextSpan(
                          text: "29 Sept 22",
                          style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.4), fontWeight: FontWeight.w800, fontSize: 12)),
                    ]),
              ),
            ),
          ],
        ),
        QuillToolbar.basic(
          controller: _quillController,
          multiRowsDisplay: false,
        ),
        Expanded(
            child: Container(
          child: QuillEditor.basic(controller: _quillController , readOnly: false),
        ))
      ],
    );
  }
}
