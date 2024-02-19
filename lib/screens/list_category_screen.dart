import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hubia/screens/screens_barril.dart';

class ListCategoryScreen extends ConsumerWidget {
  const ListCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    late DatabaseHandlerIA dbhandler;

    Future<List<IA>>? _ia;

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
                child: _futureBuilderListIA(futureIAList),
              ),
            ],
          ),
        ],
      ),
    );

/*     return Scaffold(
      body: Stack(children: [
        AnimatedBackground(),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              AppBar(
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
                    context.go('/home');
                  },
                ),
              ),
              FutureBuilder<List<IA>>(
                future: futureIAList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Muestra un indicador de carga
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No hay elementos en esta categoría.');
                  } else {
                    final listIA = snapshot.data!;
                    //var items = snapshot.data ?? <IA>[];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 1.0,
                        vertical: 1.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.builder(
                        itemCount: listIA.length,
                        itemBuilder: (context, index) {
                          final ia = listIA[index];
                          return ListTile(
                            title: Text(ia.name ?? 'es nulo'),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
            ],
          ),
        ),
      ]),
    );
 
  */
  }

  FutureBuilder<List<IA>> _futureBuilderListIA(Future<List<IA>> futureIAList) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            }
                          },
                        ),
                        // Efecto de degradado de transparente a negro
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.center,
                                colors: [
                                  Colors.black
                                      .withOpacity(0.95), // Opacidad ajustable
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Título o texto ia.name
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
              );
            },
          );
        }
      },
    );
  }

/*   Expanded _futureAIList(Future<List<IA>> futureIAList) {
    return;
  }
 */
  AppBar _appBar(String? selectedCategory, BuildContext context) {
    return AppBar(
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
          context.go('/home');
        },
      ),
    );
  }
}
