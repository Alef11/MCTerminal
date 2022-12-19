import 'package:flutter/material.dart';
import 'package:minecraftservercontroller/main.dart';
import 'dart:async';
import 'package:minecraftservercontroller/mainpage.dart';
import 'package:minecraftservercontroller/utils/networkingfuctions.dart';

String ServernameWidget = "Penis";
bool onlinestatus = false;
String IPAdress = "192.168.2.147";
int OnlinePlayer = 1;
int MaxPlayer = 20;
Image ServerIcon = Image.asset("lib/assets/loading-triangle2.gif");

class ServerWidget extends StatefulWidget {
  final String servername;
  ServerWidget({required this.servername});

  @override
  _ServerState createState() {
    ServernameWidget = servername;
    return _ServerState();
  }
}

class _ServerState extends State<ServerWidget> {
  void GatherInformation(servername) async {
    List<Future<List<dynamic>>> ServerInfo = [gatherData(servername)];
    await Future.wait(ServerInfo);
    List<dynamic> ServerI = await ServerInfo[0];

    setState(() {
      onlinestatus = ServerI[0];
      IPAdress = ServerI[1];
      OnlinePlayer = ServerI[2];
      MaxPlayer = ServerI[3];
      ServerIcon = ServerI[4];
    });
  }

  void _startserver() {
    startServer(user, pass, ServernameWidget);
  }

  void _stopserver() {
    stopServer(user, pass, ServernameWidget);
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => GatherInformation(ServernameWidget));
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      (Container(
          decoration: BoxDecoration(
            border: Border.all(color: ServerOutline, width: 1),
            color: ServerBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: (Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: ServerIcon.image,
                              height: 50,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ServernameWidget,
                                  style: TextStyle(
                                      color: ServerTextColor,
                                      fontFamily: "SoruceSansVariable",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                Text(
                                  IPAdress,
                                  style: TextStyle(
                                      color: ServerTextDimmColor,
                                      fontFamily: "SoruceSansVariable",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onlinestatus
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image(
                                    image: AssetImage("lib/assets/players.png"),
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    OnlinePlayer.toString() +
                                        "/" +
                                        MaxPlayer.toString(),
                                    style: TextStyle(
                                        color: ServerTextDimmColor,
                                        fontFamily: "SoruceSansVariable",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                ],
                              )
                            : Row()
                      ]),
                  SizedBox(
                    height: 14,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                        child: onlinestatus
                            ? Row(children: [
                                Text(
                                  "Online",
                                  style: TextStyle(
                                      color: ServerTextDimmColor,
                                      fontFamily: "SoruceSansVariable",
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Image.asset(
                                  "lib/assets/Online.png",
                                  height: 10,
                                )
                              ])
                            : Row(children: [
                                Text(
                                  "Offline",
                                  style: TextStyle(
                                      color: ServerTextDimmColor,
                                      fontFamily: "SoruceSansVariable",
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Image.asset(
                                  "lib/assets/Offline.png",
                                  height: 10,
                                )
                              ])),
                    SizedBox(
                      width: 13,
                    ),
                    onlinestatus
                        ? ElevatedButton(
                            onPressed: (() => _stopserver()),
                            child: Row(
                              children: [
                                Text(
                                  "Stop",
                                  style: TextStyle(
                                      fontFamily: "SoruceSansVariable",
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  "lib/assets/Stop.png",
                                  height: 15,
                                )
                              ],
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        ServerBackgroundColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
                                            color: ServerOutline, width: 2)))),
                          )
                        : ElevatedButton(
                            onPressed: (() => _startserver()),
                            child: Row(
                              children: [
                                Text(
                                  "Start",
                                  style: TextStyle(
                                      fontFamily: "SoruceSansVariable",
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  "lib/assets/Start.png",
                                  height: 15,
                                )
                              ],
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        StartColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ))),
                          ),
                    SizedBox(
                      width: 13,
                    ),
                    Image.asset(
                      "lib/assets/Settings.png",
                      height: 20,
                    )
                  ])
                ],
              ))))),
      SizedBox(
        height: 20,
      )
    ]);
  }
}
