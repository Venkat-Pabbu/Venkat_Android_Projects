import 'package:androidstudio/phone_verification.dart';
import 'package:androidstudio/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'Register.dart';
import 'Verify.dart';
import 'home_screen/home.dart';
import 'login.dart';
import 'new_login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const welcome(),
    //home:  LoginScreen(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'welcome': (context) => const welcome(),
      'phone': (context) => const MyPhone(),
      'verify': (context) => const MyVerify(),
      'facebook': (context) => const Myfacebook(),
      'home': (context) => Myhome(),
      'new_login': (context) => LoginScreen(),
      //'signup': (context) => createData(),
    },
  ));
}

class Myfacebook extends StatefulWidget {
  const Myfacebook({Key? key}) : super(key: key);

  @override
  State<Myfacebook> createState() => _MyfacebookState();
}

class _MyfacebookState extends State<Myfacebook> {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfisLoggedIn();
  }

  _checkIfisLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;

    setState(() {
      _checking = false;
    });

    if (accessToken != null) {
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    } else {
      _login();
    }
  }

  _login() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }
    setState(() {
      _checking = false;
    });
  }

  _logout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(_userData);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Facebook Auth Project')),
        body: _checking
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _userData != null
                      ? Text('name: ${_userData!['name']}')
                      : Container(),
                  _userData != null
                      ? Text('email: ${_userData!['email']}')
                      : Container(),
                  _userData != null
                      ? Container(
                          child: Image.network(
                              _userData!['picture']['data']['url']),
                        )
                      : Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                      color: Colors.blue,
                      onPressed: _userData != null ? _logout : _login,
                      child: Text(
                        _userData != null ? 'LOGOUT' : 'LOGIN',
                        style: const TextStyle(color: Colors.white),
                      ))
                ],
              )),
      ),
    );
  }
}
