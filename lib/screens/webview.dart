import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inappwebview;
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hubia/screens/screens_barril.dart';
import 'package:hubia/services/download_helper_functions.dart';
import 'package:hubia/services/permission.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

final loadingProvider = StateProvider<bool>((ref) => true);

class WebViewScreen extends ConsumerWidget {
  const WebViewScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ia = ref.watch(selectedIAProvider.notifier).state;

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

    solicitarPermisos();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                    child: inappwebview.InAppWebView(
                  initialUrlRequest: inappwebview.URLRequest(
                      url: Uri.parse(ia.webUrl.toString())),
                  onDownloadStartRequest: (controller,
                      inappwebview.DownloadStartRequest request) async {
                    //todo download catelog here
                    FlutterDownloader.registerCallback(
                        downloadCallback as DownloadCallback);
                    final platform = Theme.of(context).platform;
                    bool value = await _checkPermission(platform);
                    if (value) {
                      await prepareSaveDir();
                      {
                        final taskId = await FlutterDownloader.enqueue(
                          url: request.url.toString(),
                          savedDir: localPath,
                          showNotification: true,
                          saveInPublicStorage:
                              true, // show download progress in status bar (for Android)
                          openFileFromNotification:
                              true, // click on notification to open downloaded file (for Android)
                        );
                      }
                    }
                  },
                  onLoadError: (controller, url, code, message) {
                    // Muestra el error en un toast
                    Fluttertoast.showToast(
                      msg: "Error de carga: $message",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                  },
                  initialOptions: inappwebview.InAppWebViewGroupOptions(
                    crossPlatform: inappwebview.InAppWebViewOptions(
                      useShouldOverrideUrlLoading: true,
                      javaScriptEnabled: true,
                    ),
                  ),
                  onWebViewCreated:
                      (inappwebview.InAppWebViewController controller) {
                    controller.clearCache();
                    final cookieManager = inappwebview.CookieManager.instance();
                    cookieManager.deleteAllCookies();
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;

/*                     Fluttertoast.showToast(
                      msg: "URI ENTRANDO A OVERRIDE URL LOADING: $uri",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
 */
                    if (uri.scheme == "http" || uri.scheme == "https") {
                      if (uri.path.endsWith('.jpg') ||
                          uri.path.endsWith('.jpeg') ||
                          uri.path.endsWith('.png') ||
                          uri.path.endsWith('.gif') ||
                          uri.path.endsWith('.mp4') ||
                          uri.path.endsWith('.avi') ||
                          uri.path.endsWith('.webm') ||
                          uri.path.endsWith('.webp') ||
                          uri.path.endsWith('.mp3') ||
                          uri.path.endsWith('.ogg')) {
/*                         Fluttertoast.showToast(
                          msg: "URI VALIDA ENTRA A FUNCION: $uri",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                        ); */
                        _handleDownload(uri.toString());
                      } else {
                        // No es un archivo multimedia, cancela la descarga
                        print('URL no válida: $uri');

/*                         Fluttertoast.showToast(
                          msg: "NO ES MULTIMEDIA $uri",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                        ); */
                      }

                      return inappwebview.NavigationActionPolicy.CANCEL;
                    }

                    return inappwebview.NavigationActionPolicy.ALLOW;
                  },
                  onLoadStart: (controller, url) async {
                    controller.addJavaScriptHandler(
                      handlerName: 'download',
                      callback: (args) async {
                        if (url != null && url.toString().startsWith('blob')) {
/*                           Fluttertoast.showToast(
                            msg: "COMIENZA CON BLOB URL A PROCESAR: $url",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                          ); */
                          try {
                            final validDownloadUrl =
                                await processBlobUrl(url.toString());
                            print(
                                'URL válida para descarga: $validDownloadUrl');

/*                             Fluttertoast.showToast(
                              msg: "BLOB URL PROCESADA: $url",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                            ); */

                            _handleDownload(validDownloadUrl);
                          } catch (e) {
/*                             Fluttertoast.showToast(
                              msg: "CATCHED ERROR DE URL INVAL: $e",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                            ); */
                            print('Error: $e');
                          }
                        } else {
/*                           Fluttertoast.showToast(
                            msg: "URl nula Y NO COMIENZA CON BLOB: $url",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                          ); */
                          _handleDownload(args[0]);
                        }
                      },
                    );

                    await controller.evaluateJavascript(source: '''
                    window.addEventListener('message', function(event) {
                      window.flutter_inappwebview.callHandler('download', event.data);
                    }, false);
                  ''');
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _checkPermission(platform) async {
    if (Platform.isIOS) return true;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (platform == TargetPlatform.android &&
        androidInfo.version.sdkInt <= 28) {
      final status = await Permission.storage.status;
      // final status2 = await Permission.manageExternalStorage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        // final result2 = await Permission.manageExternalStorage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<String> processBlobUrl(String blobUrl) async {
    try {
      // Realiza una solicitud HTTP para obtener los datos del blob
      final response = await http.get(Uri.parse(blobUrl));

      if (response.statusCode == 200) {
        // Convierte los datos del blob en una URL válida para descarga
        final blobData = response.bodyBytes;
        final blobBase64 = base64Encode(blobData);
        final validDownloadUrl =
            'data:application/octet-stream;base64,$blobBase64';

        return validDownloadUrl;
      } else {
        throw Exception(
            'Error al obtener los datos del blob. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al procesar la URL del blob: $e');
    }
  }

  void solicitarPermisos() async {
    var requestPermissions = RequestPermissions();
    bool hasPermissions = await requestPermissions.requestAllPermissions();

    if (hasPermissions) {
      // Continúa con tu código
    } else {
/*       Fluttertoast.showToast(
        msg: 'Los permisos son necesarios para guardar el resultado',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      ); */
    }
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  Future<void> _handleDownload(String url) async {
    try {
      final taskId = await FileDownloader.downloadFile(
        url: url,
        onProgress: (name, progress) {},
      );

      Fluttertoast.showToast(
        msg: 'Descarga completada. Path: $taskId',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
/*       Fluttertoast.showToast(
        msg: 'Error al descargar el archivo: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      ); */
    }
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