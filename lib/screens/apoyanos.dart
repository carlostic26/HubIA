import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hubia/screens/screens_barril.dart';

class ApoyanosScreen extends StatefulWidget {
  const ApoyanosScreen({super.key});

  @override
  State<ApoyanosScreen> createState() => _ApoyanosScreenState();
}

const int maxAttempts = 2;

class _ApoyanosScreenState extends State<ApoyanosScreen> {
  int enterAcces = 0;

  RewardedAd? rewardedAd;
  int rewardedAdAttempts = 0;

  HubiaAdsIds hubiaAds = HubiaAdsIds();

  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: hubiaAds.reward_adUnitId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          rewardedAd = ad;
          rewardedAdAttempts = 0;
        }, onAdFailedToLoad: (error) {
          rewardedAdAttempts++;
          rewardedAd = null;

          print('failed to load ${error.message}');

          if (rewardedAdAttempts <= maxAttempts) {
            createRewardedAd();
          }
        }));
  }

  void showRewardedAd() {
    if (rewardedAd == null) {
      if (enterAcces <= 2) {
        Fluttertoast.showToast(
          msg: "¡Oops! Algo salió mal. Intentalo de nuevo.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );

        enterAcces++;
      } else {
        if (enterAcces >= 3) {
          Fluttertoast.showToast(
            msg: "Vuelve más tarde.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
        enterAcces++;
      }

      return;
    }

    rewardedAd!.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) async {
      Fluttertoast.showToast(
        msg: "¡Gracias por tu apoyo!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
      // print('failed to show the adv $ad');

      //Toast diciendo: no se han podido cargar los anuncios.\n Asegurate de tener una buena conexión a internet, volver a abrir la App o intentar abrir el curso mas tarde, cuando los anuncios estén cargados en tu telefono.
      Fluttertoast.showToast(
        msg:
            "No se han podido cargar los anuncios.\nIntentalo de nuevo en 5 segundos",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      createRewardedAd();
    });

    rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      // print('reward video ${reward.amount} ${reward.type}');
    });
    rewardedAd = null;
  }

  @override
  void initState() {
    super.initState();
    createRewardedAd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 40, 40, 40),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 40, 40, 40),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Apóyanos",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          centerTitle: true,
          actions: [],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    'Hemos invertido cientos de horas y esfuerzo en crear el Hub de IAs.\n\nCon tu ayuda podemos aumentar la cantidad de accesos y categorias cada cierto tiempo, mejorando el diseño de interfaz, y respondiendo a cualquier duda por cualquiera de nuestros canales.'
                        .split('/n')
                        .map((line) => Text(line,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.justify))
                        .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.height * 0.9,
                imageUrl:
                    'https://blogger.googleusercontent.com/img/a/AVvXsEgJvHE-raNFuIaEEtwqOEWeoLpdOgzoxtSwJmEKAQhYOVaaPqfH-GWNuGJ-LhnK6jQQg_U1jff96pZ7WGbKyvh1Q7wPrGhSGVsdFyBfnVYVtVOQTKeJyrQaJgiPOMqmigH1zOSMbB9nfCVneN679beOuZv_gIxkSa1kj2czTpxSRQjfWHBFM1AnKLvc',
                placeholder: (context, url) => Container(
                  height: 30,
                  width: 35,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 1.5,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'HubIA necesita de tu ayuda para seguir existiendo. Apóyanos viendo un anuncio las veces que quieras.',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    watchAd();
                  },
                  icon: Icon(
                    Icons.visibility,
                    size: 20.0,
                    color: Colors.white, // Cambia el color del ícono a blanco
                  ),
                  label: Text(
                    'Ver un anuncio',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blueAccent, // Cambia el color del botón a verde
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                'Sólo te tomará unos segundos',
                style: TextStyle(color: Colors.grey, fontSize: 9),
              ),
            )
          ],
        ));
  }

  void watchAd() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('\n\n\n\nREWARDED ATTEMP\n\n\n\n');
        showRewardedAd();
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
        msg:
            "No estás conectado a internet.\nConéctate a Wi-Fi o datos móviles.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
