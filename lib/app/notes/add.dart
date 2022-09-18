import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/constant/linkApi.dart';
import 'package:noteapp/main.dart';

import '../../components/customTextFormField.dart';
import '../../components/valid.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> with Crud {
  GlobalKey<FormState> fromstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool _isLoading = false;

  addNote() async {
    if (fromstate.currentState!.validate()) {
      _isLoading = true;
      var response = await postRequest(linkAddNotes, {
        "title": title.text,
        "content": content.text,
        "userid": sherdPref.get("id")
      });
      if (response['status'] == "success") {
        _isLoading = false;
        Navigator.of(context).pushReplacementNamed("home");
      }
    } else {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ADD NOTE")),
      body: _isLoading? Center(child: CircularProgressIndicator(),): Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: fromstate,
          child: ListView(children: [
            customTextFormField(
              hint: "title",
              controllert: title,
              valid: (value) {
                return validInput(value!, 3);
              },
            ),
            customTextFormField(
              hint: "content",
              controllert: content,
              valid: (value) {
                return validInput(value!, 3);
              },
            ),
            MaterialButton(
              onPressed: () async {
                await addNote();
              },
              child: Text("ADD NOTE"),
            )
          ]),
        ),
      ),
    );
  }
}
