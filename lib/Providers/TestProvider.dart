import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rp/Models/testModel.dart';

class TestProvider with ChangeNotifier {
  List<TestModel> TestList = [];
  TestModel testmodel;
  Future<List<TestModel>> getTestList() async {
    //todo:
    final responseData = await http.get(
        Uri.parse(
            'https://rp-project-backend.herokuapp.com/api/v1/image/getimages'),
        headers: _setHeaders());
    print("Response code is" + responseData.statusCode.toString());

    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body)['image'] as List;
      if (TestList.isNotEmpty) {
        return TestList;
      } else {
        for (Map<String, dynamic> item in data) {
          var tests = TestModel.fromJson(item);
          TestList.add(tests);
        }
        return TestList;
      }
    } else {
      return TestList;
    }
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer',
        'Connection': 'keep-alive',
      };
}
