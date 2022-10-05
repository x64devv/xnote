import 'package:flutter/material.dart';
import 'package:xnote/model/model_note.dart';

import 'components/body.dart';

class NoteEditScreen extends StatefulWidget {
  NoteEditScreen({Key? key, required this.note}) : super(key: key);
  static String routeName = "/note_edit";
  final NoteModel note;

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final Color iconColor = Colors.black.withOpacity(0.8);

  Color favoriteColor = Colors.yellowAccent;

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
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
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Body(note: widget.note),
    );
  }
}
