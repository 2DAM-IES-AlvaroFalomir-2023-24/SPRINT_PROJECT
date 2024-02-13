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
  
  static void initialize() async{
    await client.authenticate(SPRINT_DATABASE, SPRINT_USER, SPRINT_PASSWORD);
    var logger = Logger();
    logger.i("$SPRINT_DATABASE - $SPRINT_USER - $SPRINT_PASSWORD - $SPRINT_CONNECTION");
  }

  /*static Future<User> getUserByEmail() async{
    var logger = Logger();
    try {
      List res = await client.callKw({
        'model': 'res.users',
        'method': 'search_read',
        'args': [],
        //Selección de campos a mostrar
        'kwargs': {
          "domain": [["login", "=", "damproyectoflutter@gmail.com"]],
          "fields":["id", "login", "password", "active", "name", "email", "lang", "tz"]
        }
      });
      //Obtención de resultados en formato JSON
      if (res.isNotEmpty) {
        for (var result in res) {
          var temp = convert.jsonEncode(result);
          logger.i(convert.jsonDecode(temp));
        }
      }
    }catch(a){
      print(a);
    }
  }*/
  
}