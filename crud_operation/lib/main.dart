import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String Name, Email, Password;

  getName(name) {
    Name = name;
  }

  getEmail(email) {
    Email = email;
  }

  getPassword(password) {
    Password = password;
  }

// Writing Data from Register Page into DataBase.
  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('customer').doc(Name);
    Map<String, dynamic> customers = {
      "Name": Name,
      "Email": Email,
      "Password": Password,
    };
    documentReference
        .set(customers)
        .whenComplete(() => {print("$Name Created")});
  }

// Reading Data from DataBase and print in output console.
  readData() {
    print("Read");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("customer").doc(Name);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data());
    });
  }

  updateData() {
    print("Updated");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('customer').doc(Name);

//create map
    Map<String, dynamic> customers = {
      "Name": Name,
      "Email": Email,
      "Password": Password,
    };
    documentReference
        .set(customers)
        .whenComplete(() => {print("$Name updated")});
  }

  deleteData() {
    print("Deleted");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('customer').doc(Name);
    documentReference.delete().whenComplete(() {
      print("$Name deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WELCOME TO PABBU'S REGISTER PAGE"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String name) {
                  getName(name);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String email) {
                  getEmail(email);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String password) {
                  getPassword(password);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                    child: const Text('Create'),
                    onPressed: () {
                      createData();
                    }),
                ElevatedButton(
                    child: const Text('Read'),
                    onPressed: () {
                      readData();
                      //Navigator.pushNamed(context, 'read');
                    }),
                ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () {
                      updateData();
                    }),
                ElevatedButton(
                    child: const Text('Delete'),
                    onPressed: () {
                      deleteData();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
