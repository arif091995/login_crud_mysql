import 'package:flutter/material.dart';
import 'package:login_crud_mysql/data/utils/toast_utils.dart';
import 'package:login_crud_mysql/services/auth_service.dart';
import 'package:login_crud_mysql/ui/widget/inkwell_simpan.dart';
import 'package:login_crud_mysql/ui/widget/text_input.dart';
import 'package:login_crud_mysql/ui/widget/text_password.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> Scaffoldkey = GlobalKey<ScaffoldState>();

  // variabel member class
  final nama = TextEditingController();
  final email = TextEditingController();
  final no_hp = TextEditingController();
  final password = TextEditingController();
  final ulangiPassword = TextEditingController();

  // member response
  String _response = '';
  bool _apiCall = false;
  String _id_user = '';
  String _user_name = '';
  String _email = '';
  bool _check = false;
  bool _passwordVisible;

  void register() async {
    if (nama.text.isNotEmpty &&
        email.text.isNotEmpty &&
        no_hp.text.isNotEmpty &&
        password.text.isNotEmpty &&
        ulangiPassword.text.isNotEmpty) {
      if (password.text == ulangiPassword.text) {
        Map<String, dynamic> data = {
          "nama": nama.text,
          "email": email.text,
          "no_hp": no_hp.text,
          "password": password.text
        };

        ToastUtils.show("Mencoba Mendaftar");
        var response = await AuthServices.register(data);
        if (response.status == "success") {
           ToastUtils.show(response.message);
             Navigator.pushNamedAndRemoveUntil(context, "/login",(Route<dynamic> routes) => false);
        }else{
           ToastUtils.show(response.message);
        }
      }
    }
  }

  @override
  void initState() {
    _passwordVisible = false;
    _check = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 100),
              child: Image.asset(
                'assets/images/time.jpg',
                height: 300,
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 250),
            child: Column(
              children: <Widget>[
                Container(
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 15.0),
                            blurRadius: 15.0),
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, -10.0),
                            blurRadius: 10.0),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Form(
                          key: formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Daftar",
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              //TextInput Nama
                              TextInput(
                                textLabel: "Nama",
                                iconData: Icons.people,
                                textController: nama,
                                textError: "Cek Nama",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //TextInput Email
                              TextInput(
                                textLabel: "Email",
                                iconData: Icons.email,
                                textController: email,
                                textError: "Cek Email",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //TextInput HP
                              TextInput(
                                textLabel: "No HP",
                                iconData: Icons.phone,
                                textController: no_hp,
                                textError: "Cek No HP",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //Text Input Password
                              TextPassword(
                                textController: password,
                                textHint: "Password",
                                passwordVisible: _passwordVisible,
                                action: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //Text Input Password
                              TextPassword(
                                textController: ulangiPassword,
                                textHint: "Ulangi Password",
                                passwordVisible: _passwordVisible,
                                action: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //Ketentuan
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: _check,
                        onChanged: (bool value) {
                          setState(() {
                            _check = value;
                          });
                        },
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Saya setuju memahami",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    "Syarat ",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                                Text(
                                  "dan",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    "Ketentuan ",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                                Text(
                                  "Serta manfaat produk ini",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                //Button
                ButtonSimpan(
                  name: "Daftar",
                  action: () {
                    if (formkey.currentState.validate()) {
                      formkey.currentState.save();
                    }
                    register();
                  },
                ),
                //to Register
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10, bottom: 50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Sudah Punya Akun? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(context, "/Login",
                                (Route<dynamic> routes) => false);
                          },
                          child: Text(
                            "Masuk Sekarang!",
                            style: TextStyle(color: Colors.green[400]),
                          ),
                        ),
                      ]),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
