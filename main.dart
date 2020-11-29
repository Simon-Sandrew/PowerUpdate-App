import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';
import 'scrape.dart';

void main() => runApp(new _PowerUpdate());

class _PowerUpdate extends StatefulWidget {
  @override
  State createState() => new PowerUpdate();
}

class PowerUpdate extends State<_PowerUpdate> {
  Color deepJungleGreen = Color.fromRGBO(0, 75, 75, 1);
  Color skobeloffGreen = Color.fromRGBO(0, 112, 114, 1);
  Color maximumBlue = Color.fromRGBO(112, 179, 195, 1);

  //light Colors
  Color backgroundColor = const Color(0XFF71CCE5);
  Color widgetColor = const Color(0XFF70B3C3);
  Color textColor = const Color(0XFFFCFCFC);
  Color gradeColor = const Color(0xFFF4F0BF);

  String username = 'od1001020';
  String password = 'Cuttyhunk5ofus';

  List<String> classes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String message = greeting(); //determines welcome message
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RelativeBuilder(
        builder: (context, screenHeight, screenWidth, sy, sx) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              //main body container
              width: screenWidth,
              height: screenHeight,
              color: backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //"Good (morning, afternoon, evening)" message
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // top intro title
                        padding: EdgeInsets.only(top: sy(30), left: sx(20)),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Good $message',
                            style: TextStyle(
                              color: textColor,
                              fontSize: sx(50),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: sx(500),
                        height: sy(440),
                        child: mainBody(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget mainBody() {
    return RelativeBuilder(
        builder: (context, screenHeight, screenWidth, sy, sx) {
      return FutureBuilder<String>(
        future: getGradesPage(username, password),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            classes = getGrades(snapshot.data);
            return ListView.builder(
              padding: EdgeInsets.only(
                top: sy(10),
              ),
              itemCount: classes.length,
              itemBuilder: (BuildContext context, int index) {
                List<String> classInfo = classes[index].split(';');
                if (classInfo[0].length > 15) {
                  classInfo[0] = classInfo[0].substring(0, 15) + '...';
                }
                return Container(
                  padding: EdgeInsets.only(
                    bottom: sy(3),
                  ),
                  child: SizedBox(
                    height: sy(55),
                    child: Card(
                      //elevation: 1,
                      color: widgetColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: sx(15),
                            ),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                classInfo[0],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                  fontSize: sx(30),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(
                              right: sx(35),
                            ),
                            child: Text(
                              classInfo[2],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: gradeColor,
                                fontSize: sx(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Image(image: AssetImage('assets/Logo.gif')));
          }
        },
      );
    });
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
