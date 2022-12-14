import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xnote/componets/loading_screeen.dart';
import 'package:xnote/screens/login/components/pin_button.dart';

import '../../../model/database_helper.dart';
import '../../../model/model_user.dart';
import '../../home_screen/home_screen.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  StringBuffer pin = StringBuffer();
  List<UserModel> data = [];

  bool loading = true;

  getUser() async {
    if (!loading) {
      return;
    }
    return await DatabaseHelper().fetchUser().then((value) {
      data = value;
      setState(() {
        loading = false;
      });
    });
  }

  List<List<String>> values = [
    [
      "1",
      "2",
      "3",
    ],
    [
      "4",
      "5",
      "6",
    ],
    [
      "7",
      "8",
      "9",
    ],
    [
      " ",
      "0",
      "DEL",
    ],
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getUser();
    return loading
        ? const LoadingScreen()
        : Container(
            padding: const EdgeInsets.only(top: 16),
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 50,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Welcome back ",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                              text: "${data[0].getName}!",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ))
                        ]),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text("Enter your Pin!", style: GoogleFonts.poppins(fontSize: 18, color: Colors.black)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Can't remember? ", style: GoogleFonts.poppins(fontSize: 12, color: Colors.black)),
                      Text("Tap here.",
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.black, decoration: TextDecoration.underline)),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        4,
                        (index) => Text(
                          "*",
                          style: GoogleFonts.poppins(
                              fontSize: 40,
                              color: (index < pin.length) ? Colors.black : Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Container(
                    width: size.width,
                    height: size.height * 0.60,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      ...List.generate(
                          4,
                          (indexMain) => Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ...List.generate(
                                      3,
                                      (index) => PinButton(
                                          onTap: () {
                                            RegExp regExp = RegExp(r'\d');
                                            if (regExp.hasMatch(values[indexMain][index])) {
                                              setState(() {
                                                pin.write(values[indexMain][index]);
                                              });
                                            } else if (values[indexMain][index] == "DEL" && pin.length > 0) {
                                              setState(() {
                                                pin = StringBuffer(pin.toString().substring(0, pin.length - 1));
                                              });
                                            }

                                            if (pin.length == 4 && pin.toString() == data[0].getPin) {
                                              Navigator.pushNamed(context, HomeScreen.routeName).then((value) {
                                                setState(() {
                                                  
                                                });
                                              });
                                            }
                                          },
                                          text: values[indexMain][index]),
                                    )
                                  ],
                                ),
                              ))
                    ]),
                  ),
                ]));
  }
}
