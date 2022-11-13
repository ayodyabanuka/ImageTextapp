import 'dart:convert';

List<AddnewModel> AddnewModelFromJson(String str) => List<AddnewModel>.from(
    json.decode(str).map((x) => AddnewModel.fromJson(x)));

class AddnewModel {
  String imageName;
  String imageLink;
  String imageGenCap;

  AddnewModel({this.imageName, this.imageGenCap, this.imageLink});

  factory AddnewModel.fromJson(Map<String, dynamic> json) => AddnewModel(
        imageName: json['imageName'],
        imageLink: json['imageLink'],
        imageGenCap: json['imageGenCap'],
      );
}
