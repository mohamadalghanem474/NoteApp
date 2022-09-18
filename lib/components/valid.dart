import 'package:noteapp/constant/message.dart';

validInput(String val, int min) {
  if (val.isEmpty) {
    return "$messageInputEmpty!!";
  }
  if (val.length < min) {
    return "$messageInputmin $min";
  }
}
