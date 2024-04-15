import 'package:flutter/material.dart';
import 'package:hubia/screens/screens_barril.dart';

class infoApp extends StatelessWidget {
  const infoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimatedBackground(),
          Column(
            children: [
              _appBar('Info de la app', context),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'HubIA es una aplicación que funciona como navegador y probador móvil de las IA más útiles e importantes de acceso libre o gratuito que se encuentran en internet.\n\n' +
                      'La app recopila constantemente sitios web y proyectos online en Google Colab, que cumplan con las condiciones necesarias para poder ser usadas sin limitantes ni dificultades.\n\n' +
                      'Dentro de HubIA se podrán encontrar recursos y accesos libres sobre inteligencia artificial relacionada al campo de multimedia y aritmética. Tales como: restauración de imagen, restauración de video, restauración de audio, LLM, entre otros.\n\n' +
                      'HubIA ha sido diseñada por TICnoticos Apps, un canal de youtube que se dedica a la exploración de tecnologías de inteligencia artificial y las TIC.',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  AppBar _appBar(String? name, BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        '$name',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          context.pushReplacement('/home');
        },
      ),
    );
  }
}
