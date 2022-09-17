import 'dart:convert';

import 'package:flutter/material.dart';

enum UserSex{
  MALE,
  FEMALE
}

class User{
  String _email;
  String _password;

  String _nickname;
  String _sex;
  String _birthday;
  String _region;

  User(this._email, this._password, this._nickname, this._sex, this._birthday, this._region);

  String get email => _email;
  String get password => _password;
  String get nickname => _nickname;
  String get sex => _sex;
  String get birthday => _birthday;
  String get region => _region;

  Map<String, String> toJson(){
    return {
      "email":    _email,
      "password": _password,
      "nickname": _nickname,
      "sex":      _sex,
      "birthday": _birthday,
      "region":   _region,
    };
  }
}