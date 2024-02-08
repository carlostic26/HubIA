import 'package:flutter/material.dart';
import 'package:hubia/screens/screens_barril.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int maxCourses = 24;
  bool buttonEnabled = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        buttonEnabled = true;
      });
    });
  }

  isLoaded(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? primerAcceso = prefs.getBool('primerAcceso');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(children: [
        AnimatedBackground(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                height: 200,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Image.asset("assets/logo.png"),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearPercentIndicator(
                      width: 270.0,
                      lineHeight: 8,
                      percent: 100 / 100,
                      animation: true,
                      animationDuration: 10000, // 8.5 sec para cargar la barra
                      progressColor: Colors.green,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Recopilando ",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                  CountingAnimation(endCount: maxCourses),
                  const Text(
                    " IA's diferentes de acceso gratuito...",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: TextButton(
                    onPressed: buttonEnabled
                        ? () async {
                            isLoaded(context);
                          }
                        : null, // Desactiva el botón si no está habilitado
                    style: ButtonStyle(
                      backgroundColor: buttonEnabled
                          ? MaterialStateProperty.all<Color>(
                              Colors.green,
                            ) // Color de fondo cuando está habilitado
                          : MaterialStateProperty.all<Color>(Colors
                              .grey), // Color de fondo cuando está deshabilitado
                    ),

                    child: Text(
                      'Continuar',
                      style: TextStyle(
                          fontSize: 10,
                          color:
                              buttonEnabled ? Colors.green : Colors.blueGrey),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class CountingAnimation extends StatefulWidget {
  final int endCount;

  CountingAnimation({required this.endCount});

  @override
  _CountingAnimationState createState() => _CountingAnimationState();
}

class _CountingAnimationState extends State<CountingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 9),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.endCount.toDouble())
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Text(
          _animation.value.toInt().toString(),
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
