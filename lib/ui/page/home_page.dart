import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:login_crud_mysql/data/model/barang_mdl.dart';
import 'package:login_crud_mysql/data/utils/toast_utils.dart';
import 'package:login_crud_mysql/services/barang_service.dart';
import 'package:login_crud_mysql/ui/page/add_page.dart';
import 'package:login_crud_mysql/ui/widget/inkwell_simpan.dart';
import 'package:login_crud_mysql/ui/widget/text_input.dart';
import 'package:login_crud_mysql/ui/widget/text_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Halaman_Home extends StatefulWidget {
  @override
  _Halaman_HomeState createState() => _Halaman_HomeState();
}

class _Halaman_HomeState extends State<Halaman_Home> {
  String id_user, nama;
  String idUser;
  List<Data> barang;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    idUser = pref.getString('id_user');
    tampilData(idUser);
    print("iduser2 : " + idUser);
  }

  //DELETE BARANG

  //TAMPIL BARANG
  void tampilData(String id) async {
    Map<String, dynamic> data = {"id_user": id};
    //print("iduser3 : "+id);

    var response = await BarangService.getAllId(data);

    if (response.status == "success1") {
      ToastUtils.show(response.message);
      setState(() {
        barang = response.data;
      });
    }
  }

  // logout() {
  //   ToastUtils.show("Mencoba Logout");
  //   savePref();
  //   Future.delayed(const Duration(milliseconds: 2000), () {
  //     ToastUtils.show("Berhasil Logout");
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, "/login", (Route<dynamic> routes) => false);
  //   });
  // }

  // savePref() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     pref.remove('name');
  //     pref.remove('id_user');
  //   });
  // }

  // getPref() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     id_user = pref.getString("id_user");
  //     nama = pref.getString("nama");
  //     //print("id user: " +id_user);
  //   });

  //   if (nama != null) {
  //   } else {
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, "/login", (Route<dynamic> routes) => false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (barang == null) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("List Barang", style: TextStyle(color: Colors.white)),
        leading: Icon(
          Icons.extension,
          color: Colors.white,
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TambahItem())),
                child: Icon(
                  Icons.add_circle,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Bagian ini untuk itemnya
              Text(
                "Daftar Barang",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: barang.length,
                  itemBuilder: (context, index) {
                    //Menambah Item List
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        elevation: 1,
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TambahItem(
                                        data: barang[index],
                                      ))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              title: Text(barang[index].namaBarang),
                              subtitle: Text(barang[index].jumlah),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
