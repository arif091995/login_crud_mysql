import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextEditingController textController;
  String textLabel;
  IconData iconData;
  String textError;

  TextInput({this.iconData, this.textLabel, this.textController, this.textError});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: Icon(iconData),
          labelText: textLabel,
          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value){
          if(value.isEmpty){
            return textError;
          }
            return null;
        } ,
      ),
    );
  }
}
