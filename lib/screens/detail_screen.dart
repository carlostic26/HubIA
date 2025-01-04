import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hubia/controller/admob_controller.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:hubia/screens/screens_barril.dart';
import 'package:share_plus/share_plus.dart';

class DetailScreen extends ConsumerStatefulWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  //initializing banner ad
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  bool _isAdLoaded = false;

  @override
  void initState() {
    ref.read(admobProvider.notifier).loadBannerAd();
    ref.read(admobProvider.notifier).loadInterstitialAd();
    ref.read(admobProvider.notifier).loadRewardedAd();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAdaptativeAd();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      _loadAdaptativeAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (!_isAdLoaded) {
      _loadAdaptativeAd();
      _isAdLoaded = true;
    }

    // Aquí seguimos usando ref.watch para suscribirnos al estado y obtener la IA seleccionada
    final ia = ref.watch(selectedIAProvider);

    //provider que lee en variable de videotutorial actual
    final TutorialScreen = ref.watch(urlTutorialScreen);

    // Observar el estado de favorito para el IA actual
    final isLiked = ref.watch(isIAFavoritedProvider(ia!.name!));

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        context.go('/home');
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 40, 40, 40),
        body: Stack(children: [
          //AnimatedBackground(),
          Column(
            children: [
              _appBar(ia.name.toString(), context),
              Expanded(child: itemList(ia, context, isLiked, height))
            ],
          ),
        ]),
        bottomNavigationBar: _anchoredAdaptiveAd != null
            ? Container(
                color: Colors.transparent,
                width: _anchoredAdaptiveAd?.size.width.toDouble(),
                height: _anchoredAdaptiveAd?.size.height.toDouble(),
                child: AdWidget(ad: _anchoredAdaptiveAd!),
              )
            : SizedBox(), // Si no hay anuncio cargado, no muestra nada
      ),
    );
  }

  Future<void> _loadAdaptativeAd() async {
    if (_isAdLoaded) {
      return;
    }

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      //print('Unable to get height of anchored banner.');
      return;
    }

    HubiaAdsIds ads = HubiaAdsIds();

    BannerAd loadedAd = BannerAd(
      adUnitId: ads.banner_adUnitId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          // print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // print('Anchored adaptive banner failedToLoad: $error');

/*           Fluttertoast.showToast(
            msg: "Fallo: $error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          ); */
          ad.dispose();
        },
      ),
    );

    try {
      await loadedAd.load();
    } catch (e) {
      //print('Error loading anchored adaptive banner: $e');

      Fluttertoast.showToast(
        msg: "Error:$e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      loadedAd.dispose();
    }
  }

  SingleChildScrollView itemList(
      IA ia, BuildContext context, AsyncValue<bool> isLiked, double height) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //IMAGEN TUTORIAL
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: <Widget>[
                    // Imagen de fondo
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 15, 12.0, 1.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: ia.imageUrl.toString(),
                              width: 400.0,
                              height: 210.0,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.grey,
                                ),
                              ),
                              placeholderFadeInDuration:
                                  const Duration(milliseconds: 200),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            ia.tutorialUrl.toString() != "url_tutorial"
                                ? BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 2.0,
                                        sigmaY:
                                            2.0), // Ajusta los valores según tu preferencia
                                    child: Container(
                                      color: Colors
                                          .transparent, // Puedes ajustar el color de fondo desenfocado
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),

                    // Capa de gradiente negro a transparente
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 15, 12.0, 1.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          width: 400.0,
                          height: 220.0, // Altura de la imagen
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black],
                            ),
                          ),
                        ),
                      ),
                    ),

                    ia.tutorialUrl != "url_tutorial"
                        ? // Row para los botones
                        Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(nameTutorialScreen.notifier)
                                            .state = ia.name!;
                                        ref
                                            .read(urlTutorialScreen.notifier)
                                            .state = ia.tutorialUrl!;
                                        context.go('/TutorialScreen');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        disabledForegroundColor:
                                            Colors.transparent,
                                        disabledBackgroundColor:
                                            Colors.transparent,
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 80,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        launchUrl(Uri.parse(
                                            ia.tutorialUrl.toString()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        disabledForegroundColor:
                                            Colors.transparent,
                                        disabledBackgroundColor:
                                            Colors.transparent,
                                      ),
                                      child: const FaIcon(
                                        FontAwesomeIcons.youtube,
                                        color: Colors.white,
                                        size: 70,
                                      ),
                                    ),
                                  ],
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 15),
                                    Text(
                                      'Ver tutorial aqui  ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '-   Ó   -',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '    Ver en YouTube',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
          //Row de botones accion
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //like button
              IconButton(
                onPressed: () async {
                  final dbhandler = DatabaseHandlerIA();
                  if (isLiked.value ?? false) {
                    await dbhandler.removeIAFromFavorites(ia.name.toString());
                  } else {
                    await dbhandler.addIAtoFavorites(ia.name.toString());
                  }
                  ref.invalidate(isIAFavoritedProvider(ia
                      .name!)); // Actualizar el estado de favorito después de la acción
                },
                icon: Icon(
                  isLiked.value ?? false
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: isLiked.value ?? false ? Colors.red : null,
                ),
                color: Colors.grey,
              ),

              //tutorial button
              ia.tutorialUrl == 'url_tutorial' || ia.tutorialUrl!.isEmpty
                  ? Container()
                  : Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: IconButton(
                        onPressed: () {
                          launchUrl(Uri.parse(ia.tutorialUrl.toString()));
                        },
                        icon: const Icon(
                          Icons.ondemand_video,
                          size: 30,
                        ),
                        color: Colors.grey,
                      )),
/* 
              //report button
              Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bug_report,
                      size: 30,
                    ),
                    color: Colors.grey,
                  )),
 */
              //share button

              //apoyanos
              Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: IconButton(
                    onPressed: () {
                      context.push('/apoyanos');
                    },
                    icon: const Icon(
                      Icons.volunteer_activism,
                      size: 30.0,
                    ),
                    color: Colors.grey,
                  )),

              Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: IconButton(
                    onPressed: () {
                      _compartirUrl(ia.name.toString());
                    },
                    icon: const Icon(
                      Icons.share,
                      size: 30.0,
                    ),
                    color: Colors.grey,
                  )),
            ],
          ),

//Description
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ia.description!
                  .split('/n')
                  .map((line) => Text(line,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.justify))
                  .toList(),
            ),
          ),

          SizedBox(
            height: height * 0.03,
          ),

          WidgetTablaInfo(
            ia: ia,
          ),

          SizedBox(
            height: height * 0.03,
          ),

          //botones de ver tutorial y entrar a la ia en webview o interno
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ia.tutorialUrl.toString() != "url_tutorial"
                  ? Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.blueGrey),
                          ),
                          onPressed: () async {
                            launchUrl(Uri.parse(ia.tutorialUrl.toString()));
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.youtube,
                            color: Colors.white,
                            //size: 70,
                          ),
                          label: const Text(
                            'Ver en YouTube',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.blueGrey),
                    ),
                    onPressed: () async {
                      //interstitial
                      // ref.read(admobProvider).interstitialAd!.show();

                      //rewarded
/*                       ref.watch(admobProvider).rewardedAd == null
                        ? () {}
                        : () {
                            ref
                                .read(admobProvider)
                                .rewardedAd!
                                .show(
                                  onUserEarnedReward: (ad, reward) {},
                                )
                                .whenComplete(() async {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const AnotherView(),
                              ));
                            });
                          }; */

                      //PARA PRUEBAS DE TICNOTICOS
                      //context.go('/webView');

                      //_mostrarDialogo(context);

                      showDialogIA(context, ia.imageUrl!, ia.name, ia.webUrl);
                    },
                    icon: const Icon(
                      Icons.rocket_launch,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Probar',
                      style: TextStyle(color: Colors.white),
                    ), // <-- Text
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  void showDialogIA(BuildContext context, String img, title, urlcourse) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // Calcula la diagonal de la pantalla
    double screenDiagonal = sqrt(height * height + width * width);

    // Determina si el dispositivo es probablemente una tablet
    bool isTablet = screenDiagonal >
        900.0; // Este valor en puntos puede ajustarse según tus necesidades

    // Determina la orientación de la pantalla
    bool isLandscape = width > height;

    double dialogHeight;
    double dialogWidth;
    double imageHeight;
    double textSize;

    if (isLandscape) {
      //horizontal responsive
      dialogHeight = height * 0.85;
      dialogWidth = width * 0.30;
      imageHeight = height * 0.25;
      textSize = 10;
    } else {
      //vertical responsive
      dialogHeight = height * 0.33;
      dialogWidth = width * 0.8;
      imageHeight = height * 0.17;
      textSize = 12;
    }

    showPlatformDialog(
      context: context,
      androidBarrierDismissible: true,
      builder: (_) => BasicDialogAlert(
        content: SizedBox(
          height: dialogHeight,
          width: dialogWidth,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '👀 Antes de ir...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.01),
              CachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.cover,
                height: imageHeight,
                width: width,
              ),
              SizedBox(height: height * 0.01),
              SizedBox(
                height: height * 0.10,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    'Puedes acceder a esta IA dentro o fuera de la app. Aprovéchala y disfrútala. ' +
                        '\nVerás un pequeño anuncio para seguir mejorando la app HubIA 🕓',
                    style: TextStyle(color: Colors.black, fontSize: textSize),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: const Text('Cancelar',
                    style: TextStyle(color: Colors.white, fontSize: 10)),
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('Continuar',
                    style: TextStyle(color: Colors.white, fontSize: 10)),
                style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
                onPressed: () async {
                  try {
                    final result = await InternetAddress.lookup('google.com');
                    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                      /* int randomNumber = Random().nextInt(10) +
                          1; // Genera un número entre 1 y 10
                     if (randomNumber <= 6) {
                        showInterstitialAd();
                      } else {
                        showRewardedAd();
                      } */

                      ref.read(admobProvider).interstitialAd!.show();
                      context.go('/webView');

                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(
                          content: Text('Cargando el sitio...'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    }
                  } on SocketException catch (_) {
                    Fluttertoast.showToast(
                      msg:
                          "No estás conectado a internet.\nUsa Wi-Fi o datos móviles.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void _mostrarDialogo(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            AlertDialog(
              title: Text('¡Vamos a ello!'),
              content:
                  Text('Pero antes, mira un corto anuncio para apoyarnos.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(admobProvider).interstitialAd!.show();
                    context.go('/webView');

                    final scaffoldMessenger = ScaffoldMessenger.of(context);
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text('Cargando el sitio...'),
                        duration: Duration(seconds: 5),
                      ),
                    );
                  },
                  child: Text('Continuar'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10.0),
              child: CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.red,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.close, size: 18.0),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  AppBar _appBar(String selectedIA, BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        '$selectedIA',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
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
            context.go('/home');
          }
        },
      ),
    );
  }

  void _compartirUrl(String nameIA) {
    Share.share("Esta IA es impresionante, se llama " +
        nameIA +
        " úsala con Hubia, enlace a Play Store 🥳👇🏼" +
        "\n\nhttps://play.google.com/store/apps/details?id=com.blogspot.hubiaapp");
  }
}

class WidgetTablaInfo extends StatelessWidget {
  final IA? ia;

  const WidgetTablaInfo({super.key, required this.ia});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //CATEGORIA

        Row(
          children: [
            Expanded(
              child: Center(
                child: RichText(
                    text: const TextSpan(
                  text: "📌 Nombre:",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                    ia != null ? ia!.name.toString() : 'Nombre no disponible',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.grey,
        ),

        Row(
          children: [
            Expanded(
              child: Center(
                child: RichText(
                    text: const TextSpan(
                  text: "🗂️ Categoría:",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                    ia != null
                        ? ia!.category.toString()
                        : 'Categoria no disponible',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ),

        const Divider(
          color: Colors.grey,
        ),

        Row(
          children: [
            Expanded(
              child: Center(
                child: RichText(
                    text: const TextSpan(
                  text: "🏢 Presentado por:",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                    ia != null
                        ? cleanUrl(ia!.webUrl.toString())
                        : 'Nombre no disponible',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.grey,
        ),
        //Desarrollado por

        Row(
          children: [
            Expanded(
              child: Center(
                child: RichText(
                    text: const TextSpan(
                  text: "🖥️ Entorno de ejecución:",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(ia!.entornoEjecucion.toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  String cleanUrl(String url) {
    final uri = Uri.parse(url);
    return uri.host;
  }
}
