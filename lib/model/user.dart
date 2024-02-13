import 'package:intl/intl.dart';

import 'gender.dart';
import 'marital_status.dart';

class User{
  User(
      this.name, this.privateEmail,
      this.gender, this.birthday, [this.id, this.active = true, this.barcode, this.workEmail = "", this.phone = "",
        this.marital = MaritalStatus.single, this.drivingLicense = false]);
  final int? id;
  final String name;
  final String privateEmail;
  final bool active;
  final String? barcode;
  final Gender gender;
  final DateTime? birthday;
  final String workEmail;
  final String phone;
  final MaritalStatus marital;
  final bool drivingLicense;

  Map toJson(){
    return {
      'id': id,
      'name': name,
      'private_email': privateEmail,
      'active': active,
      'barcode': barcode,
      'gender': gender.name,
      'birthday': getBirthDate(),
      'work_email': workEmail,
      'phone': phone,
      'marital': marital.name,
      'driving_license': drivingLicense
    };
  }

  Map toPartJson(){
    return {
      'name': name,
      'private_email': privateEmail,
      'active': active,
      'barcode': barcode,
      'gender': gender.name,
      'birthday': getBirthDate(),
      'work_email': workEmail,
      'phone': phone,
      'marital': marital.name,
      'driving_license': drivingLicense
    };
  }

  static User fromJson(Map<dynamic, dynamic> json){
    return User(
        json['name'].toString(),
        json['private_email'].toString(),
        Gender.setGenderByString(json['gender'].toString()),
        json['birthday'].toString() == "false" ? null : DateTime.parse(json['birthday'].toString()),
        json['id'] as int,
        json['active'] as bool,
        json['barcode'] == Null ? "" : json['barcode'].toString(),
        json['work_email'].toString(),
        json['phone'].toString(),
        MaritalStatus.setMaritalByString(json['marital'].toString()),
        json['driving_license'] as bool
    );
  }

  String getBirthDate(){
    if(birthday != null){
      var numFormat = NumberFormat("00", "es_ES");
      return "${birthday!.year}-${numFormat.format(birthday!.month)}-${numFormat.format(birthday!.day)}";
    }else{
      return "null";
    }
  }

  @override
  String toString() {
    return "{\nid: $id,\n"
        "name: $name,\n"
        "private_email: $privateEmail\n"
        "active: $active\n"
        "barcode: $barcode\n"
        "gender: ${gender.name}\n"
        "birthday: ${getBirthDate()}\n"
        "work_email: $workEmail\n"
        "phone: $phone\n"
        "marital: ${marital.name}\n"
        "driving_license: $drivingLicense\n}\n";
  }
}