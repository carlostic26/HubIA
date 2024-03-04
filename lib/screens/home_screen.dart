import 'package:flutter/material.dart';
import 'package:hubia/screens/fav_screen.dart';
import 'package:hubia/screens/screens_barril.dart';
import 'package:hubia/provider/riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;

    final imgUrlimages = ref.watch(imagesCategoryProvider);
    final imgUrlvideo = ref.watch(videoCategoryProvider);
    final imgUrlaudio = ref.watch(audioCategoryProvider);
    final imgUrltext = ref.watch(textCategoryProvider);
    final imgUrlothers = ref.watch(othersCategoryProvider);

    final selectedCategory = ref.watch(selecCatProvider);

    return Scaffold(
        body: Stack(
          children: [
            AnimatedBackground(),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  AppBar(
                    leading: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      },
                    ),
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: const Text(
                      "HubIA - IA's de uso libre",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    centerTitle: true,
                  ),
                  SizedBox(height: height * 0.02),
                  GestureDetector(
                      onTap: () {
                        ref.read(selecCatProvider.notifier).state = 'image';
                        context.push('/categoryList');
                      },
                      child: Column(
                        children: [
                          WidgetCategoryLine('📷 Imágenes'),
                          SizedBox(height: height * 0.02),
                          imgUrlimages.when(
                            data: (image) {
                              return MyCarousel(categoryList: image);
                            },
                            loading: () => const CircularProgressIndicator(),
                            error: (err, stack) =>
                                Text('Ha ocurrido un error: $err'),
                          ),
                        ],
                      )),
                  SizedBox(height: height * 0.02),
                  GestureDetector(
                    onTap: () {
                      ref.read(selecCatProvider.notifier).state = 'video';
                      context.push('/categoryList');
                    },
                    child: Column(
                      children: [
                        WidgetCategoryLine('📽️ Videos'),
                        SizedBox(height: height * 0.02),
                        imgUrlvideo.when(
                          data: (video) {
                            return MyCarousel(categoryList: video);
                          },
                          loading: () => const CircularProgressIndicator(),
                          error: (err, stack) =>
                              Text('Ha ocurrido un error: $err'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  GestureDetector(
                    onTap: () {
                      ref.read(selecCatProvider.notifier).state = 'audio';
                      context.push('/categoryList');
                    },
                    child: Column(
                      children: [
                        WidgetCategoryLine('🎶 Audio'),
                        SizedBox(height: height * 0.02),
                        imgUrlaudio.when(
                          data: (audio) {
                            return MyCarousel(categoryList: audio);
                          },
                          loading: () => const CircularProgressIndicator(),
                          error: (err, stack) =>
                              Text('Ha ocurrido un error: $err'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  GestureDetector(
                    onTap: () {
                      ref.read(selecCatProvider.notifier).state = 'text';
                      context.push('/categoryList');
                    },
                    child: Column(
                      children: [
                        WidgetCategoryLine('💬 Texto'),
                        SizedBox(height: height * 0.02),
                        imgUrltext.when(
                          data: (text) {
                            return MyCarousel(categoryList: text);
                          },
                          loading: () => const CircularProgressIndicator(),
                          error: (err, stack) =>
                              Text('Ha ocurrido un error: $err'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  /*  GestureDetector(
                    onTap: () {
                      ref.read(selecCatProvider.notifier).state = 'other';
                      context.push('/categoryList');
                    },
                    child: Column(
                      children: [
                        WidgetCategoryLine('📌 Otros'),
                        SizedBox(height: height * 0.02),
                        imgUrlothers.when(
                          data: (other) {
                            return MyCarousel(categoryList: other);
                          },
                          loading: () => const CircularProgressIndicator(),
                          error: (err, stack) =>
                              Text('Ha ocurrido un error: $err'),
                        ),
                      ],
                    ),
                  ), */
                ],
              ),
            ),
          ],
        ),
        drawer: _getDrawer(context));
  }

  Widget WidgetCategoryLine(String categoryName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          categoryName,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _getDrawer(BuildContext context) {
    return Drawer(
      elevation: 1,
      backgroundColor: const Color.fromARGB(186, 22, 21, 21),
      //elevation: 0,
      child: Container(
        //color: darkTheme == true ? Colors.black87 : Colors.white,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text(
                "HubIA - Las Mejores IA's",
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: GestureDetector(
                child: const Text(
                  "www.ticnoticos.com",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              currentAccountPicture: Image.asset('assets/logo.png'),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 75, 75, 75),
              ),
            ),
            _drawerListTileWidget('Buscar una IA', Icons.search, () {
              context.push('/search');
            }),
            _newDrawerListTileWidget('Categorias', Icons.category, () {
              //context.push('/categoryList');
            }),
            _newDrawerListTileWidget('IAS favoritos', Icons.favorite, () {
              //Navigator.pushNamed(context, '/favs');

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FavoriteScreen()),
              );
            }),
            _drawerListTileWidget('¿Problemas para ingresar?',
                Icons.sentiment_very_dissatisfied_sharp, () {
              context.push('/problemasIngreso');
            }),
            _drawerListTileWidget('Ayúdanos a mejorar', Icons.feedback, () {
              context.push('/feedback');
            }),
            _drawerListTileWidget('Eliminar anuncios', Icons.auto_delete, () {
              context.push('/eliminarAnuncios');
            }),
            const SizedBox(height: 20),
            const Divider(
              color: Colors.grey,
            ),
            const Text("  Información", style: TextStyle(color: Colors.white)),
            _drawerListTileWidget('Info de la app', Icons.info, () {}),
            _drawerListTileWidget(
                'Nuestras redes', Icons.supervised_user_circle, () {}),
            _drawerListTileWidget('Politica de privacidad', Icons.policy, () {
              context.push('/politica');
            }),
          ],
        ),
      ),
    );
  }

  ListTile _drawerListTileWidget(String title, IconData icon, VoidCallback go) {
    return ListTile(
        title: Row(
          children: [
            Text(title, style: const TextStyle(color: Colors.white)),
          ],
        ),
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        onTap: () {
          go();
        });
  }

  ListTile _newDrawerListTileWidget(
      String title, IconData icon, VoidCallback go) {
    return ListTile(
        title: Row(
          children: [
            Text(title, style: const TextStyle(color: Colors.white)),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'Nuevo',
                        textStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        colors: [
                          Colors.red,
                          Colors.yellow,
                          Colors.green,
                          Colors.blue,
                          Colors.purple,
                        ],
                        speed: const Duration(milliseconds: 500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        onTap: () {
          go;
        });
  }
}
