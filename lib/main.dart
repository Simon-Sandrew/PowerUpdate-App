import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'LoginPage'),
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
    return RelativeBuilder(
      builder: (context, screenHeight, screenWidth, sy, sx) {
        final username_field = TextField(
            obscureText: false,
            style: TextStyle(
                fontSize: sx(34),
                fontFamily: 'Benton',
                fontWeight: FontWeight.normal,
                color: Color(0xFFFCFCFC)),
            decoration: InputDecoration(
              suffixIconConstraints:
                  BoxConstraints(minWidth: sx(40), minHeight: 0),
              contentPadding: EdgeInsets.only(top: sy(8)),
              suffixIcon: FaIcon(
                FontAwesomeIcons.userAlt,
                color: Color(0xFFFCFCFC),
              ),
              hintText: "Username",
              hintStyle: TextStyle(color: Color(0xFFFCFCFC)),
              focusColor: Color(0xFFFCFCFC),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xFFFCFCFC), width: sx(5))),
            ));

        final password_field = TextField(
          obscureText: false,
          style: TextStyle(
              fontSize: sx(34),
              fontFamily: 'Benton',
              fontWeight: FontWeight.normal,
              color: Color(0xFFFCFCFC)),
          decoration: InputDecoration(
              suffixIconConstraints:
                  BoxConstraints(minWidth: sx(40), minHeight: 0),
              suffixIcon: FaIcon(
                FontAwesomeIcons.lock,
                color: Color(0XFFFCFCFC),
              ),
              contentPadding: EdgeInsets.only(top: sy(8)),
              hintText: "Password",
              hintStyle: TextStyle(color: Color(0xFFFCFCFC)),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xFFFCFCFC), width: sx(5)))),
        );
        return Scaffold(
          body: Center(
            child: Container(
              decoration: new BoxDecoration(
                  gradient: LinearGradient(colors: [
                const Color(0XFF70B3C3),
                const Color(0XFF74aecc)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Column(
                children: [
                  SizedBox(
                    height: sy(110),
                  ),
                  SizedBox(
                      height: sy(80),
                      child: Image.asset('logos/logoorange.png')),
                  SizedBox(
                    height: sy(20),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: sx(50)),
                        width: sx(270),
                        child: Text(
                          "Please enter your PowerSchool information",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Color(0xFFFCFCFC)),
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.only(left: sx(45), right: sx(45)),
                    child: username_field,
                  ),
                  SizedBox(
                    height: sy(10),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: sx(45), right: sx(45)),
                    child: password_field,
                  ),
                  SizedBox(
                    height: sy(10),
                  ),
                  RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.white,
                    child: Text("Login"),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
