import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';

import '../../components/customTextFormField.dart';
import '../../components/valid.dart';
import '../../constant/linkApi.dart';
import '../../main.dart';

class EditeNote extends StatefulWidget {
  final  notes;
  const EditeNote({super.key,  this.notes});

  @override
  State<EditeNote> createState() => _EditeNoteState();
}

class _EditeNoteState extends State<EditeNote> with Crud {
  GlobalKey<FormState> fromstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool _isLoading = false;

  editeNote() async {
    if (fromstate.currentState!.validate()) {
      _isLoading = true;
      setState(() {
        
      });
      var respnse = await postRequest(linkEditeNotes,
          {"title": title.text,
           "content": content.text,
           "noteid": widget.notes['note_id'].toString()});
      if (respnse["status"] == "success") {
        _isLoading = false;
        Navigator.of(context).pushReplacementNamed("home");
      }else {
        _isLoading = false;
        setState(() {});
        AwesomeDialog(
            context: context,
            title: "alirt!",
            body: Text(
              "error edite note",
              style: TextStyle(fontSize: 30),
            ))
          ..show();
        print("error edite note");
      }
    }
  }

  @override
  void initState() {
    title.text = widget.notes['note_title'];
    content.text = widget.notes['note_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EDITE NOTE")),
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
                      await editeNote();
                    },
                    child: Text("EDITE NOTE"),
                  )
                ]),
              ),
            ),
    );
  }
}
