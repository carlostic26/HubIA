import 'package:flutter/material.dart';
import 'screens_barril.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<IA>> favoriteIAs = ref.watch(favoriteIAsProvider);

    final futureIAList = ref.watch(getFavsIaProvider.future);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimatedBackground(),
          Column(
            children: [
              _appBar('IAs guardadas', context),
              Expanded(
                //child: _futureBuilderListIA(futureIAList, ref),

                child: favoriteIAs.when(
                  loading: () => Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stackTrace) => Center(
                    child: Text('Error al cargar favoritos'),
                  ),
                  data: (favoriteIAList) {
                    if (favoriteIAList.isEmpty) {
                      return Center(
                        child: Text(
                          'No hay IAs favoritas',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return _futureBuilderListIA(futureIAList, ref);
                  },
                ),
              ),
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
        style: const TextStyle(color: Colors.white),
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
      actions: [
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.refresh),
          onPressed: () {
            context.pushReplacement('/favs');
          },
        )
      ],
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

final favoriteIAsProvider = FutureProvider<List<IA>>((ref) async {
  final dbHandler = ref.read(
      databaseServiceProvider); // Lee el proveedor del manejador de la base de datos
  await dbHandler.initializeDB();
  return dbHandler.getFavoriteIAs();
});
