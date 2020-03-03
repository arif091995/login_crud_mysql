import 'package:flutter/material.dart';
import 'package:login_crud_mysql/data/model/barang_mdl.dart';
import 'package:login_crud_mysql/data/utils/toast_utils.dart';
import 'package:login_crud_mysql/services/barang_service.dart';
import 'package:login_crud_mysql/services/shared_preference.dart';
import 'package:login_crud_mysql/ui/widget/inkwell_simpan.dart';
import 'package:login_crud_mysql/ui/widget/text_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahItem extends StatefulWidget {
  final Data data;

  TambahItem({this.data});

  @override
  _TambahItemState createState() => _TambahItemState();
}

class _TambahItemState extends State<TambahItem> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> Scaffoldkey = GlobalKey<ScaffoldState>();

  // variabel member class
  final _nmBarang = TextEditingController();
  final _jumlah = TextEditingController();
  String idUser;

    //EDIT BARANG
    //ADD BARANG
    Future<void> addBarang(BuildContext context, String id) async {
    if (_nmBarang.text.isNotEmpty && _jumlah.text.isNotEmpty) {
      Map<String, dynamic> data = {
        "id_user" : id,
        "nama_barang": _nmBarang.text,
        "jumlah": _jumlah.text
      };

      ToastUtils.show("mencoba lagi");
      var response = await BarangService.addBarang(data);
      print("status: " + response.status.toString());
      print("messega: " + response.message.toString());
      print("id: " +id);

      List<Data> dataBarang = response.data;

      if (response.status == 'success') {
        //ToastUtils.show(" ${dataBarang[3].namaBarang} tersimpan");

        Navigator.pushNamedAndRemoveUntil(
            context, "/Home", (Route<dynamic> routes) => false);
      } else {
        ToastUtils.show(response.message.toString());
      }
    }
  }

  savePref(String id, String nama) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
     pref.setString("id_user", id);
    });
  }

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    idUser = pref.getString('id_user');
    print("id_User: " +idUser);
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Barang", style: TextStyle(color: Colors.white)),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextInput(
                  textLabel: "Nama Barang",
                  textController: _nmBarang,
                  textError: "Nama Barang Kosong",
                ),
                SizedBox(
                  height: 10,
                ),
                TextInput(
                  textLabel: "Jumlah",
                  textController: _jumlah,
                  textError: "Jumlah Barang Kosong",
                ),
                SizedBox(
                  height: 20,
                ),
                 ButtonSimpan(
                  name: "Simpan",
                  action: () {
                    if (formkey.currentState.validate()) {
                      formkey.currentState.save();
                    }
                    addBarang(context, idUser);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
