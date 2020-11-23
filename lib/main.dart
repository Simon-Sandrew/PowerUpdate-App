import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Bentson',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(color: Color(0xff004B4B)),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Container(
                child: Text(
                  "Good afternoon",
                  style: TextStyle(
                      color: Color(0xFF70B3C3),
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
                padding: EdgeInsets.only(left: 20, bottom: 20),
              )
            ]),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Color(0xFF003D3B),
              child: ListTile(
                title: Text(
                  '96.66',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w100,
                      color: Color(0xff70B3C3)),
                ),
                leading: Text(
                  'AP Calculus AB',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff70B3C3)),
                ),
                contentPadding: EdgeInsets.all(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
