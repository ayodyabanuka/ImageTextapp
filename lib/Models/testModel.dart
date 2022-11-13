import 'dart:convert';

List<TestModel> TestModelFromJson(String str) =>
    List<TestModel>.from(json.decode(str).map((x) => TestModel.fromJson(x)));

class TestModel {
  String id;
  String imageLink;
  String imageGenCap;

  TestModel({this.id, this.imageGenCap, this.imageLink});

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        id: json['_id'],
        imageLink: json['imageLink'],
        imageGenCap: json['imageGenCap'],
      );
}
