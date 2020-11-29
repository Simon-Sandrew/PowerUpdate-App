import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

Future<String> getGradesPage(String username, String password) async {
  //Initial Login Request
  String url = "https://powerschool.westportps.org/guardian/home.html";
  http.Request request = http.Request('GET', Uri.parse(url));
  request.followRedirects = false;
  http.StreamedResponse resp = await request.send();

  //Redirect to SAML Auth
  url = resp.headers['location'];
  String jsession = resp.headers['set-cookie'].split(";")[0];
  Map<String, String> headers = {'Cookie': jsession};
  request = http.Request('GET', Uri.parse(url));
  request.headers.addAll(headers);
  request.followRedirects = false;
  resp = await request.send();

  //Redirect to Login Form
  url = resp.headers['location'];
  String sessIDCookie = resp.headers['set-cookie'].split(";")[0];
  headers = {'Cookie': sessIDCookie};
  request = http.Request('GET', Uri.parse(url));
  request.headers.addAll(headers);
  request.followRedirects = false;
  resp = await request.send();

  //POST Login Form
  //Clean Up AuthState field
  String authState = url.split("?")[1].split("=")[1];
  authState = authState.replaceAll("%25", "%");
  authState = authState.replaceAll("%26", "&amp;");
  authState = authState.replaceAll("%3D", "=");
  List<String> split = authState.split("=");
  split[0] = split[0].replaceAll("%3A", ":");
  split[0] = split[0].replaceAll("%2F", "/");
  split[0] = split[0].replaceAll("%3F", "?");
  authState = split.join();
  headers['Content-Type'] = 'application/x-www-form-urlencoded';
  request = http.Request('POST', Uri.parse(url));
  request.headers.addAll(headers);
  request.bodyFields = {
    'username': username,
    'password': password,
    'wp-submit': 'Log In',
    'AuthState': authState
  };
  resp = await request.send();

  //No JavaScript Form
  String authTokenCookie = resp.headers['set-cookie'].split(";")[0];
  dom.Document document = parser.parse(await resp.stream.bytesToString());
  url = document.getElementsByTagName("form")[0].attributes['action'];
  request = http.Request('POST', Uri.parse(url));
  request.followRedirects = false;
  request.headers.addAll({
    'Cookie': sessIDCookie + ';' + authTokenCookie + ';' + jsession,
    'Content-Type': 'application/x-www-form-urlencoded'
  });
  List<dom.Element> inputs = document.getElementsByTagName("input");
  request.bodyFields = {
    inputs[1].attributes['name']: inputs[1].attributes['value'],
    inputs[2].attributes['name']: inputs[2].attributes['value']
  };
  resp = await request.send();

  //Get Final Cookies Redirect
  url = "https://powerschool.westportps.org:443/guardian/home.html";
  jsession = resp.headers['set-cookie'].split(";")[0];
  String psaidCookie = "psaid=" +
      resp.headers['set-cookie'].substring(
          resp.headers['set-cookie'].indexOf("<-V2->"),
          resp.headers['set-cookie'].lastIndexOf("<-V2->") + "<-V2->".length);
  String currentSchool = resp.headers['set-cookie']
      .substring(resp.headers['set-cookie'].indexOf("currentSchool="));
  currentSchool = currentSchool.substring(0, currentSchool.indexOf(";"));
  request = http.Request('GET', Uri.parse(url));
  request.headers.addAll({
    'Cookie': sessIDCookie +
        ';' +
        authTokenCookie +
        ';' +
        jsession +
        ';' +
        psaidCookie +
        ';' +
        currentSchool
  });
  resp = await request.send();
  return await resp.stream.bytesToString();
}

List<String> getGrades(String html) {
  //Initial Parse
  dom.Document document = parser.parse(html);

  //Gets the Table Rows with Class Data in them
  List<dom.Element> classRows = new List<dom.Element>();
  for (dom.Element row in document.querySelectorAll("tr")) {
    if (row.attributes.isNotEmpty) {
      if (row.attributes['id'] != null) {
        if (row.attributes['id'].contains(new RegExp("^ccid_"))) {
          classRows.add(row);
        }
      }
    }
  }

  //Individual Class Name and Grade Info
  List<String> classData = [];
  for (dom.Element classRow in classRows) {
    String className = classRow.children[11].text
        .substring(0, classRow.children[11].text.indexOf("Details about") - 1);

    //Must Change Index Number
    //Q1: 12, Q2: 13, S1: 14, Q3: 15, Q4: 16, S2: 17, F1: 18
    String gradeLetter = classRow.children[13].text;
    String gradeNumber = "";
    if (gradeLetter.codeUnits[0] == 160 || gradeLetter == "[ i ]") {
      gradeLetter = "NG";
      gradeNumber = "NG";
    } else {
      int index = gradeLetter.indexOf(new RegExp("[0-9]"));
      gradeNumber = gradeLetter.substring(index);
      gradeLetter = gradeLetter.substring(0, index);
    }
    classData.add(className + ';' + gradeLetter + ";" + gradeNumber);
  }

  return classData;
}

String hash(String a) => sha1.convert(utf8.encode(a)).toString();
