import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rp/Providers/AddnewTestProvider.dart';
import 'package:rp/TestScreen.dart';

class AddTest extends StatefulWidget {
  AddTest({Key key}) : super(key: key);

  @override
  State<AddTest> createState() => _AddTestState();
}

class _AddTestState extends State<AddTest> {
  TextEditingController imagename = TextEditingController();
  TextEditingController imageGenCap = TextEditingController();
  TextEditingController imageLink = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Insert data to add new test here!",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
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
                  controller: imagename,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: const Color.fromARGB(255, 0, 0, 0),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Image name",
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
                  controller: imageGenCap,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: const Color.fromARGB(255, 0, 0, 0),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Image caption here!",
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
                  controller: imageLink,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: const Color.fromARGB(255, 0, 0, 0),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add image link here!",
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
                if (imagename.text.isNotEmpty &&
                    imageLink.text.isNotEmpty &&
                    imageGenCap.text.isNotEmpty) {
                  AddnewTest();
                } else {
                  Fluttertoast.showToast(
                    msg: "Fill all fields!",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: const Center(
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  AddnewTest() async {
    var data = {
      'imageName': imagename.text,
      'imageGenCap': imageGenCap.text,
      'imageLink': imageLink.text
    };

    var res = await AddnewTestProvider().AddnewTest(data);

    if (res.statusCode == 200) {
      print(res.body);
      Fluttertoast.showToast(
        msg: "Successfully Added!",
        toastLength: Toast.LENGTH_SHORT,
      );
      imagename.clear();
      imageLink.clear();
      imageGenCap.clear();

      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TestScreen()),
          (route) => false);
    } else {
      Fluttertoast.showToast(
        msg: "Server Error!",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
