import 'package:flutter/material.dart';

void main() {
  runApp(const welcome());
}

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/beer.jpeg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 230),
              child: const Text(
                'Welcome to House Party',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(
              height: 140,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Container(
                height: 60,
                margin: const EdgeInsets.all(120),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  },
                  child: const Center(
                    child: Text('Get Start'),
                  ),
                ),
              ),
            )
          ])),
    );
  }
}
