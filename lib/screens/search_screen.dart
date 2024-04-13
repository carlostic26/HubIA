import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hubia/screens/screens_barril.dart';

class SearchIA extends StatefulWidget {
  const SearchIA({Key? key}) : super(key: key);

  @override
  _SearchIAState createState() => _SearchIAState();
}

class _SearchIAState extends State<SearchIA> {
  final TextEditingController _searchController = TextEditingController();

  //initializing banner ad
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  bool _isAdLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final ia = ref.watch(selectedIAProvider.notifier).state;
      final iasFuture = ref.watch(iasProvider);

      final selectedCategory = ref.watch(selecCatProvider);

      if (!_isAdLoaded) {
        _loadAdaptativeAd();
        _isAdLoaded = true;
      }

      return Scaffold(
        body: Stack(
          children: [
            AnimatedBackground(),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                    title: TextField(
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        ref.read(palabraBusqueda.notifier).state = value;
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Ej: CodeFormer, Gemini, ESRGAN',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      controller: _searchController,
                    ),
                    centerTitle: true,
/*                     actions: [
                      IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.search),
                        onPressed: () {
                          //searchCourse('');
                        },
                      )
                    ], */
                  ),
                  iasFuture.when(
                    data: (ias) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: ias.length,
                          itemBuilder: (context, index) {
                            return Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    // Imagen
                                    Image.network(
                                      ias[index].imageUrl!,
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return SizedBox(
                                            height: 200,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),

                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.center,
                                            colors: [
                                              Colors.black.withOpacity(
                                                  0.95), // Opacidad ajustable
                                              Colors.transparent,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Título
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          ias[index].name!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // btn acceder
                                    Positioned(
                                      bottom: 2,
                                      right: 7,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: FloatingActionButton(
                                          mini: true,
                                          backgroundColor: Colors.grey,
                                          onPressed: () {
                                            ref
                                                .read(
                                                    selectedIAProvider.notifier)
                                                .state = ias[index];
                                            context.go('/detailScreen');
                                          },
                                          child: const Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ias[index].description!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    maxLines:
                                        3, // Trunca la descripción a 3 líneas
                                    overflow: TextOverflow
                                        .ellipsis, // Muestra puntos suspensivos al final si la descripción se trunca
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            );
                          },
                        ),
                      );
                    },
                    loading: () => CircularProgressIndicator(),
                    error: (err, stack) => Text('Error: $err'),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _anchoredAdaptiveAd != null
            ? Container(
                color: Colors.transparent,
                width: _anchoredAdaptiveAd?.size.width.toDouble(),
                height: _anchoredAdaptiveAd?.size.height.toDouble(),
                child: AdWidget(ad: _anchoredAdaptiveAd!),
              )
            : SizedBox(), // Si no hay anuncio cargado, no muestra nada
      );
    });
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
}
