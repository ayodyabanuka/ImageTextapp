import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rp/Providers/AnswerProvider.dart';
import 'package:rp/Widgets/CorrectPopup.dart';
import 'package:rp/Widgets/IncorrectPopup.dart';

class AnswerScreen extends StatefulWidget {
  String id, image;
  AnswerScreen({Key key, this.id, this.image}) : super(key: key);

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  TextEditingController answer = TextEditingController();
  bool correctpopup = false;
  bool incorrectpopup = false;
  @override
  void initState() {
    print(widget.id);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Write down a sentence using below image.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.fill,
                    ),
                  ),
                  width: size.width,
                  height: 200,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(1, 1),
                            blurRadius: 30,
                            spreadRadius: 0,
                            color: Colors.grey.withOpacity(0.3)),
                      ],
                      // border: Border.all(color: const Color(0xffff00e3)),
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      maxLines: 10,
                      controller: answer,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      cursorColor: const Color.fromARGB(255, 0, 0, 0),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: " Answer",
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 116, 116, 116),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    answer.text != ""
                        ? sendAnswer()
                        : Fluttertoast.showToast(
                            msg: "Please Enter an answer!");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
        Visibility(visible: correctpopup, child: const Correctpopup()),
        Visibility(
            visible: incorrectpopup,
            child: InCorrectpopup(
              function: () {
                setState(() {
                  incorrectpopup = false;
                  answer.clear();
                });
              },
            ))
      ],
    );
  }

  sendAnswer() async {
    var data = {'givenText': answer.text};

    var res = await AnswerProvider().sendAnswer(data, widget.id);
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);
      final body = json.decode(res.body);
      var correct = body["isCorrected"];
      print(correct);
      if (correct == true) {
        setState(() {
          correctpopup = true;
        });
      } else if (correct == false) {
        setState(() {
          incorrectpopup = true;
        });
      }
    } else {
      Fluttertoast.showToast(
        msg: "Server Error!",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
