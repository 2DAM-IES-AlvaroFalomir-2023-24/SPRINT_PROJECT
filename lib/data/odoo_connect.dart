import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:sprint/odoo-rpc/odoo_client.dart';

import '../model/user.dart';
import 'dart:convert' as convert;

class OdooConnect{

  static String SPRINT_CONNECTION = dotenv.env['SPRINT_CONNECTION'] ?? "";
  static String SPRINT_USER = dotenv.env['SPRINT_USER'] ?? "";
  static String SPRINT_PASSWORD = dotenv.env['SPRINT_PASSWORD'] ?? "";
  static String SPRINT_DATABASE = dotenv.env['SPRINT_DATABASE'] ?? "";

  static String odooServerURL = SPRINT_CONNECTION;
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
        'kwargs': {
          //Filtrado por login
          "domain": [["login", "=", email]],
          //Selección de campos en la query
          "fields":["id", "login", "password", "active", "name", "email", "lang", "image_1920"]
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