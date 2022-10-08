import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:google_fonts/google_fonts.dart';
import 'package:xnote/model/database_helper.dart';
import 'package:xnote/model/file_handler.dart';
import '../../../model/model_note.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.note}) : super(key: key);
  final NoteModel note;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  QuillController _controller = QuillController.basic();
  String title = "";

  @override
  Widget build(BuildContext context) {
    // loadDocument(widget.note);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                initialValue: widget.note.title,
                onChanged: (value) {
                  widget.note.title = value;
                },
                decoration: InputDecoration(
                    hintText: "Enter note title",
                    contentPadding: const EdgeInsets.all(8),
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.poppins(
                        color: Colors.black.withOpacity(0.6), fontSize: 22, fontWeight: FontWeight.w800)),
              ),
            ),
            IconButton(
                onPressed: () async {
                  if (widget.note.id == 0) {
                    await DatabaseHelper().insertNote(widget.note).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.transparent,
                          content: MyToast(
                            widget: widget,
                            value: value,
                            message: "save",
                          )));
                    });
                  } else {
                    debugPrint("id : ${widget.note.id} rest of data: ${widget.note.toMap()}");
                    await DatabaseHelper().updateNote(widget.note).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.transparent,
                          content: MyToast(
                            widget: widget,
                            value: value,
                            message: "save",
                          )));
                    });
                  }
                },
                icon: const Icon(
                  Icons.save_outlined,
                  color: Colors.black,
                  size: 20,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Note Folder",
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                            content: Container(
                              width: double.maxFinite,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black)),
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
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {});
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
                  size: 20,
                )),
            IconButton(
              onPressed: () async {
                if (widget.note.id == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.transparent,
                      content: MyToast(widget: widget, value: false, message: "delete")));
                } else {
                  await DatabaseHelper().deleteNote(widget.note.id!).then((value) {
                    Navigator.pop(context);
                  });
                }
              },
              icon: const Icon(Icons.delete_forever),
            ),
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
        // QuillToolbar.basic(
        //   controller: _controller,
        //   multiRowsDisplay: false,
        // ),
        // Expanded(
        //     child: Container(
        //       margin: const EdgeInsets.only(left: 8, right: 8),
        //   child: QuillEditor.basic(controller: _controller, readOnly: false),
        // ))

        Expanded(
          child: TextFormField(
            initialValue: widget.note.notePlainText,
            onChanged: (value) {
              widget.note.notePlainText = value;
            },
            onFieldSubmitted: (value) {
              widget.note.notePlainText = value;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 8, right: 8),
              hintText: "Type here ...",
              hintStyle: GoogleFonts.poppins(fontSize: 16, color: Colors.black.withOpacity(0.6)),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  loadDocument(NoteModel note) async {
    if (note.id != 0) {
      final noteData = await readFile(note.notePath!);
      setState(() {
        var data = jsonDecode(noteData);
        _controller = QuillController(
            document: Document.fromJson(data),
            selection: const TextSelection.collapsed(
              offset: 0,
            ));
      });
    }
  }
}

class MyToast extends StatelessWidget {
  const MyToast({
    Key? key,
    required this.widget,
    required this.value,
    required this.message,
  }) : super(key: key);

  final Body widget;
  final bool value;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        height: 48,
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(32)),
        child: Center(
            child: Row(children: [
          Container(
              margin: const EdgeInsets.all(8),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(16)),
              child: Icon(
                value ? Icons.done_rounded : Icons.cancel_rounded,
                color: Colors.white,
              )),
          Text(" ${widget.note.title} $message ${value ? "Success" : "failed"}".toLowerCase()),
        ])));
  }
}
