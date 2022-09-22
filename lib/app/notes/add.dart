import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
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
  File? myfile;

  addNote() async {
    if (myfile == null) {
      return AwesomeDialog(
          context: context, title: "!!", body: Text("Add image !!"))
        ..show();
    }
    if (fromstate.currentState!.validate()) {
      _isLoading = true;
      var response = await postRequestWithFile(
          linkAddNotes,
          {
            "title": title.text,
            "content": content.text,
            "userid": sherdPref.get("id")
          },
          myfile!);
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                                padding: EdgeInsets.all(10),
                                height: 150,
                                child: Column(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(10),
                                        child: Center(
                                            child: Text(
                                                "choose image from gallery")),
                                      ),
                                      onTap: () async {
                                        XFile? xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        Navigator.of(context).pop();

                                        myfile = await File(xfile!.path);
                                        setState(() {});
                                      },
                                    ),
                                    InkWell(
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(10),
                                        child: Center(
                                            child: Text(
                                                "choose image from camera")),
                                      ),
                                      onTap: () async {
                                        XFile? xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        Navigator.of(context).pop();

                                        myfile = await File(xfile!.path);
                                        setState(() {});
                                      },
                                    )
                                  ],
                                ),
                              ));
                    },
                    child: Text("ADD image"),
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
