import 'package:sprint/model/language.dart';

class User{
  const User(this.email, this.password, this.active, this.name, this.lang, [this.id, this.avatar = ""]);
  final int? id;
  final String email;
  final String password;
  final bool active;
  final String name;
  final String avatar;
  final Language lang;

  static User fromJson(dynamic json){
    return User(
      json['email'].toString(),
      json['password'].toString(),
      json['active'] as bool,
      json['name'].toString(),
      Language.setLanguageByString(json['lang'].toString()),
      json['id'] as int,
      json['image_1920'].toString(),
    );
  }

  Map toJson(){
    return {
      'login': email,
      'password': password,
      'active': active,
      'name': name,
      'email': email,
      'lang': lang.name,
      'image_1920': avatar
    };
  }

}