import 'dart:convert';

import 'package:http/http.dart' as http;

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error ${response.statusCode}");
      }
    } catch (e) {
      print("error catch get : ${e}");
    }
  }

  postRequest(String url, Map data) async {
    //await Future.delayed(Duration(seconds: 5));
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error ${response.statusCode}");
      }
    } catch (e) {
      print("error catch post : ${e}");
    }
  }
}
