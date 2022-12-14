import 'package:flutter/material.dart';
import 'package:xnote/model/model_note.dart';

import '../note_edit/note_edit_screen.dart';
import 'components/body.dart';

class NotesGridScreen extends StatefulWidget {
  const NotesGridScreen({Key? key}) : super(key: key);
  static String routeName = "/folder";

  @override
  State<NotesGridScreen> createState() => _NotesGridScreenState();
}

class _NotesGridScreenState extends State<NotesGridScreen> {
  @override
  Widget build(BuildContext context) {
    var folder = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black.withOpacity(0.8),
            ),
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            }),
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.add_rounded,
                color: Colors.black.withOpacity(0.8),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => NoteEditScreen(note: NoteModel.defaultNote(folder: folder)))).then((value){setState(() {
                      
                    });});
              }),
        ],
        backgroundColor: Colors.white,
      ),
      body: Body(
        folder: folder,
      ),
    );
  }
}
