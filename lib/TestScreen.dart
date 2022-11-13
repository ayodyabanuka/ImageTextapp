import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rp/AddTest.dart';
import 'package:rp/AnswerScreen.dart';
import 'package:rp/Models/testModel.dart';
import 'package:rp/Providers/TestProvider.dart';

class TestScreen extends StatefulWidget {
  TestScreen({Key key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Future<List<TestModel>> testlist;

  @override
  void initState() {
    testlist = context.read<TestProvider>().getTestList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddTest()));
            },
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.add,
              color: Colors.black,
            )),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "Hello welcome to Test!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                    child: RefreshIndicator(
                  onRefresh: _pullRefresh,
                  child: FutureBuilder<List<TestModel>>(
                    future: testlist,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text("Loading..."),
                        );
                      } else {
                        return ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AnswerScreen(
                                                id: snapshot.data[index].id,
                                                image: snapshot
                                                    .data[index].imageLink,
                                              )));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Test ${index + 1}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                snapshot.data[index].imageLink),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        height: 120,
                                        width: 200,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    },
                  ),
                )),
              ],
            ),
          ),
        ));
  }

  Future<void> _pullRefresh() async {
    setState(() {
      testlist = context.read<TestProvider>().getTestList();
    });
  }
}
