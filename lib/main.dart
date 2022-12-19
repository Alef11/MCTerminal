import 'package:flutter/material.dart';
import 'dart:async';
import 'package:minecraftservercontroller/login.dart';
import 'package:minecraftservercontroller/mainpage.dart';
import 'package:minecraftservercontroller/utils/Save_Load.dart';
import 'package:minecraftservercontroller/utils/networkingfuctions.dart';

String user = "";
String pass = "";
String firstname = "";
String secondname = "";
bool isLogin = false;
bool iscorrect = false;

Color TextFieldColor = Colors.transparent;

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  @override
  State<LoadingPage> createState() => _MyLoadingPageState();
}

Color primaryColor = Color.fromRGBO(54, 55, 156, 1);
Color secondaryColor = Color.fromARGB(255, 38, 139, 173);
Color grey = Color.fromARGB(255, 37, 37, 37);

class _MyLoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Image.asset(
              "lib/assets/logo.png",
              height: 65.0,
            ),
            Image.asset("lib/assets/loading-triangle.gif", height: 75.0),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }

  void loadlogin(cxt) {
    //
    Future.delayed(Duration.zero, () async {
      List<Future<List<String>>> futures2 = [LoadLoginDetail()];
      await Future.wait(futures2);
      List<String> test = await futures2[0];
      user = test[0];
      pass = test[1];
      List<Future<bool>> futures = [LoadLoginStatus(), login(user, pass)];
      await Future.wait(futures);
      isLogin = await futures[0];
      bool correct = await futures[1];
      if (user == "") {
        Navigator.push(
            context, MaterialPageRoute(builder: (cxt) => LoginPage()));
      } else {
        if (isLogin) {
          if (correct) {
            Navigator.push(
                context, MaterialPageRoute(builder: (cxt) => MainPage()));
          } else {
            print(correct);
            Navigator.push(
                context, MaterialPageRoute(builder: (cxt) => LoginPage()));
          }
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (cxt) => LoginPage()));
        }
      }
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadlogin(context));
  }
}
