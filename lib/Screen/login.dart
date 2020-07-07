import 'package:flutter/material.dart';
import 'package:test_flutter_aos/Utils/Services.dart';

import 'ask_permission.dart';
import 'main_menu.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final editTextController = TextEditingController();
  final passwordTextCo = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool obscure = true;

  void processLogin() async {
    if(editTextController.text == "admin" && passwordTextCo.text == "admin"){
      bool permissionCheck = await checkPermission();
      if (permissionCheck) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AskPermission()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: body()
    );
  }

  Widget body(){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Center(child: Image.asset('assets/aos_logo.png')),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  email(),
                  password(),
                ],
              ),
            ),
            loginButton(),
          ],
        ),
      ),
    );
  }

  Widget password(){
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        autofocus: false,
        validator: (value) {
          if (value.isEmpty) {
            return 'Password Tidak Boleh Kosong';
          }
          return null;
        },
        controller: passwordTextCo,
        obscureText: obscure,
        decoration: InputDecoration(
          suffixIcon: obscure ? IconButton(
            onPressed: (){
              setState(() {
                obscure = false;
              });
            },
            icon: Icon(Icons.visibility),
          ): IconButton(
            onPressed: (){
              setState(() {
                obscure = true;
              });
            },
            icon: Icon(Icons.visibility_off),
          ),
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }

  Widget email(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Username Tidak Boleh Kosong';
        }
        return null;
      },
      controller: editTextController,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }

  Widget loginButton(){
   return  Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            processLogin();
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.red,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
