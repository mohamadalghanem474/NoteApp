import 'package:flutter/material.dart';

class CardWwidget extends StatelessWidget {
  const CardWwidget(
      {super.key,
       this.onTap,
        required this.title,
        required this.content,
        required this.onDelete});
  final void Function()? onTap;
  final String title;
  final String content;
  final void Function()? onDelete;

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
                child: Image.asset(
                  "images/logo.png",
                  width: 100,
                  height: 100,
                )),
                Expanded(
                  flex: 2,
                  child: ListTile(
                    title: Text("$title"),
                    subtitle: Text("$content"),
                    trailing: IconButton(icon: Icon(Icons.delete),
                    onPressed: onDelete, ),
                  )
                  ),
          ],
        ),
      ),
    );
  }
}
