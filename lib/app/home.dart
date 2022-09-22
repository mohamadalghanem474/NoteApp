import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/app/notes/edite.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/constant/linkApi.dart';
import 'package:noteapp/main.dart';
import 'package:noteapp/model/notemodel.dart';

import '../components/card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  getNotes() async {
    var respose = await postRequest(linkViewNotes, {'noteuser': '30'});
    // print("response = ${respose.toString()}");
    return respose;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        actions: [
          IconButton(
              onPressed: () {
                sherdPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: Icon(Icons.output))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          FutureBuilder(
            future: getNotes(),
            builder: ((BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data['status'] == "error")
                  return Center(child: Text("notes null"));
                return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return CardWwidget(
                        onDelete: () async {
                          var respnse = await postRequest(linkDeleteNotes, {
                            "noteid": snapshot.data['data'][index]['note_id']
                                .toString(),
                            "imagename": snapshot.data['data'][index]
                                ['note_image']
                          });
                          if (respnse["status"] == "success") {
                            Navigator.of(context).pushReplacementNamed("home");
                          } else {
                            AwesomeDialog(
                                context: context,
                                title: "alirt!",
                                body: Text(
                                  "error delete note",
                                  style: TextStyle(fontSize: 30),
                                ))
                              ..show();
                            print("error delete note");
                          }
                        },
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((BuildContext context) => EditeNote(
                                    notes: snapshot.data['data'][index],
                                  ))));
                        },
                        notemodel:
                            NoteModel.fromJson(snapshot.data['data'][index]),
                      );
                    }));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                // print("snapshot = ${snapshot.toString()}");
                return Center(
                  child: Text("loadin.."),
                );
              }
              return Center(
                child: Text("loadin.."),
              );
            }),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnote");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
