import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddnewTestProvider with ChangeNotifier {
  AddnewTest(data) async {
    return await http.post(
        Uri.parse(
            "https://rp-project-backend.herokuapp.com/api/v1/image/addimage"),
        body: jsonEncode(data),
        headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer',
        'Connection': 'keep-alive',
      };
}
