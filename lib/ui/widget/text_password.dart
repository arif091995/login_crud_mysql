import 'package:flutter/material.dart';

class TextPassword extends StatelessWidget {
  // Initially password is obscure
  bool passwordVisible = true;
  Function action;
  Function textInput;
  String textHint;
  TextEditingController textController;

  TextPassword(
      {this.passwordVisible,
      this.action,
      this.textHint,
      this.textInput,
      this.textController});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
          maxLines: 1,
          controller: textController,
          autofocus: false,
          obscureText: passwordVisible,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border:OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: Icon(Icons.vpn_key),
              labelText: textHint,
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: action,
              )),
          validator: (value) => value.isEmpty ? 'Cek Password' : null,
          onSaved: textInput,
        ),
    );
  }
}
