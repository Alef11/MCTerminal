import 'package:flutter/material.dart';
import 'package:minecraftservercontroller/Widgets/ServerWidget.dart';
import 'dart:async';
import 'package:minecraftservercontroller/login.dart';
import 'package:minecraftservercontroller/main.dart';
import 'package:minecraftservercontroller/utils/Save_Load.dart';
import 'package:minecraftservercontroller/utils/networkingfuctions.dart';

List<String> Serveracces = [];
List<bool> Serverstatus = [false, false, false, false, false];
Color ServerTextColor = Colors.white;
Color ServerTextDimmColor = Colors.grey;
Color ServerBackgroundColor = Color.fromARGB(51, 20, 36, 51);
Color ServerOutline = Color.fromARGB(111, 27, 50, 68);
Color StartColor = Color.fromARGB(255, 26, 201, 32);
Color StopColor = Color.fromARGB(255, 238, 16, 0);

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void logout(contextref) {
    SaveLoginStatus(false);
    SaveLoginDetail("null", "null");

    Navigator.push(
        context, MaterialPageRoute(builder: (contextref) => LoginPage()));
  }

  Future<String> LoadAccess() async {
    List<Future<List<String>>> Serveracces = [getServers(user)];
    await Future.wait(Serveracces);
    List<String> Servers = await Serveracces[0];

    for (var i = 0; i < Servers.length; i++) {
      Serverstatus[i] = await isOnline(Servers[i]);
    }

    return "Hello";
  }

  Widget MainContent = Column(
    children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        height: 100,
        child: Text("Your Balance"),
      ),
      SizedBox(
        height: 50,
      ),
      ServerWidget(
        servername: "GummpenKlassenServer",
      ),
    ],
  );

  Widget LoadingContent = Column(
    children: [
      Center(
          child: (Image.asset("lib/assets/loading-triangle.gif", height: 75.0)))
    ],
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
  );

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
            child: Column(children: [
              Container(
                height: 100,
                color: Colors.white,
                child: TextButton(
                  child: Text("Logout"),
                  onPressed: () {
                    SaveLoginStatus(false);
                    SaveLoginDetail("null", "null");

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 80),
                  child: FutureBuilder<String>(
                      future: LoadAccess(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        List<Widget> children;
                        if (snapshot.hasData) {
                          children = <Widget>[MainContent];
                        } else {
                          children = <Widget>[LoadingContent];
                        }
                        return Column(
                          children: children,
                        );
                      }))
            ])));
  }
}
