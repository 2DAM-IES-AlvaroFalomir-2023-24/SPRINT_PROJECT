import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sprint/odoo-rpc/odoo_client.dart';

import '../model/user.dart';
import '../odoo-rpc/odoo_exceptions.dart';
import 'dart:convert' as convert;

class OdooConnect{

  static const SPRINT_CONNECTION = String.fromEnvironment("SPRINT_CONNECTION");
  static const SPRINT_USER = String.fromEnvironment("SPRINT_USER");
  static const SPRINT_PASSWORD = String.fromEnvironment("SPRINT_PASSWORD");
  static const SPRINT_DATABASE = String.fromEnvironment("SPRINT_DATABASE");

  static const odooServerURL = SPRINT_CONNECTION;
  static final client = OdooClient(odooServerURL);

  static final logger = Logger();
  
  static void initialize() async{
    await client.authenticate(SPRINT_DATABASE, SPRINT_USER, SPRINT_PASSWORD);
  }

  static Future<List<User>> getUsers() async{
    List<User> found = [];
    try {
      List res = await client.callKw({
        'model': 'res.users', 'method': 'search_read', 'args': [],
        //Selección de campos a mostrar
        'kwargs': {
          //Selección de campos en la query
          "fields":["id", "login", "password", "active", "name", "email", "lang"]
        }
      });
      //Obtención de resultados en formato JSON
      if (res.isNotEmpty) {
        for(var result in res){
          var temp = convert.jsonEncode(result);
          found.add(User.fromJson(convert.jsonDecode(temp)));
        }
      }
    }catch(a){logger.e(a);}
    return found;
  }

  static Future<User?> getUserByEmail(String email) async{
    User? found;
    try {
      if(email.isEmpty){
        throw Exception("Email cannot be empty");
      }
      List res = await client.callKw({
        'model': 'res.users', 'method': 'search_read', 'args': [],
        //Selección de campos a mostrar
        'kwargs': {
          //Filtrado por login
          "domain": [["login", "=", email]],
          //Selección de campos en la query
          "fields":["id", "login", "password", "active", "name", "email", "lang"]
        }
      });
      //Obtención de resultados en formato JSON
      if (res.isNotEmpty) {
        var temp = convert.jsonEncode(res[0]);
        found = User.fromJson(convert.jsonDecode(temp));
      }
    }catch(a){logger.e(a);}
    return found;
  }

  static Future<bool> modifyUser(User user) async{
    try {
      if(user.id == null){
        throw Exception("User id cannot be empty");
      }
      await client.callKw({
        'model': 'res.users', 'method': 'write', 'args': [
          user.id,
          user.toJson()
        ],
        'kwargs': {}
      });
      return true;
    }catch(a){
      logger.e(a);
      return false;
    }
  }

  static Future<bool> createUser(User user) async{
    try {
      if(user.id != null){
        throw Exception("User id cannot be created");
      }
      await client.callKw({
        'model': 'res.users', 'method': 'create', 'args': [
          user.toJson()
        ],
        'kwargs': {}
      });
      return true;
    }catch(a){
      logger.e(a);
      return false;
    }
  }
  
}