import 'package:intl/intl.dart';

class NoteModel {
  int? id;
  String? folder;
  String? title;
  String? notePath;
  String? dateCreated;
  String? notePlainText;

  NoteModel({this.id, this.folder, this.title, this.notePath, this.dateCreated, this.notePlainText});

  dynamic get getTitle {
    return title;
  }

  dynamic get getId {
    return id;
  }

  dynamic get getFolder {
    return folder;
  }

  dynamic get getNotePath {
    return notePath;
  }

  dynamic get getDateCreated {
    return dateCreated;
  }

  dynamic get getNotePlainText {
    return notePlainText;
  }

  set setFolder(String folder) {
    this.folder = folder;
  }

  set setTitle(String title) {
    this.title = title;
  }

  set setNotePath(String notePath) {
    this.notePath = notePath;
  }

  set setDateCreated(String dateCreated) {
    this.dateCreated = dateCreated;
  }

  set setNotePlainText(String notePlainText) {
    this.notePlainText = notePlainText;
  }
  // MNote(this.title, this.notePath, this.dateCreated, this.folder, this.notePlainText);

  Map<String, dynamic> toMap() {
    return {
      "folder": folder,
      "title": title,
      "notePath": notePath,
      "dateCreated": dateCreated,
      "notePlainText": notePlainText,
    };
  }

static NoteModel defaultNote({String folder="unassigned"}) {
    return NoteModel(
        id: 0,
        folder: folder,
        dateCreated: DateFormat.yMMMMd().format(DateTime.now()),
        title: "",
        notePath: "",
        notePlainText: "");
  }
}
