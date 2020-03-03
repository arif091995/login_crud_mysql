// import 'dart:convert';

// import 'package:login_crud_mysql/data/model/response_login.dart';
// import 'package:http/http.dart' as http;
// import 'package:login_crud_mysql/data/res/Strings/api_string.dart';

//class UserLogin {
  // Future<Data> getUser(var email,var password ) async {
  //   return await http.post(Uri.encodeFull(Appstrings.LoginUrl), body: {
  //     'email': email,
  //     'password': password
  //   }, headers: {
  //     "Accept": "application/json"
  //   }).then((http.Response response) {
  //     final int statusCode = response.statusCode;
  //     var dataUser = json.decode(response.body);
  //     Data user = LoginUser.fromJson(dataUser).data;
  //     if (statusCode < 200 || statusCode > 400 || json == null) {
  //       throw new Exception("Error while fetching data");
        
  //     }
  //     return user;
  //   });
  // }
  // Future <Data> getData(var email, var password) async{
  //   return await http.post(Uri.encodeFull(Appstrings.LoginUrl), body:{
  //     'email': email.toString(),
  //     'password': password.toString()
      
  //   }, headers: {"Accept":"application/json"} ).then((http.Response response) {
  //     final int statusCode = response.statusCode;
  //     print(statusCode);
  //     print(email);
  //     print(password);
  //     if (statusCode < 200 || statusCode > 400 || json == null) {
  //       throw new Exception("Error while fetching data");
  //     }
  //     return Data.fromJson(json.decode(response.body));

  //   });
    // if (response.statusCode == 200){
    //   var data = json.decode(response.body);
    //   Data user = LoginUser.fromJson(data).data;
    //   //print("email : "+email);
    //   return user;
    // }else{
    //   print(response.statusCode.toString());
    //   throw Exception('Failed load data with status code ${response.statusCode}');
    // }
//   }
// }


