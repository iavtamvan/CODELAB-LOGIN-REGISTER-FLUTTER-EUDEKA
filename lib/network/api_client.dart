import 'package:codelab_register_login/config/config.dart';
import 'package:codelab_register_login/model/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class ApiClient{
  static Future<LoginModel> getToken({
  @required String email,
    @required String password,
}) async {
    Response _response = await post(
      Uri.https(Config.baseDomain, "/api/login"),
      body: <String, dynamic>{
        "email": email,
        "password": password,
      },
    );
    return LoginModel.fromJson(_response.body);
  }
  static Future<LoginModel> postRegister({
  @required String email,
    @required String password,
}) async {
    Response _response = await post(
      Uri.https(Config.baseDomain, "/api/register"),
      body: <String, dynamic>{
        "email": email,
        "password": password,
      },
    );
    return LoginModel.fromJson(_response.body);
  }
}