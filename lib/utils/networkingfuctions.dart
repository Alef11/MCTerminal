import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:minecraftservercontroller/main.dart';
import 'package:flutter/widgets.dart';

String server = "http://battlelabs.net:55655";

Future<bool> login(String Username, String Password) async {
  final url = Uri.parse(server + "/login");

  final response = await http.post(url,
      body: json.encode({
        "username": Username,
        "password": Password,
      })); //send message to server

  final decoded = await json.decode(response.body)
      as Map<String, dynamic>; //receive answer from server

  if (decoded["message"] == "Access Granted") {
    return true;
  } else {
    return false;
  }
}

Future<List<String>> getServers(String Username) async {
  final url = Uri.parse(server + "/getserveracces");

  final response = await http.post(url,
      body: json.encode({
        "username": user,
      }));

  final decoded = await json.decode(response.body);
  List<String> returnvalue = List<String>.from(decoded["servers"] as List);
  return returnvalue;
}

Future<bool> isOnline(String servername) async {
  final url = Uri.parse(server + "/onlinestatus");

  final response =
      await http.post(url, body: json.encode({"servername": servername}));

  final decode = await json.decode(response.body);
  bool returnbool = decode["message"];
  return returnbool;
}

Future<List<dynamic>> gatherData(String servername) async {
  final url = Uri.parse(server + "/gatherData");

  final response =
      await http.post(url, body: json.encode({"servername": servername}));

  final decode = await json.decode(response.body);
  bool returnbool = decode["status"];
  String returnip = decode["ip"];
  int returnonlineplayers = int.parse(decode["onlineplayers"]);
  int returnmaxplayers = int.parse(decode["maxplayers"]);
  Image returnImage = await getServerIcon(servername);
  return [
    returnbool,
    returnip,
    returnonlineplayers,
    returnmaxplayers,
    returnImage
  ];
}

Future<Image> getServerIcon(String servername) async {
  final url = Uri.parse(server + "/gatherPic/" + servername);

  final response = await http.get(url);

  //final decode = await json.decode(response.body);
  //dynamic base64image = decode["img"];
  dynamic base64image = response.body;
  base64image = base64image.substring(2);
  if (base64image != null && base64image.length > 0) {
    base64image = base64image.substring(0, base64image.length - 1);
  }
  final returnimage = Image.memory(base64Decode(base64image));
  return returnimage;
}

Future<bool> startServer(
    String Username, String Password, String servername) async {
  final url = Uri.parse(server + "/startServer");

  final response = await http.post(url,
      body: json.encode({
        "username": Username,
        "password": Password,
        "servername": servername
      }));

  final decode = await json.decode(response.body);
  bool returnbool = decode["message"];
  if (decode == "1") {
    return true;
  } else {
    return false;
  }
}

Future<bool> stopServer(
    String Username, String Password, String servername) async {
  final url = Uri.parse(server + "/stopServer");

  final response = await http.post(url,
      body: json.encode({
        "username": Username,
        "password": Password,
        "servername": servername
      }));

  final decode = await json.decode(response.body);
  bool returnbool = decode["message"];
  if (decode == "1") {
    return true;
  } else {
    return false;
  }
}

void test() async {
  final url = Uri.parse(server + "/hello");

  final response = await http.post(url, body: json.encode({}));
}
