import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minecraftservercontroller/main.dart';
import 'package:minecraftservercontroller/mainpage.dart';
import 'package:minecraftservercontroller/utils/Save_Load.dart';
import 'package:minecraftservercontroller/utils/networkingfuctions.dart';

Color IconColor = Color.fromARGB(255, 70, 111, 140);
Color textColor = Color.fromARGB(255, 207, 207, 207);
Color BorderColor = Colors.black;
Color fillColor = Color.fromARGB(255, 20, 36, 51);
Color ShadowColor = Color.fromARGB(255, 0, 0, 0);
Color dimmedColor = Color.fromARGB(255, 133, 133, 133);

double borderradius = 7;

String loginusername = "";
String loginpassword = "";

class LoginPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/background_2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: (Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(
                        fontFamily: "SoruceSansVariable",
                        fontWeight: FontWeight.w400,
                        fontSize: 36,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Please sign in to continue.",
                    style: TextStyle(
                        fontFamily: "SoruceSansVariable",
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: dimmedColor),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                      child: (TextField(
                    style: TextStyle(
                      fontFamily: "SoruceSansVariable",
                      color: textColor,
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(20)],
                    decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: IconColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderradius),
                          borderSide:
                              BorderSide(color: TextFieldColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: BorderColor, width: 0),
                          borderRadius: BorderRadius.circular(borderradius),
                        ),
                        fillColor: fillColor,
                        filled: true,
                        hintText: "Username",
                        hintStyle: TextStyle(color: IconColor)),
                    onChanged: (value) {
                      loginusername = value;
                    },
                  ))),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: (TextField(
                    style: TextStyle(
                        fontFamily: "SoruceSansVariable", color: textColor),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    inputFormatters: [LengthLimitingTextInputFormatter(20)],
                    decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: IconColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderradius),
                          borderSide:
                              BorderSide(color: TextFieldColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: BorderColor, width: 0),
                          borderRadius: BorderRadius.circular(borderradius),
                        ),
                        fillColor: fillColor,
                        filled: true,
                        hintText: "Password",
                        hintStyle: TextStyle(color: IconColor)),
                    onChanged: (value) {
                      loginpassword = value;
                    },
                  ))),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: textColor),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Forgot Password?',
                                style: TextStyle(
                                    fontFamily: "SoruceSansVariable",
                                    color: IconColor,
                                    fontSize: 13),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Forgot Password');
                                  }),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Container(
                          width: double.infinity,
                          color: secondaryColor,
                          child: TextButton(
                              style: TextButton.styleFrom(primary: textColor),
                              onPressed: () async {
                                if (await login(loginusername, loginpassword)) {
                                  SaveLoginDetail(loginusername, loginpassword);
                                  SaveLoginStatus(true);
                                  print("Success");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPage()));
                                } else {
                                  print("Wrong password or username");
                                }
                              },
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: textColor,
                                    fontFamily: "SoruceSansVariable",
                                    fontSize: 18),
                              )))),
                  SizedBox(
                    height: 12,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: textColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Dont have an account? Create one!',
                            style: TextStyle(
                                fontFamily: "SoruceSansVariable",
                                color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('Terms of Service"');
                              }),
                      ],
                    ),
                  )
                ]))),
      ),
    );
  }
}
