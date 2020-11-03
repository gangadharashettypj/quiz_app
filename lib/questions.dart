/*
 * @Author GS
 */
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class QuestionsModel {
  String number;
  String question;
  bool isMcq;
  String answer;
  String o1;
  String o2;
  String o3;
  String o4;
  Map<dynamic, dynamic> json;

  QuestionsModel({
    this.number,
    this.question,
    this.isMcq,
    this.answer,
    this.o1,
    this.o2,
    this.o3,
    this.o4,
    this.json,
  });
  static List<QuestionsModel> fromJson(List<dynamic> json) {
    List<QuestionsModel> models = [];
    json.forEach((value) {
      if (value.keys.length > 3) {
        models.add(QuestionsModel(
          isMcq: true,
          json: value,
          o1: '${value['1']}',
          o2: '${value['2']}',
          o3: '${value['3']}',
          o4: '${value['4']}',
          answer: '${value['Answer']}',
          question: value['Question'],
          number: '${json.indexOf(value) + 1}',
        ));
      } else {
        models.add(QuestionsModel(
          isMcq: false,
          answer: '${value['1']}',
          question: value['Question'],
          number: '${json.indexOf(value) + 1}',
        ));
      }
    });
    return models;
  }
}

class Questions extends StatefulWidget {
  final Map<String, dynamic> data;
  Questions({this.data});
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int i;
  List<QuestionsModel> models;
  bool flag = false;
  int correct = 0;
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        FirebaseDatabase.instance
            .reference()
            .child(widget.data['type'])
            .limitToFirst(50)
            .once()
            .then((value) {
          setState(() {
            i = 0;
            if (value.value == null)
              models = [];
            else
              models = QuestionsModel.fromJson(value.value);
            models.shuffle(Random(DateTime.now().millisecondsSinceEpoch));
          });
        });
      },
    );
    super.initState();
  }

  int selected;
  @override
  Widget build(BuildContext context) {
    if (models == null)
      return Scaffold(
        body: Container(
          child: Center(
            child: Text(
              'Loading...',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
      );
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
            ),
            SizedBox(
              height: 32,
            ),
            ListTile(
              title: Text(
                '${models[i].question}',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            !models[i].isMcq
                ? ListTile(
                    title: Text('1. True'),
                    onTap: () {
                      setState(() {
                        selected = 1;
                      });
                    },
                    selected: selected == 1 ?? null,
                  )
                : Container(),
            !models[i].isMcq
                ? ListTile(
                    title: Text('2. False'),
                    onTap: () {
                      setState(() {
                        selected = 2;
                      });
                    },
                    selected: selected == 2 ?? null,
                  )
                : Container(),
            !models[i].isMcq
                ? Container()
                : ListTile(
                    title: Text('1. ${models[i].o1}'),
                    onTap: () {
                      setState(() {
                        selected = 1;
                      });
                    },
                    selected: selected == 1 ?? null,
                  ),
            !models[i].isMcq
                ? Container()
                : ListTile(
                    title: Text('2. ${models[i].o2}'),
                    onTap: () {
                      setState(() {
                        selected = 2;
                      });
                    },
                    selected: selected == 2 ?? null,
                  ),
            !models[i].isMcq
                ? Container()
                : ListTile(
                    title: Text('3. ${models[i].o3}'),
                    onTap: () {
                      setState(() {
                        selected = 3;
                      });
                    },
                    selected: selected == 3 ?? null,
                  ),
            !models[i].isMcq || models[i].o4 == 'null'
                ? Container()
                : ListTile(
                    title: Text('4. ${models[i].o4}'),
                    onTap: () {
                      setState(() {
                        selected = 4;
                      });
                    },
                    selected: selected == 4 ?? null,
                  ),
            flag
                ? ListTile(
                    title: Text(
                        'Answer is: ${models[i].isMcq ? models[i].json[models[i].answer] : models[i].answer}'),
                  )
                : Container(),
            FlatButton(
              onPressed: () async {
                if (flag) return;
                if (selected == null) {
                  Toast.show(
                    'Please select any one option and continue',
                    context,
                    duration: Toast.LENGTH_SHORT,
                    gravity: Toast.BOTTOM,
                  );
                  return;
                }
                if ((i + 1) < widget.data['questions'] && selected != null) {
                  setState(() {
                    flag = true;
                  });
                  await Future.delayed(Duration(seconds: 2));
                  setState(() {
                    flag = false;
                    if (!models[i].isMcq) {
                      if (selected == 1 && models[i].answer == 'true') {
                        correct++;
                      }
                      if (selected == 2 && models[i].answer == 'false') {
                        correct++;
                      }
                    } else {
                      if ('$selected' == models[i].answer) {
                        correct++;
                      }
                    }
                    selected = null;
                    i++;
                  });
                } else {
                  showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Result'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(
                                '$correct / ${widget.data['questions']}',
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ));
                }
              },
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              color: Colors.transparent,
              child: Text(
                flag ? '....' : 'Next',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
