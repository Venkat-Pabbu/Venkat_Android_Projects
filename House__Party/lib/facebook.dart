import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/dark.jpg'), fit: BoxFit.cover),
      ),
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              title: const Text('Continue with Facebook'),
              backgroundColor: Colors.transparent,
              elevation: 0),
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
                        /*? Text('email: ${_userData!['email']}')
                        : Container(),
                    _userData != null*/
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
      ),
    );
  }
}
