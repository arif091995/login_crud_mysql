import 'package:flutter/material.dart';
import 'package:login_crud_mysql/data/utils/toast_utils.dart';
import 'package:login_crud_mysql/services/auth_service.dart';
import 'package:login_crud_mysql/services/shared_preference.dart';
import 'package:login_crud_mysql/ui/widget/inkwell_simpan.dart';
import 'package:login_crud_mysql/ui/widget/text_input.dart';
import 'package:login_crud_mysql/ui/widget/text_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  SessionManager pref = SessionManager();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> Scaffoldkey = GlobalKey<ScaffoldState>();

  // variabel member class
  final email = TextEditingController();
  final password = TextEditingController();
  String id_user;

  // member response
  String _response = '';
  bool _apiCall = false;
  String _id_user = '';
  String _user_name = '';
  String _email = '';

  bool _passwordVisible;
  

  @override
  void initState() {
    _passwordVisible = false;
    getPref();
    super.initState();
  }


  Future<void> login(BuildContext context) async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      Map<String, dynamic> data = {
        "email": email.text,
        "password": password.text
      };

      ToastUtils.show("mencoba lagi");
      var response = await AuthServices.login(data);
      print("status: " + response.status.toString());
      print("messega: " + response.message.toString());

      if (response.status == 'success') {
        ToastUtils.show("Welcome " + response.data.email.toString());

        savePref(
          response.data.id.toString(),
          response.data.nama.toString(),
        );

        //pref.setAuthToken(response.data.id);

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
     pref.setString("nama", nama);

     print("id user: " +id);
    });
  }

  

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final nama = pref.getString("nama");

    // if (nama != null) {
    //     Navigator.pushNamedAndRemoveUntil(context, "/Home", (Route<dynamic> routes) => false);
    //     Navigator.pushNamedAndRemoveUntil(context, "/Tambah", (Route<dynamic> routes) => false);
    // }
  }

  //void _callApiLogin(){
  // UserLogin().getUser(email, password).then((response)async{
  //   // jika respon normal
  //   setState(() {
  //     _apiCall = false;
  //     _email = response.email;
  //   });
  // });
  //   UserLogin().getData(email, password).then((response)async{
  //     setState(() {
  //      _apiCall = false;
  //      _email = response.email;
  //      _id_user = response.id;

  //      print(_id_user);
  //        Navigator.push(context, MaterialPageRoute(builder: (context) => Halaman_Home()));
  //     });
  //   });
  // }

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
                  height: 240,
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
                                    "Login",
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
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
                              //Lupa Password
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 10),
                                      child: Text(
                                        "Lupa Password?",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    )
                                  ])
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
                //Button
                ButtonSimpan(
                  name: "Masuk",
                  action: () {
                    if (formkey.currentState.validate()) {
                      formkey.currentState.save();
                    }
                    login(context);
                  },
                ),
                //to Register
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Belum Punya Akun? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(context, "/Register",
                                (Route<dynamic> routes) => false);
                          },
                          child: Text(
                            "Daftar Sekarang!",
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
