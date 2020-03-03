import 'package:dio/dio.dart';
import 'package:login_crud_mysql/data/model/barang_mdl.dart';
import 'package:login_crud_mysql/data/res/Strings/api_string.dart';

class BarangService{
  static Dio dio = new Dio();
  static Future <Barang> getAllId(Map data) async{
    var response = await dio.post(
      Appstrings.TampilBarang,
      data: FormData.fromMap(data),
      options: Options(
       headers: {
          "Accept": "application/json"
        }
      )
    );
    return Barang.fromJson(response.data);
  }

  //Get barang data
  static Future<List<Data>> getAll() async {
    var response = await dio.get(
      Appstrings.TampilBarang,
      options: Options(
        headers: {
          "Accept": "application/json"
        }
      )
    );

    var _barangData = List<Data>();
    response.data["data"].forEach((value) {
      _barangData.add(Data.fromJson(value));
    });

    print(_barangData[0].namaBarang);

    return _barangData;
  }

  static Future <Barang> addBarang(Map data) async{
    var response = await dio.post(
      Appstrings.InsertBarang,
      data: FormData.fromMap(data),
      options: Options(
       headers: {
          "Accept": "application/json"
        }
      )
    );
    return Barang.fromJson(response.data);
  }  

  static Future <Barang> DeleteBarang(Map data) async{
    var response = await dio.post(
      Appstrings.DeleteBarang,
      data: FormData.fromMap(data),
      options: Options(
       headers: {
          "Accept": "application/json"
        }
      )
    );
    return Barang.fromJson(response.data);
  }  
}