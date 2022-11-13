import 'dart:convert';

List<AnswerModel> AnswerModelFromJson(String str) => List<AnswerModel>.from(
    json.decode(str).map((x) => AnswerModel.fromJson(x)));

class AnswerModel {
  String givenText;
  AnswerModel({this.givenText});

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        givenText: json['givenText'],
      );
}
