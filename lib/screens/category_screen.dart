import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hubia/controller/admob_controller.dart';
import 'package:hubia/screens/screens_barril.dart';

class ListCategoryScreen extends ConsumerStatefulWidget {
  const ListCategoryScreen({Key? key}) : super(key: key);

  @override
  _ListCategoryScreenState createState() => _ListCategoryScreenState();
}

class _ListCategoryScreenState extends ConsumerState<ListCategoryScreen> {
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

    final selectedCategory = ref.watch(selecCatProvider);
    final futureIAList = ref.watch(getCategoryIaProvider.future);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 40, 40),
      body: Stack(
        children: [
          //AnimatedBackground(),
          Column(
            children: [
              _appBar(selectedCategory, context),
              Expanded(
                child: _futureBuilderListIA(futureIAList, ref),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: ref.watch(admobProvider).bannerAd == null
          ? const SizedBox()
          : SizedBox(
              height: ref.watch(admobProvider).bannerAd!.size.height.toDouble(),
              width: ref.watch(admobProvider).bannerAd!.size.width.toDouble(),
              child: AdWidget(ad: ref.watch(admobProvider).bannerAd!),
            ),
    );
  }

  AppBar _appBar(String? selectedCategory, BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        '$selectedCategory',
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

  FutureBuilder<List<IA>> _futureBuilderListIA(
      Future<List<IA>> futureIAList, WidgetRef ref) {
    return FutureBuilder<List<IA>>(
      future: futureIAList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No hay elementos en esta categoría.'),
          );
        } else {
          final listIA = snapshot.data!;
          return ListView.builder(
            itemCount: listIA.length,
            itemBuilder: (context, index) {
              final ia = listIA[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    ref.read(selectedIAProvider.notifier).state = ia;
                    context.push('/detailScreen');
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            ia.imageUrl ?? '',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                                    Colors.black.withOpacity(0.95),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ia.name ?? 'Nombre no disponible',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 7,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: FloatingActionButton(
                                mini: true,
                                backgroundColor: Colors.grey,
                                onPressed: () {
                                  ref.read(selectedIAProvider.notifier).state =
                                      ia;
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
                          ia.description ?? 'Descripción no disponible',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}





/* import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hubia/screens/screens_barril.dart';

class ListCategoryScreen extends ConsumerWidget {
  const ListCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final selectedCategory = ref.watch(selecCatProvider);
    final futureIAList = ref.watch(getCategoryIaProvider.future);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimatedBackground(),
          Column(
            children: [
              _appBar(selectedCategory, context),
              Expanded(
                child: _futureBuilderListIA(futureIAList, ref),
              ),
            ],
          ),
        ],
      ),
/*       bottomNavigationBar: anchoredAdaptiveAd != null
          ? Container(
              color: Color.fromARGB(255, 14, 244, 6),
              width: anchoredAdaptiveAd.size.width.toDouble(),
              height: anchoredAdaptiveAd.size.height.toDouble(),
              child: AdWidget(ad: anchoredAdaptiveAd),
            )
          : Container(
              color: Color.fromARGB(255, 218, 11, 11),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
            ), */
    );
  }

  AppBar _appBar(String? selectedCategory, BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        '$selectedCategory',
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

  FutureBuilder<List<IA>> _futureBuilderListIA(
      Future<List<IA>> futureIAList, ref) {
    return FutureBuilder<List<IA>>(
      future: futureIAList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No hay elementos en esta categoría.'),
          );
        } else {
          final listIA = snapshot.data!;
          return ListView.builder(
            itemCount: listIA.length,
            itemBuilder: (context, index) {
              final ia = listIA[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    //envio el index seleccionado de objeto "ia" o listIA[index] a la pantalla de detailScreen y desde detailScreen obtengo cada elemento de dicho objeto
                    ref.read(selectedIAProvider.notifier).state = ia;

                    //navego a la pantalla de detalles
                    context.push('/detailScreen');
                  },
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          // Imagen
                          Image.network(
                            ia.imageUrl ?? '',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                                ia.name ?? 'Nombre no disponible',
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
                                backgroundColor:
                                    Colors.grey, // Color de fondo gris
                                onPressed: () {
                                  ref.read(selectedIAProvider.notifier).state =
                                      ia;
                                  context.go('/detailScreen');
                                },
                                child: const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white, // Color del icono blanco
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ia.description ?? 'Descripción no disponible',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          maxLines: 3, // Trunca la descripción a 3 líneas
                          overflow: TextOverflow
                              .ellipsis, // Muestra puntos suspensivos al final si la descripción se trunca
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
 */