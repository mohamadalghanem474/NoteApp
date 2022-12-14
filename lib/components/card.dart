import 'package:flutter/material.dart';
import 'package:noteapp/model/notemodel.dart';

import '../constant/linkApi.dart';

class CardWwidget extends StatelessWidget {
  const CardWwidget(
      {super.key, this.onTap, required this.onDelete, required this.notemodel});
  final void Function()? onTap;
  final void Function()? onDelete;
  final NoteModel notemodel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  "$imagenet${notemodel.noteImage}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("${notemodel.noteTitle}"),
                  subtitle: Text("${notemodel.noteContent}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
