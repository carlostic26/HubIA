import 'package:flutter/material.dart';
import 'package:hubia/screens/screens_barril.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        AnimatedBackground(),
        Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Bienvenido',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
          ],
        ),
      ]),
    );
  }
}
