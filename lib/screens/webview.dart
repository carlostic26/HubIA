import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hubia/screens/screens_barril.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

final loadingProvider = StateProvider<bool>((ref) => true);

class WebViewScreen extends ConsumerStatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends ConsumerState<WebViewScreen> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      ref.read(loadingProvider.notifier).state = false;
    });
  }

  initController(String url) {
    setState(() {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setUserAgent(
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36')
        ..loadRequest(Uri.parse(url));
    });
  }

  @override
  Widget build(BuildContext context) {
    final ia = ref.watch(selectedIAProvider.notifier).state;
    final isLoading = ref.watch(loadingProvider);

    initController(ia!.webUrl.toString());

    //variable de ver tutorial
    //provider que lee en variable de videotutorial actual
    final TutorialScreen = ref.watch(urlTutorialScreen);

    void _verTutorial(String urlTutorial) {
      context.push('/TutorialScreen');
    }

    void _compartirUrl(String nameIA) {
      Share.share("Esta IA es impresionante, se llama " +
          nameIA +
          " úsala con Hubia, enlace a Play Store 🥳👇🏼" +
          "\n\n");
    }

    void _openUrl(String url) async {
      if (await canLaunch(url)) launch(url);
    }

    void _copiarEnlace(String url) {
      Clipboard.setData(ClipboardData(text: url));
      Fluttertoast.showToast(
        msg: "Enlace copiado",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }

    void handleClick(String value) {
      switch (value) {
        case 'Ver tutorial':
          _verTutorial(TutorialScreen.toString());
          break;
        case 'Compartir mediante...':
          _compartirUrl(ia!.name.toString());
          break;
        case 'Abrir con el navegador':
          _openUrl(ia!.webUrl.toString());
          break;
        case 'Copiar Enlace':
          _copiarEnlace(ia!.webUrl.toString());
          break;
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    ia!.name.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          context.go('/detailScreen');
                        },
                      );
                    },
                  ),
                  actions: <Widget>[
                    Row(
                      children: [
                        PopupMenuButton<String>(
                          color: Colors.white,
                          iconSize: 20,
                          onSelected: handleClick,
                          itemBuilder: (BuildContext context) {
                            return {
                              'Ver tutorial',
                              'Copiar Enlace',
                              'Abrir con el navegador',
                              'Compartir mediante...'
                            }.map((String choice) {
                              return PopupMenuItem<String>(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        ),
                        IconButton(
                            icon: Icon(
                              color: Colors.white,
                              Icons.logout,
                              size: 20,
                            ),
                            onPressed: () {
                              context.go('/detailScreen');
                            }),
                      ],
                    ),
                  ]),
              Expanded(
                child: WebViewWidget(
                  controller: _controller,
                ),
              ),
            ],
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
 


/*   Future<void> _handleDownload(String url) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      Directory? externalDirectory;
      try {
        externalDirectory = await getExternalStorageDirectory();
      } catch (e) {
        print('Error obteniendo el directorio: $e');

        Fluttertoast.showToast(
          msg: "Error obteniendo el directorio: $e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }

      if (externalDirectory != null) {
        final taskId = await FlutterDownloader.enqueue(
          url: url,
          savedDir: externalDirectory.path,
          showNotification: true,
          openFileFromNotification: true,
        );
        // Puedes manejar aquí el ID de la tarea de descarga si es necesario
      } else {
        Fluttertoast.showToast(
          msg: "Es necesario otorgar los permisos 1.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Es necesario otorgar los permisos 2.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  } */


