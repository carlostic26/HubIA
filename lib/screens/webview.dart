import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hubia/screens/screens_barril.dart';
import 'package:hubia/services/permission.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

final loadingProvider = StateProvider<bool>((ref) => true);

class WebViewScreen extends ConsumerWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    solicitarPermisos();

    final ia = ref.watch(selectedIAProvider.notifier).state;
    final isLoading = ref.watch(loadingProvider);

    final tutorialInside = ref.watch(urlTutorialInside);

    Future.delayed(const Duration(seconds: 5), () {
      ref.read(loadingProvider.notifier).state = false;
    });

    void _verTutorial(String urlTutorial) {
      context.push('/tutorialInside');
    }

    void _compartirUrl(String nameIA) {
      Share.share("Esta IA es impresionante, se llama " +
          nameIA +
          " úsala con Hubia, enlace a Play Store 🥳👇🏼" +
          "\n\nhttps://play.google.com/store/apps/details?id=com.blogspot.apphubia");
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
          _verTutorial(tutorialInside.toString());
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
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: Uri.parse(ia.webUrl.toString())),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      useShouldOverrideUrlLoading: true,
                      mediaPlaybackRequiresUserGesture: false,
                      allowFileAccessFromFileURLs: true,
                      allowUniversalAccessFromFileURLs: true,
                    ),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {},
                  onLoadStart: (InAppWebViewController controller, Uri? url) {
                    // Manejar la carga de archivos aquí si es necesario
                  },
                  onLoadStop: (InAppWebViewController controller, Uri? url) {},
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    // Manejar las solicitudes de navegación aquí si es necesario
                    return NavigationActionPolicy.ALLOW;
                  },
                  onDownloadStart: (controller, url) async {
                    print("onDownloadStart $url");
                    await _handleDownload(url.toString());
                  },
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

  void solicitarPermisos() async {
    var requestPermissions = RequestPermissions();
    bool hasPermissions = await requestPermissions.requestAllPermissions();

    if (hasPermissions) {
      // Continúa con tu código
    } else {
      // Toast Muestra un mensaje al usuario indicando que los permisos son necesarios
    }
  }

  Future<void> _handleDownload(String url) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: (await getExternalStorageDirectory())!.path,
        showNotification: true,
        openFileFromNotification: true,
      );
      // Puedes manejar aquí el ID de la tarea de descarga si es necesario
    } else {
      // Toast o mensaje al usuario indicando que los permisos de almacenamiento son necesarios
    }
  }
}



/* import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hubia/screens/screens_barril.dart';
import 'package:share_plus/share_plus.dart';

final loadingProvider = StateProvider<bool>((ref) => true);

class WebViewScreen extends ConsumerWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ia = ref.watch(selectedIAProvider.notifier).state;
    final isLoading = ref.watch(loadingProvider);

    //variable de ver tutorial
    //provider que lee en variable de videotutorial actual
    final tutorialInside = ref.watch(urlTutorialInside);

    Future.delayed(const Duration(seconds: 5), () {
      ref.read(loadingProvider.notifier).state = false;
    });

    void _verTutorial(String urlTutorial) {
      context.push('/tutorialInside');
    }

    void _compartirUrl(String nameIA) {
      Share.share("Esta IA es impresionante, se llama " +
          nameIA +
          " úsala con Hubia, enlace a Play Store 🥳👇🏼" +
          "\n\nhttps://play.google.com/store/apps/details?id=com.blogspot.apphubia");
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
          _verTutorial(tutorialInside.toString());
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
                child: WebView(
                  initialUrl: ia.webUrl.toString(),
                  javascriptMode: JavascriptMode.unrestricted,
                  userAgent:
                      //'Mozilla/5.0 (Linux; Android 9.0; Build/N2G48H; Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Mobile Safari/537.3',
                      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36',
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
 */