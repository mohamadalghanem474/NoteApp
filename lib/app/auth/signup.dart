import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkApi.dart';

import '../../components/customTextFormField.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Crud _crud = Crud();

  bool isloading = false;

  signup() async {
    if (formstate.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var respnse = await _crud.postRequest(
        linkSignup,
        {
          "username": username.text,
          "email": email.text,
          "password": password.text
        },
      );
      isloading = false;
      setState(() {});
      if (respnse["status"] == "success") {
        print("success signup");
      } else {
        print("error signup");
      }
      Navigator.of(context).pushNamedAndRemoveUntil(
        "success",
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
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
                        Text(
                          "SIGNUP",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        customTextFormField(
                          valid: (value) {
                            return validInput(value!, 3);
                          },
                          controllert: username,
                          hint: "username",
                        ),
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
                                vertical: 10, horizontal: 67),
                            textColor: Colors.black,
                            color: Colors.yellow,
                            child: Text(
                              "SIGNUP",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: signup),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 70),
                            textColor: Colors.black,
                            color: Colors.green,
                            child: Text(
                              "LOGIN?",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () => Navigator.of(context)
                                .pushReplacementNamed("login")),
                      ],
                    ))
              ]),
            ),
    );
  }
}
