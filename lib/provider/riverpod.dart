import '../screens/screens_barril.dart';

final maxIas_rp = StateProvider((ref) => 25); //numero de ias
final isFirstBuild_rp = StateProvider((ref) => true);
final contadorFinalizado_rp = StateProvider((ref) => false);
final isButtonVisible_rp = StateProvider((ref) => false);
final buttonEnabled_rp = StateProvider((ref) => false);

final selecCatProvider = StateProvider<String?>((ref) => null);
final selectedIAProvider = StateProvider<IA?>((ref) => null);
final likeProvider = StateProvider<bool>((ref) => false);
final loadingProvider = StateProvider<bool>((ref) => true);
final palabraBusqueda = StateProvider<String?>((ref) => null);

final dBhandler = DatabaseHandlerIA();

final getCategoryIaProvider = FutureProvider<List<IA>>((ref) async {
  await dBhandler.initializeDB();

  final selectedCategory = ref.watch(selecCatProvider);

  if (selectedCategory != null) {
    final List<IA> listIA = await dBhandler.getIAByCategory(selectedCategory);
    return listIA;
  } else {
    return [];
  }
});

//obtiene lista de ias guardadas
final getFavsIaProvider = FutureProvider<List<IA>>((ref) async {
  await dBhandler.initializeDB();

  final List<IA> listIA = await dBhandler.getFavoriteIAs();
  return listIA;
});

// Define un StreamProvider para obtener la lista de IA favoritos
final favoriteIAsProvider = StreamProvider<List<IA>>((ref) async* {
  final dbhandler = DatabaseHandlerIA();
  await dbhandler.initializeDB(); // Inicializa la base de datos
  while (true) {
    yield await dbhandler.getFavoriteIAs();
    await Future.delayed(
        Duration(seconds: 1)); // Ajusta la frecuencia de actualización
  }
});

final isIAFavoritedProvider =
    FutureProvider.autoDispose.family<bool, String>((ref, iaName) async {
  final dbHandler = DatabaseHandlerIA();
  await dbHandler.initializeDB();
  final favoriteIAs = await dbHandler.getFavoriteIAs();
  return favoriteIAs.any((ia) => ia.name == iaName);
});

final databaseServiceProvider = Provider<DatabaseHandlerIA>((ref) {
  return DatabaseHandlerIA();
});

final iasProvider = FutureProvider<List<IA>>((ref) async {
  final palabraClave = ref.watch(palabraBusqueda);
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getIAByPalabraClave(palabraClave);
});

final urlTutorialScreen = StateProvider((ref) => 'empty');

final nameTutorialScreen = StateProvider((ref) => 'empty');

// Proveedor de imagenes de muestra category

final imagesCategoryProvider = FutureProvider<List<IA>>((ref) async {
  return await dBhandler.getImgByCategory('image');
});

final videoCategoryProvider = FutureProvider<List<IA>>((ref) async {
  return await dBhandler.getImgByCategory('video');
});

final audioCategoryProvider = FutureProvider<List<IA>>((ref) async {
  return await dBhandler.getImgByCategory('audio');
});

final textCategoryProvider = FutureProvider<List<IA>>((ref) async {
  return await dBhandler.getImgByCategory('text');
});

final codeCategoryProvider = FutureProvider<List<IA>>((ref) async {
  return await dBhandler.getImgByCategory('code');
});

final numberCategoryProvider = FutureProvider<List<IA>>((ref) async {
  return await dBhandler.getImgByCategory('number');
});

final othersCategoryProvider = FutureProvider<List<IA>>((ref) async {
  return await dBhandler.getImgByCategory('other');
});
