import 'package:flutter/material.dart';

import 'home_icon_buttoms.dart';

void main() {
  runApp(Myhome());
}

class Myhome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        padding: EdgeInsets.all(2),
        color: Colors.orangeAccent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/home.png',
                height: 60,
                width: 60,
              ),
              Image.asset(
                'assets/food123.png',
                height: 60,
                width: 60,
              ),
              Image.asset(
                'assets/cab1.jpg',
                height: 60,
                width: 60,
              ),
              Image.asset(
                'assets/cart00.png',
                height: 60,
                width: 60,
              ),
              Image.asset(
                'assets/acco.png',
                height: 60,
                width: 60,
              ),

            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Transform.rotate(
                origin: Offset(30, -80),
                angle: 2.4,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 75,
                    top: 40,
                  ),
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      colors: [Colors.orangeAccent, Colors.orangeAccent],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enjoy Your Party',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Life is one big party, enjoy every minute of it...',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CatigoryW(
                                image: 'assets/pp.jpg',
                                text: 'Looking For Party',
                                color: Colors.white,
                              ),
                              CatigoryW(
                                image: 'assets/image1.png',
                                text: 'Order Food',
                                color: Colors.white,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CatigoryW(
                                image: 'assets/image2.png',
                                text: 'Book Cab or Driver',
                                color: Colors.white,
                              ),
                              CatigoryW(
                                image: 'assets/image4.webp',
                                text: 'Use Our Services',
                                color: Colors.white,
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
