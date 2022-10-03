import 'package:flutter/material.dart';

import 'components/body.dart';

class NotesGridScreen extends StatelessWidget {
  const NotesGridScreen({Key? key}) : super(key: key);
  static String routeName = "/folder";
  @override
  Widget build(BuildContext context) {
    String folder = ModalRoute.of(context)!.settings.arguments as String;

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
            }),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Body(folder: folder,),
    );
  }
}
