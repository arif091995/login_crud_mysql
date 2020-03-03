
import 'package:dio/dio.dart';
import 'package:login_crud_mysql/data/model/response_login.dart';
import 'package:login_crud_mysql/data/res/Strings/api_string.dart';

class AuthServices{
  static Dio dio = new Dio();
  static Future<LoginUser> login(Map loginData) async{
    var response = await dio.post(
      Appstrings.LoginUrl, data: FormData.fromMap(loginData),
      options: Options(
        headers: {
          "Accept": "application/json"
        }
      )
    );
    return LoginUser.fromJson(response.data);
  }

  static Future<LoginUser> register(Map registerData) async {
    var response = await dio.post(
      Appstrings.RegisterUrl, data: FormData.fromMap(registerData),
      options: Options(
         headers: {
          "Accept": "application/json"
        }
      )
    );
    return LoginUser.fromJson(response.data);
  }
}