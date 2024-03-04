import 'package:flutter/material.dart';
import 'screens_barril.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<IA>> favoriteIAs =
        ref.watch(favoriteIAsProvider); // Observa el provider de IAs favoritas

    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: favoriteIAs.when(
        loading: () => Center(
          child:
              CircularProgressIndicator(), // Muestra un indicador de carga mientras se obtienen los datos
        ),
        error: (error, stackTrace) => Center(
          child: Text(
              'Error al cargar favoritos'), // Muestra un mensaje de error si hay un problema
        ),
        data: (favoriteIAList) {
          if (favoriteIAList.isEmpty) {
            return Center(
              child: Text(
                  'No hay IAs favoritas'), // Muestra un mensaje si no hay IAs favoritas
            );
          }

          return ListView.builder(
            itemCount: favoriteIAList.length,
            itemBuilder: (context, index) {
              final ia = favoriteIAList[index];
              return ListTile(
                title: Text(ia!.name.toString()),
                // Agrega más detalles de la IA si es necesario
              );
            },
          );
        },
      ),
    );
  }
}

final favoriteIAsProvider = FutureProvider<List<IA>>((ref) async {
  final dbHandler = ref.read(
      databaseServiceProvider); // Lee el proveedor del manejador de la base de datos
  await dbHandler.initializeDB();
  return dbHandler.getFavoriteIAs();
});
