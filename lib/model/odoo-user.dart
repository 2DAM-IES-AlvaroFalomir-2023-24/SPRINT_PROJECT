import 'package:sprint/model/language.dart';

class OdooUser{
  OdooUser(this.email, this.password, this.active, this.name, this.lang, [this.id, this.avatar = "", this.phone = "", this._deletionRequestDate, this._isDeletionRequested = false]);
  final int? id;
  final String email;
  final String password;
  final bool active;
  final String name;
  String avatar;
  String phone;
  final Language lang;
  DateTime? _deletionRequestDate; // Fecha de solicitud de baja
  bool _isDeletionRequested; // Indica si el usuario ha solicitado la baja

  DateTime? get deletionRequestDate => _deletionRequestDate;
  bool get isDeletionRequested => _isDeletionRequested;

  set deletionRequestDate(DateTime? date) {
    _deletionRequestDate = date;
  }

  set isDeletionRequested(bool requested) {
    _isDeletionRequested = requested;
  }

  static OdooUser fromJson(dynamic json){
    return OdooUser(
      json['email'].toString(),
      json['password'].toString(),
      json['active'] as bool,
      json['name'].toString(),
      Language.setLanguageByString(json['lang'].toString()),
      json['id'] as int,
      json['image_1920'].toString(),
      json['phone'].toString(),
      json['deletionRequestDate'] == null ? null : DateTime.parse(json['deletionRequestDate']),
      json['isDeletionRequested'] ?? false,
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
      'phone': phone,
      'deletionRequestDate': _deletionRequestDate?.toIso8601String(),
      'isDeletionRequested': _isDeletionRequested,
    };
  }

  bool isMissingData(){
    return avatar == "false" || phone == "null";
  }

}