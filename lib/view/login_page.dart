import 'package:codelab_register_login/model/login_model.dart';
import 'package:codelab_register_login/network/api_client.dart';
import 'package:codelab_register_login/view/home_page.dart';
import 'package:codelab_register_login/view/register_page.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _globalKey;
  TextEditingController _controllerEmail;
  TextEditingController _controllerPassword;
  ProgressDialog progresDialog;

  @override
  Widget build(BuildContext context) {
    progresDialog = ProgressDialog(context);
    progresDialog =  ProgressDialog(context,type: ProgressDialogType.Normal ,isDismissible: true, showLogs: true);
    progresDialog.style(message: 'Loging....');
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
      controller: _controllerEmail,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'iav@eudeka.id',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _controllerPassword,
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
            _checkAccount();
          },
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final register = FlatButton(
      child: Text(
        'Register New Account',
        style: TextStyle(color: Colors.black45),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(Register.tag);
      },
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot Password',
        style: TextStyle(color: Colors.black45),
      ),
      onPressed: () {},
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
            register,
            forgotLabel
          ],
        ),
      ),
    );
  }

  void _checkAccount() {
    if (_controllerEmail.text.toString().isEmpty || _controllerPassword.text.toString().isEmpty){
      _globalKey.currentState
          .showSnackBar(SnackBar(content: Text('Required username and password')));
    } else{
      progresDialog.show();
      _sendLogin();
    }
  }
  void _sendLogin() async {
    LoginModel _loginModel = await ApiClient.getToken(
        // email example = eve.holt@reqres.in
        email: _controllerEmail.text.trim(),
        // password example = cityslicka
        password: _controllerPassword.text.trim(),
    );
    if (_loginModel.token != null) {
      // Navigator.of(context).pushNamed(HomePage.tag);
      _globalKey.currentState
          .showSnackBar(SnackBar(content: Text(_loginModel.token)));
      progresDialog.hide();
      Navigator.of(context).pushNamed(HomePage.tag);
    } else {
      _globalKey.currentState
          .showSnackBar(SnackBar(content: Text(_loginModel.error)));
      progresDialog.hide();
    }
  }

  @override
  void initState() {
    _globalKey = GlobalKey<ScaffoldState>();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    super.initState();
  }
}
