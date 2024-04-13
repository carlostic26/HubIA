import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hubia/controller/admob_controller.dart';
import 'package:hubia/screens/screens_barril.dart';

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
    super.initState();
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
    final tutorialInside = ref.watch(urlTutorialInside);

    // Observar el estado de favorito para el IA actual
    final isLiked = ref.watch(isIAFavoritedProvider(ia!.name!));

    return Scaffold(
      body: Stack(children: [
        AnimatedBackground(),
        Column(
          children: [
            _appBar(ia.name.toString(), context),
            Expanded(child: itemList(ia, context, isLiked, height))
          ],
        ),
      ]),
      bottomNavigationBar: _anchoredAdaptiveAd != null && _isLoaded
          ? Container(
              color: Color.fromARGB(0, 33, 149, 243),
              width: _anchoredAdaptiveAd?.size.width.toDouble(),
              height: _anchoredAdaptiveAd?.size.height.toDouble(),
              child: AdWidget(ad: _anchoredAdaptiveAd!),
            )
          : Container(
              color: Color.fromARGB(0, 33, 149, 243),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height *
                  0.1, // 10% de la altura de la pantalla
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
          ad.dispose();
        },
      ),
    );

    try {
      await loadedAd.load();
    } catch (e) {
      //print('Error loading anchored adaptive banner: $e');
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
                                            .read(nameTutorialInside.notifier)
                                            .state = ia.name!;
                                        ref
                                            .read(urlTutorialInside.notifier)
                                            .state = ia.tutorialUrl!;
                                        context.go('/tutorialInside');
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
                                        //openUrl();
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
              Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.ondemand_video,
                      size: 30,
                    ),
                    color: Colors.grey,
                  )),

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

              //share button
              Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: IconButton(
                    onPressed: () {},
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
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blueGrey),
                          ),
                          onPressed: () async {
                            //Read all coins saved
                            SharedPreferences coinsPrefs =
                                await SharedPreferences.getInstance();

                            int actualCoins =
                                coinsPrefs.getInt('cursinCoinsSHP') ?? 2;

                            //data that ask if the last acces to course is the same course in the moment:
                            SharedPreferences lastCourse =
                                await SharedPreferences.getInstance();
                            lastCourse.getString('lastCourse');

                            if (actualCoins >= 12 ||
                                ia.name == lastCourse.getString('lastCourse')) {
                              //Navigator.pop(context); //close dialog
                              /*                           Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => courseOption(
                                      nameCourse: widget.td.title,
                                      urlCourse: widget.td.urlcourse,
                                      imgCourse: widget.td.imgcourse,
                                      nombreEntidad: widget.td.entidad,
                                    )),
                          ); */
                            } else {
                              //show dialog saying that ads keep service of the app
                              /*                           showDialogCourse(
                              context,
                              widget.td.imgcourse,
                              widget.td.title,
                              widget.td.entidad,
                              widget.td.urlcourse); */

                              //PARA PRUEBAS DE TICNOTICOS
                              /*Navigator.pop(context); //close dialog
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => courseOption(
                                    nameCourse: widget.td.title,
                                    urlCourse: widget.td.urlcourse,
                                    imgCourse: widget.td.imgcourse,
                                    nombreEntidad: widget.td.entidad,
                                  )),
                        );
                        */
                            }
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
                          MaterialStateProperty.all<Color>(Colors.blueGrey),
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

                      _mostrarDialogo(context);
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
            context.go('/home');
          }
        },
      ),
    );
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
