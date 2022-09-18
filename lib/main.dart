import 'package:flutter/material.dart';
import 'package:noteapp/app/auth/signup.dart';
import 'package:noteapp/app/auth/success.dart';
import 'package:noteapp/app/home.dart';
import 'package:noteapp/app/notes/add.dart';
import 'package:noteapp/app/notes/edite.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/auth/login.dart';

late SharedPreferences sherdPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sherdPref = await SharedPreferences.getInstance();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Note App",
      initialRoute: sherdPref.getString("id")==null?"login":"home",
      routes: {
        "login": (context) => Login(),
        "signup": (context) => SignUp(),
        "home": (context) => Home(),
        "success": ((context) => Success()),
        "addnote": ((context) => AddNote()),
        "editenote": ((context) => EditeNote()),
      },
    );
  }
}
