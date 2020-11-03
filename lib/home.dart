/*
 * @Author GS
 */
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int noOfQuestions = 10;
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Image.asset(
              'assets/images/logo.png',
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Quiz App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Column(
              children: <Widget>[
                Text(
                  'Number of questions: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Container(
                    width: 50,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: TextEditingController(text: '10'),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (val) {
                        if (val.length > 0)
                          noOfQuestions = int.parse(val);
                        else {
                          noOfQuestions = 0;
                        }
                      },
                    ),
                  ),
                ),
                error != ''
                    ? Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            FlatButton(
              onPressed: () {
                if (noOfQuestions == 0) {
                  setState(() {});
                }
                Navigator.pushNamed(context, 'questions', arguments: {
                  'type': 't1',
                  'questions': noOfQuestions,
                });
              },
              color: Colors.transparent,
              child: Text(
                '3 to 7 years',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, 'questions', arguments: {
                  'type': 't2',
                  'questions': noOfQuestions,
                });
              },
              color: Colors.transparent,
              child: Text(
                '7 to 12 years',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, 'questions', arguments: {
                  'type': 't3',
                  'questions': noOfQuestions,
                });
              },
              color: Colors.transparent,
              child: Text(
                '13 to 18 years',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, 'questions', arguments: {
                  'type': 't4',
                  'questions': noOfQuestions,
                });
              },
              color: Colors.transparent,
              child: Text(
                '18 and above',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
