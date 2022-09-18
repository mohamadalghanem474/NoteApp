import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SignUp Success "),
            MaterialButton(
                color: Colors.amber,
                child: Text("To LogIn Page"),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("login");
                })
          ],
        ),
      ),
    );
  }
}
