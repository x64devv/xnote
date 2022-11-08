import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exit = false;
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Warning", style: GoogleFonts.poppins(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
                content: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "You are about to exit the app. Are you sure you want to exit the app?",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: Colors.black),
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  exit = true;
                                  if (Platform.isAndroid) {
                                    SystemNavigator.pop();
                                  }
                                },
                                child: Text(
                                  "Yes",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, color: Colors.black),
                                )),
                            TextButton(
                                onPressed: () {
                                  exit = false;
                                  if (Platform.isAndroid) {
                                    SystemNavigator.pop();
                                  }
                                },
                                child: Text(
                                  "No",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, color: Colors.black),
                                )),
                          ],
                        )
                      ]),
                ),
              );
            });

        return exit;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Body(),
      ),
    );
  }
}
