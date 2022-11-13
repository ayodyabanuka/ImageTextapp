import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnswerProvider with ChangeNotifier {
  sendAnswer(data, testId) async {
    return await http.post(
        Uri.parse(
            "https://rp-project-backend.herokuapp.com/api/v1/image/submitanswer/$testId"),
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
