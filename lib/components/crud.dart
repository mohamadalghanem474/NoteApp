import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

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

postRequestWithFile(String url, Map data, File myfile) async {
  var request = await http.MultipartRequest("POST", Uri.parse(url));
  var length = await myfile.length();
  var streem = http.ByteStream(myfile.openRead());
  var multiPartFile = await http.MultipartFile("file", streem, length,
      filename: basename(myfile.path));
  request.files.add(multiPartFile);
  data.forEach((key, value) {
    request.fields[key] = value;
  });
  var myRequest = await request.send();
  var response = await http.Response.fromStream(myRequest);
  if (myRequest.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print("error ${myRequest.statusCode}");
  }
}
