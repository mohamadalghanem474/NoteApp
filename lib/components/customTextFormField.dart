import 'package:flutter/material.dart';

class customTextFormField extends StatelessWidget {
  final String? Function(String?) valid;
  final String hint;
  final TextEditingController controllert;
  const customTextFormField(
      {super.key,
      required this.hint,
      required this.controllert,
      required this.valid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: controllert,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            hintText: hint,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
