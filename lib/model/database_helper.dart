import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xnote/model/model_note.dart';

import 'model_user.dart';

class DatabaseHelper {
  Future<Database> openDb() async {
    WidgetsFlutterBinding.ensureInitialized();

    final database = openDatabase(join(await getDatabasesPath(), 'xnote.db'), onCreate: (db, version) async {
      await db.execute('CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, pin, TEXT)');
      await db.execute(
          'CREATE TABLE notes (id INTEGER, folder TEXT, title TEXT, notePath TEXT, dateCreated TEXT, folder TEXT, notePlainText TEXT)');
    }, version: 1);

    return database;
  }

  Future<bool> insertUser(UserModel user) async {
    final db = await openDb();

    int rowId = await db.insert("user", user.toMap());
    db.close();
    return rowId > 0;
  }

  Future<List<UserModel>> fetchUser() async {
    final db = await openDb();
    final List<Map<String, dynamic>> user = await db.query("user");
    db.close();
    return List.generate(
        user.length, (index) => UserModel(id: user[index]['id'], name: user[index]['name'], pin: user[index]['pin']));
  }

  Future<List<NoteModel>> fetchNotes() async {
    final db = await openDb();
    final List<Map<String, dynamic>> notes = await db.query("notes");
    db.close();
    return List.generate(
        notes.length,
        (index) => NoteModel(
            id: notes[index]['id'],
            folder: notes[index]['folder'],
            title: notes[index]['title'],
            notePath: notes[index]['notePath'],
            dateCreated: notes[index]['dateCreated'],
            notePlainText: notes[index]['notePlainText']));
  }

  Future<List<NoteModel>> fetchFolderNotes(String folder) async {
    final db = await openDb();
    final List<Map<String, dynamic>> notes = await db.query("notes", where: "folder = ?", whereArgs: [folder]);
    db.close();
    return List.generate(
        notes.length,
        (index) => NoteModel(
            id: notes[index]['id'],
            folder: notes[index]['folder'],
            title: notes[index]['title'],
            notePath: notes[index]['notePath'],
            dateCreated: notes[index]['dateCreated'],
            notePlainText: notes[index]['notePlainText']));
  }

  Future<NoteModel> fetchNote(int id) async {
    final db = await openDb();
    final List<Map<String, dynamic>> notes = await db.query("notes", where: "id = ?", whereArgs: [id.toString()]);
    db.close();
    if (notes.isEmpty) {
      return NoteModel.defaultNote();
   
    } else {
      return NoteModel(
          id: notes[0]['id'],
          folder: notes[0]['folder'],
          title: notes[0]['title'],
          notePath: notes[0]['notePath'],
          dateCreated: notes[0]['dateCreated'],
          notePlainText: notes[0]['notePlainText']);
    }
  }

  Future<bool> insertNote(NoteModel note) async {
    final db = await openDb();
    final int rowId = await db.insert("notes", note.toMap());
    db.close();
    return rowId > 0;
  }

  Future<bool> updateNote(NoteModel note) async {
    final db = await openDb();
    final int numberOfChanges = await db.update("notes", note.toMap(),
        where: 'id = ?', whereArgs: [note.getId], conflictAlgorithm: ConflictAlgorithm.replace);
    db.close();
    return numberOfChanges > 0;
  }

  Future<bool> insertFolder(String folderName) async {
    final db = await openDb();
    final int rowId = await db.insert("folders", {"name": folderName});
    db.close();
    return rowId > 0;
  }

  Future<List<String>> fetchFolders() async {
    final db = await openDb();
    final List<Map<String, dynamic>> folders = await db.query("folders");
    db.close();
    return List.generate(folders.length, (index) => folders[index]['name']);
  }

  Future<bool> deleteNote(int id) async {
    final db = await openDb();
    final deletedRow = await db.delete("notes", where: "id = ?", whereArgs: [id.toString()]);
    db.close();
    return deletedRow == id;
  }

  Future<bool> deleteFolder(int id) async {
    final db = await openDb();
    final deleted = await db.delete("folders", where: 'id = ?', whereArgs: [id.toString()]);
    db.close();
    return deleted == id;
  }

  Future<List<Map<String, String>>> fetchFolderInfo() async {
    final notes = await fetchNotes();
    List<String> folders = [];
    List<Map<String, String>> folderInfo = [];
    for (var note in notes) {
      if (!folders.contains(note.getFolder)) {
        folders.add(note.getFolder);
      }
    }

    for (var folder in folders) {
      folderInfo.add({"folder": folder, "count": noteCount(folder, notes).toString()});
    }
    return folderInfo;
  }
}

int noteCount(String folder, List<NoteModel> notes) {
  int count = 0;
  for (var note in notes) {
    if (note.getFolder == folder) {
      count += 1;
    }
  }
  return count;
}
