import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xnote/model/database_helper.dart';
import 'package:xnote/model/model_user.dart';

import '../../../componets/xbutton.dart';
import '../../login/login_screen.dart';

class AccoutSetUp extends StatefulWidget {
  AccoutSetUp({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<AccoutSetUp> createState() => _AccoutSetUpState();
}

class _AccoutSetUpState extends State<AccoutSetUp> {
  final _formKey = GlobalKey<FormState>();

  final String KPinMatchError = "Pins don't match";

  final String KPinLengthError = "Pin must be 4 digits long";

  final String KNameLengthError = "Name can't be empty";

  List<String> errors = [];

  String name = "";

  String pin = "";

  String confirmPin = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Account Setup",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          if (errors.contains(KNameLengthError)) {
                            errors.remove(KNameLengthError);
                          }
                        });
                        name = value;
                      }
                    },
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        name = value;
                      } else {
                        if (!errors.contains(KNameLengthError)) {
                          setState(() {
                            errors.add(KNameLengthError);
                          });
                        }
                        return "";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        hintText: "Enter you Name",
                        hintStyle: GoogleFonts.poppins(fontSize: 20, color: Colors.grey)),
                  ),
                  SizedBox(height: widget.size.height * 0.05),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 4) {
                        setState(() {
                          if (errors.contains(KPinLengthError)) {
                            errors.remove(KPinLengthError);
                          }
                        });
                        pin = value;
                      }
                    },
                    validator: (value) {
                      if (value!.length != 4) {
                        setState(() {
                          if (!errors.contains(KPinLengthError)) {
                            errors.add(KPinLengthError);
                          }
                        });
                        return "";
                      }
                      pin = value;
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        hintText: "Enter pin",
                        hintStyle: GoogleFonts.poppins(fontSize: 20, color: Colors.grey)),
                  ),
                  SizedBox(height: widget.size.height * 0.05),
                  TextFormField(
                    onChanged: (value) {
                      if (value == pin) {
                        setState(() {
                          if (errors.contains(KPinMatchError)) {
                            errors.remove(KPinMatchError);
                          }
                        });
                      }
                    },
                    validator: (value) {
                      if (value != pin) {
                        setState(() {
                          if (!errors.contains(KPinMatchError)) {
                            errors.add(KPinMatchError);
                          }
                        });
                        return "";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        hintText: "Confirm pin",
                        hintStyle: GoogleFonts.poppins(fontSize: 20, color: Colors.grey)),
                  ),
                  SizedBox(height: widget.size.height * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                          errors.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                    Text(errors[index], style: GoogleFonts.poppins(fontSize: 12, color: Colors.red)),
                                  ],
                                ),
                              ))
                    ],
                  ),
                  XButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        UserModel user = UserModel(name: name, pin: pin);
                        await DatabaseHelper().insertUser(user).then((value) {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                          debugPrint("Inserting user: ${value ? "Success" : "Failed"}");
                        });
                        // if all are valid then go to success screen

                      }
                    },
                    isIcon: false,
                    text: "Setup",
                  )
                ]))
          ],
        ),
      ),
    );
  }
}

var outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(16),
  borderSide: const BorderSide(color: Colors.grey),
  gapPadding: 8,
);
