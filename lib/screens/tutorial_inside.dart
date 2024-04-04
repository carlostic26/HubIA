import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:hubia/screens/screens_barril.dart';

class TutorialInside extends ConsumerStatefulWidget {
  TutorialInside({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TutorialInsideState();
}

/* class TutorialInside extends StatefulWidget {
  const TutorialInside({super.key});

  @override
  State<TutorialInside> createState() => _TutorialInsideState();
}
 */

class _TutorialInsideState extends ConsumerState<TutorialInside> {
  @override
  Widget build(BuildContext context) {
    //ref.read(urlTutorialInside);

    final urlTutorial = ref.watch(urlTutorialInside);
    final nameTutorial = ref.watch(nameTutorialInside);

    String videoId = '';

    // Verificar si el enlace es de YouTube
    if (urlTutorial.startsWith('https://youtu.be/')) {
      // Extraer el ID del video usando una expresión regular
      RegExp regExp = RegExp(r'^https:\/\/youtu.be\/([a-zA-Z0-9_-]+)$');
      Match? match = regExp.firstMatch(urlTutorial);

      if (match != null && match.groupCount == 1) {
        videoId = match.group(1)!;
      }
    }

    final String description =
        'Este tutorial te ayuda a entender como usar e implementar la herramienta de IA de $nameTutorial que has elegido. Debes seguir paso a paso las indicaciones dadas. \n\nPuedes realizar comentarios o preguntas directamente en el video de YouTube, para ello, debes tocar en la opcion de Ver en YouTube.';

    return Scaffold(
        body: Stack(
      children: [
        AnimatedBackground(),
        _appBar('Tutorial', context),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                SizedBox(height: 20),
                //title
                Text(
                  '$nameTutorial',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                //frame video
                Container(
                  height: 200,
                  child: WebView(
                    initialUrl:
                        'https://www.youtube.com/embed/$videoId?rel=0&autoplay=1&showinfo=0&controls=0&modestbranding=1',
                    javascriptMode: JavascriptMode.unrestricted,
                    userAgent:
                        'Mozilla/5.0 (Linux; Android 10; Tablet; rv:68.0) Gecko/68.0 Firefox/68.0',
                  ),
                ),
                Divider(),
                SizedBox(height: 20),
//description
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: description
                        .split('/n')
                        .map((line) => Text(line,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.justify))
                        .toList(),
                  ),
                ),
              ])
            ],
          ),
        ),
      ],
    ));
  }

  AppBar _appBar(String selectedIA, BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        selectedIA,
        style: const TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          try {
            context.pop();
          } catch (e) {
            context.push('/detailScreen');
          }
        },
      ),
    );
  }
}
