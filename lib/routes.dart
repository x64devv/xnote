import 'package:flutter/material.dart';
import 'package:xnote/screens/account_setup/account_setup.dart';
import 'package:xnote/screens/authentication_screen/authentication_screen.dart';
import 'package:xnote/screens/home_screen/home_screen.dart';
import 'package:xnote/screens/login/login_screen.dart';
import 'package:xnote/screens/note_edit/note_edit_screen.dart';
import 'package:xnote/screens/notes_grid_screen/notes_grid_screen.dart';

final Map<String, WidgetBuilder> routes = {
  AuthenticationScreen.routeName: (context) => AuthenticationScreen(),
  AccountSetup.routeName: (context) => AccountSetup(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  NotesGridScreen.routeName: (context) => NotesGridScreen(),
  
};
