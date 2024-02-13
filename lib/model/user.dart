import 'package:intl/intl.dart';
import 'package:sprint/model/language.dart';

import 'gender.dart';
import 'marital_status.dart';

class User{
  const User(this.login, this.password, this.active, this.name, this.email, this.lang, [this.id]);
  final int? id;
  final String login;
  final String password;
  final bool active;
  final String name;
  final String email;
  final Language lang;

  static User fromJson(dynamic json){
    return User(
      json['login'].toString(),
      json['password'].toString(),
      json['active'] as bool,
      json['name'].toString(),
      json['email'].toString(),
      Language.setLanguageByString(json['lang'].toString()),
    );
  }

  Map toJson(){
    return {
      'login': login,
      'password': password,
      'active': active,
      'name': name,
      'email': email,
      'lang': lang.name
    };
  }

}