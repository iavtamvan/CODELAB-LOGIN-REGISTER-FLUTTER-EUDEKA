import 'package:codelab_register_login/model/login_model.dart';
import 'package:codelab_register_login/network/api_client.dart';
import 'package:codelab_register_login/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Register extends StatefulWidget {
  static String tag = 'register-page';

  @override
  _Register createState() => new _Register();
}

class _Register extends State<Register> {
  GlobalKey<ScaffoldState> _globalKey;
  TextEditingController _controllerEmails;
  TextEditingController _controllerPasswords;
  ProgressDialog progresDialog;
  SnackBar snackBar;

  @override
  Widget build(BuildContext context) {
    progresDialog = ProgressDialog(context);
    progresDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    progresDialog.style(message: 'Registering....');

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/eudeka_icon.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _controllerEmails,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'iav@eudeka.id',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _controllerPasswords,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            // Navigator.of(context).pushNamed(LoginPage.tag);
            _checkAccount();
          },
          color: Colors.lightBlueAccent,
          child: Text('Register', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(
              height: 48.0,
            ),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
          ],
        ),
      ),
    );
  }

  void _checkAccount() {
    if (_controllerEmails.text.toString().isEmpty ||
        _controllerPasswords.text.toString().isEmpty) {
      _globalKey.currentState.showSnackBar(
          SnackBar(content: Text('Required username and password')));
    } else {
      progresDialog.show();
      _postRegister();
    }
  }

  void _postRegister() async {
    LoginModel _loginModel = await ApiClient.postRegister(
      // email example = eve.holt@reqres.in
      email: _controllerEmails.text.trim(),
      // password example = cityslicka
      password: _controllerPasswords.text.trim(),
    );
    if (_loginModel.token != null) {
      // Navigator.of(context).pushNamed(HomePage.tag);
      _globalKey.currentState
          .showSnackBar(SnackBar(content: Text("Succes Register with Token :" + _loginModel.token)));
      progresDialog.hide();
      Navigator.of(context).pushNamed(LoginPage.tag);
    } else {
      _globalKey.currentState
          .showSnackBar(SnackBar(content: Text(_loginModel.error)));
      progresDialog.hide();
    }
  }
  @override
  void initState() {
    _globalKey = GlobalKey<ScaffoldState>();
    _controllerEmails = TextEditingController();
    _controllerPasswords = TextEditingController();
    super.initState();
  }
}
