import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/constant/linkApi.dart';
import 'package:noteapp/main.dart';

import '../../components/customTextFormField.dart';
import '../../components/valid.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud _crud = Crud();

  logIn() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var respnse = await _crud.postRequest(
          linklogin, {"email": email.text, "password": password.text});
      if (respnse["status"] == "success") {
        sherdPref.setString("id", respnse['data']['user_id'].toString());
        sherdPref.setString("name", respnse['data']['user_name']);
        sherdPref.setString("email", respnse['data']['user_email']);

        isLoading = false;
        print("success signin");
        Navigator.of(context).pushNamedAndRemoveUntil(
          "home",
          (route) => false,
        );
      } else {
        isLoading = false;
        setState(() {});
        AwesomeDialog(
            context: context,
            title: "alirt!",
            body: Text(
              "account not exist",
              style: TextStyle(fontSize: 30),
            ))
          ..show();
        print("error signin");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: ListView(children: [
                Form(
                    key: formstate,
                    child: Column(
                      children: [
                        Image.asset(
                          "images/logo.png",
                          width: 300,
                          height: 300,
                        ),
                        Text("LOGIN",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        customTextFormField(
                          valid: (value) {
                            return validInput(value!, 3);
                          },
                          controllert: email,
                          hint: "email",
                        ),
                        customTextFormField(
                          valid: (value) {
                            return validInput(value!, 3);
                          },
                          controllert: password,
                          hint: "password",
                        ),
                        MaterialButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 70),
                            textColor: Colors.black,
                            color: Colors.yellow,
                            child: Text(
                              "LOGIN",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              await logIn();
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 59),
                            textColor: Colors.black,
                            color: Colors.green,
                            child: Text(
                              "SIGNUP?",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () => Navigator.of(context)
                                .pushReplacementNamed("signup")),
                      ],
                    ))
              ]),
            ),
    );
  }
}
