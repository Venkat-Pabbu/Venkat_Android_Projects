import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class UserCredentials {
  final String email;
  final String password;

  UserCredentials(this.email, this.password);
}

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late String Email, Password;
  bool passToggle = true;

  getEmail(email) {
    Email = email;
  }

  getPassword(password) {
    Password = password;
  }

  LoginData() {
    print("Account Created");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('CustomerLogin').doc(Email);
    //create map
    Map<String, dynamic> students = {
      "Email": Email,
      "Password": Password,
    };
    documentReference
        .set(students)
        .whenComplete(() => {print("$Email Login Success")});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/glass.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
                color: Colors.white,
              ),
            )),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 20),
              child: const Text(
                'Start your Party with us.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Colors.white70,
                                  filled: true,
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: Icon(Icons.email)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Email';
                                } else if (!value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            //onChanged: (String email){
                            //getEmail(email);
                            //},
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _passwordController,
                              obscureText: passToggle,
                              style: const TextStyle(color: Colors.black),
                              //obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.white70,
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        passToggle = !passToggle;
                                      });
                                    },
                                    child: Icon(passToggle
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  )),

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              // onChanged: (String password){
                              //   getEmail(password);
                              // },
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),

                          //################Only SignIn Btn###################

                          TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final credentials = UserCredentials(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                  if (isValidCredentials(credentials)) {
                                    Navigator.pushNamed(context, 'home');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Invalid credentials')),
                                    );
                                  }
                                }
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),

                          //**************Old Login Btn With Symbol**************

                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'LogIn',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xFFFCE4EC),
                                child: IconButton(
                                    color: Colors.black,
                                    onPressed: () {
                                      showAlert();
                                      if (_formKey.currentState!.validate()) {
                                        final credentials = UserCredentials(
                                          _usernameController.text,
                                          _passwordController.text,
                                        );
                                        if (isValidCredentials(credentials)) {
                                          Navigator.pushNamed(context, 'home');
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Invalid credentials')),
                                          );
                                        }
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),*/
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'register');
                                },
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Create Account',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'phone');
                                  },
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidCredentials(UserCredentials credentials) {
    return credentials.email == '1' && credentials.password == '2';
  }

  void showAlert() {
    QuickAlert.show(
        context: context,
        title: "Login",
        text: "successful",
        type: QuickAlertType.success);
  }
}
