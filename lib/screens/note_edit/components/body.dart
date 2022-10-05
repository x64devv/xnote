import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quil;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:xnote/model/database_helper.dart';
import 'package:xnote/model/file_handler.dart';

import '../../../componets/loading_screeen.dart';
import '../../../model/model_note.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.note}) : super(key: key);
  final NoteModel note;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  quil.QuillController _controller = quil.QuillController.basic();
  String title = "";

  @override
  Widget build(BuildContext context) {
    loadDocument(widget.note);
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
                    onPressed: () async {
                      if(widget.note.id == 0){
                        widget.note.title = title;
                        widget.note.notePlainText = _controller.document.toPlainText();
                        await DatabaseHelper().insertNote(widget.note).then((value){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.transparent,
                              content: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
                                  child: Center(
                                      child: Row(children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white),
                                            borderRadius: BorderRadius.circular(16)),
                                        child: Icon( value?
                                          Icons.done_rounded: Icons.cancel_outlined,
                                          color: Colors.white,
                                        )),
                                    Text("${widget.note.title} save ${value ? "Success" : "failed"}"),
                                  ])))));
                        });
                        
                      }
                    },
                    icon: const Icon(
                      Icons.save_outlined,
                      color: Colors.black,
                      size: 16,
                    ))),
            Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Note Folder",
                                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                      child: TextFormField(
                                        initialValue: widget.note.getFolder,
                                        onChanged: (value) {
                                          widget.note.folder = value;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Note Folder",
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                            hintStyle: GoogleFonts.poppins(fontSize: 16),
                                            border: InputBorder.none,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                                      ),
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Save",
                                        style: GoogleFonts.poppins(fontSize: 16),
                                      ))
                                ],
                              ));
                    },
                    icon: const Icon(
                      Icons.create_new_folder_outlined,
                      color: Colors.black,
                      size: 16,
                    ))),
          ],
        ),
        Row(
          children: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.edit,
          //         color: Colors.black.withOpacity(0.6),
          //         size: 16,
          //       )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    text: "${widget.note.getFolder} ~ ",
                    style: GoogleFonts.poppins(
                        color: Colors.black.withOpacity(0.4), fontSize: 12, fontWeight: FontWeight.w800),
                    children: [
                      TextSpan(
                          text: " ${widget.note.dateCreated}",
                          style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.4), fontWeight: FontWeight.w800, fontSize: 12)),
                    ]),
              ),
            ),
          ],
        ),
        quil.QuillToolbar.basic(
          controller: _controller,
          multiRowsDisplay: false,
        ),
        Expanded(
            child: Container(
          child: quil.QuillEditor.basic(controller: _controller, readOnly: false),
        ))
      ],
    );
  }


  loadDocument(NoteModel note) async {
    if (note.id != 0) {
      final noteData = await readFile(note.notePath!);
      setState(() {
        var data = jsonDecode(noteData);
        _controller = quil.QuillController(document: quil.Document.fromJson(data), selection: const TextSelection(baseOffset: 0, extentOffset: 1));
      });
    }
  }
}
