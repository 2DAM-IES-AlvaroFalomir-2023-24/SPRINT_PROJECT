import 'package:sprint/model/language.dart';

class OdooUser{
  OdooUser(this.email, this.password, this.active, this.name, this.lang, [this.id, this.avatar = "", this.phone = ""]);
  final int? id;
  final String email;
  final String password;
  final bool active;
  final String name;
  String avatar;
  String phone;
  final Language lang;

  static OdooUser fromJson(dynamic json){
    return OdooUser(
      json['email'].toString(),
      json['password'].toString(),
      json['active'] as bool,
      json['name'].toString(),
      Language.setLanguageByString(json['lang'].toString()),
      json['id'] as int,
      json['image_1920'].toString(),
      json['phone'].toString()
    );
  }

  String getEmail(){
    return email;
  }

  Map toJson(){
    return {
      'login': email,
      'password': password,
      'active': active,
      'name': name,
      'email': email,
      'lang': lang.name,
      'image_1920': avatar,
      'phone': phone
    };
  }

  bool isMissingData(){
    return avatar.isEmpty || phone.isEmpty;
  }

}