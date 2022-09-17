import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:unnamed_project/models/user.dart';

enum StatusCode{
  OK          (code: 200),
  CREATED     (code: 201),
  NO_CONTENT  (code: 204),
  BAD_REQUEST (code: 400),
  UNAUTHORIZED(code: 401),
  NOT_FOUND   (code: 404),
  UNSUPPORTED_MEDIA_TYPE(code: 415),
  INTERNAL_SERVER_ERROR (code: 500),
  BAD_GATEWAY (code: 502);

  const StatusCode({required this.code});
  final int code;

  String get codeToString => "${code}";
}

class httpTestWidget extends StatefulWidget {
  const httpTestWidget({Key? key}) : super(key: key);

  @override
  State<httpTestWidget> createState() => _httpTestWidgetState();
}

class _httpTestWidgetState extends State<httpTestWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async { print('pressed'); return false;},
      child: Scaffold(
        body: Row(
          children: [
            TextButton(onPressed: (){httpModel().testSignup();}, child: Text('signup')),
            TextButton(onPressed: (){httpModel().testLogin();}, child: Text('login')),
            TextButton(onPressed: (){httpModel().testCreateArticle();}, child: Text('create')),
          ],
        ),
      ),
    );
  }
}

class httpModel{
  static String address = 'http://skysrd.iptime.org:8080';

  late String accessToken = '';
  late String refreshToken = '';

  static final httpModel _instance = httpModel._internal();

  factory httpModel() => _instance;

  final defaultHeader = {
  HttpHeaders.contentTypeHeader : 'application/json',
  HttpHeaders.acceptHeader : 'application/json'
  };

  getAuthHeader(String authToken) =>{
    HttpHeaders.contentTypeHeader : 'application/json',
    HttpHeaders.acceptHeader : 'application/json',
    HttpHeaders.authorizationHeader : 'Bearer $authToken'
  };

  httpModel._internal(){
    //init
  }

  Future<bool> testSignup() async
    => signup("testEmail@gmail.com", "testPassword", "testNick", "MAN", "20001225", "Daegu");

  Future<bool> signup(String email, String password, String sex, String nickname, String birthday, String region) async {
    var user = jsonEncode(User(email, password, nickname, sex, birthday, region).toJson());

    var postBody = jsonEncode(<String, dynamic>{
      "birthDay": birthday.substring(0,4),
      "birthMonth": birthday.substring(4,6),
      "birthYear": birthday.substring(6,8),
      "collectionInfoDtoList": [{"agreeYn": "Y","id": 0}],
      "email": email,
      "nickname": nickname,
      "password": password,
      "sex": "MAN",
      "username": nickname,
    });

    print(postBody);

    var response = await http.post(
        Uri.parse('$address/api/auth/signup'),
        headers: getAuthHeader(base64Encode(utf8.encode('$email:$password'))),
        body: postBody,
    );
    if(response.statusCode == StatusCode.OK.code){
      print(response.body);
      return true;
    }
    else{
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }

  Future<bool> testLogin() async{
    return login("test@gmail.com", "test123");
  }

  Future<bool> login(String id, String pw) async {

    var encoded = "Basic ${base64Encode(utf8.encode('$id:$pw'))}";
    print(encoded);
    var response = await http.post(
      Uri.parse('$address/api/auth/login'),
      headers: defaultHeader,
      body: encoded
    );
    if(response.statusCode == StatusCode.OK.code){
      print(response.body);

      var responseBody = jsonDecode(response.body);
      accessToken = responseBody['data']['accessToken'];
      refreshToken = responseBody['data']['refreshToken'];

      return true;
    }
    else{
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }

  Future<bool> testLogout() async {
    var response = await http.post(
        Uri.parse('$address/api/auth/logout'),
        headers: defaultHeader,
        body: jsonEncode(<String, String>{
          "accessToken" : accessToken,
          "refreshToken" : refreshToken
        })
    );
    if(response.statusCode == StatusCode.OK.code){
      print(response.body);
      return true;
    }
    else{
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }

  Future<bool> testCreateArticle() async {
    var response = await http.post(
        Uri.parse('$address/api/board/article'),
        headers: getAuthHeader(accessToken),
        body: jsonEncode(<String, String>{
          "articleId": '1',
          "categoryId": '1',
          "content": "string",
          "filePath": "string",
          "hitCount": '0',
          "isHidden": "N",
          "title": "string"
        })
    );
    if(response.statusCode == StatusCode.OK.code){
      print('created success\n${response.body}');
      return true;
    }
    else if(response.statusCode == StatusCode.UNAUTHORIZED.code){
      print('unauthorized\n${response.body}');
      var responseBody = jsonDecode(response.body);
      if(responseBody['error']['code'] == 'EXPIRED_TOKEN'){
        if(await testReissue()) {
          return await testCreateArticle();
        }
      }
      return false;
    }
    else{
      print('error' + '${response.statusCode}' + response.body);
      return false;
    }
  }

  Future<bool> testReissue() async {
    var response = await http.post(
        Uri.parse('$address/api/auth/reissue'),
        headers: defaultHeader,
        body: jsonEncode(<String, String>{
          "accessToken" : accessToken,
          "refreshToken" : refreshToken
        })
    );
    if(response.statusCode == StatusCode.OK.code){
      print('reissue success\n${response.body}');

      var responseBody = jsonDecode(response.body);
      accessToken = responseBody['data']['accessToken'];
      refreshToken = responseBody['data']['refreshToken'];
      return true;
    }
    else{
      print('reissue unsuccessful\n' + '${response.statusCode}\n' + response.body);
      return false;
    }
  }
}