import 'package:flutter/material.dart';
import 'package:login_crud_mysql/ui/page/add_page.dart';
import 'package:login_crud_mysql/ui/page/home_page.dart';
import 'package:login_crud_mysql/ui/page/login_page.dart';
import 'package:login_crud_mysql/ui/page/register_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        "/login": (context) => Login(),
        "/Home": (context) => Halaman_Home(),
        "/Register": (context) => Register(),
        "/Tambah": (context) => TambahItem(),
      },
    );
  }
}