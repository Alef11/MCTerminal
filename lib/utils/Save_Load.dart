import 'package:minecraftservercontroller/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> LoadLoginDetail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  user = prefs.getString("username") ?? "null";
  pass = prefs.getString("password") ?? "null";
  return [user, pass];
}

void SaveLoginDetail(String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("username", username);
  await prefs.setString("password", password);
}

Future<String> LoadNames() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  firstname = prefs.getString("fname") ?? "null";
  secondname = prefs.getString("sname") ?? "null";
  return "Loaded Strings";
}

void SaveNames(String fname, String sname, String instatus) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("fname", fname);
  await prefs.setString("sname", sname);
  await prefs.setString("status", instatus);
}

Future<bool> LoadLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLogin = prefs.getBool("loggedin") ?? false;
  return isLogin;
}

void SaveLoginStatus(bool status) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool("loggedin", status);
}
