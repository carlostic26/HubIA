import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hubia/screens/screens_barril.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    final imagesCategoryList = ref.watch(imagesCategoryProvider);
    final videoCategoryList = ref.watch(videoCategoryProvider);
    final audioCategoryList = ref.watch(audioCategoryProvider);
    final textCategoryList = ref.watch(textCategoryProvider);
    final othersCategoryList = ref.watch(othersCategoryProvider);

    final actualCategory = ref.watch(actualCategoryScreenProvider);

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
                      "HubIA - IA's Gratuitas",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    centerTitle: true,
                  ),
                  SizedBox(height: height * 0.02),
                  GestureDetector(
/*                     onTap: () {
                      ref.read(actualCategoryProvider.notifier).state =
                          'Imágenes';
                      context.go('/categoryList');
                    }, */
                      child: Column(
                    children: [
                      WidgetCategoryLine('📷 Imágenes', ref, context),
                      SizedBox(height: height * 0.02),
                      MyCarousel(categoryList: imagesCategoryList),
                    ],
                  )),
                  SizedBox(height: height * 0.02),
                  GestureDetector(
                    child: Column(
                      children: [
                        WidgetCategoryLine('📽️ Videos', ref, context),
                        SizedBox(height: height * 0.02),
                        MyCarousel(categoryList: videoCategoryList),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  GestureDetector(
                    child: Column(
                      children: [
                        WidgetCategoryLine('🎶 Audio', ref, context),
                        SizedBox(height: height * 0.02),
                        MyCarousel(categoryList: audioCategoryList),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  GestureDetector(
                    child: Column(
                      children: [
                        WidgetCategoryLine('💬 Texto', ref, context),
                        SizedBox(height: height * 0.02),
                        MyCarousel(categoryList: textCategoryList),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  GestureDetector(
                    child: Column(
                      children: [
                        WidgetCategoryLine('📌 Otros', ref, context),
                        SizedBox(height: height * 0.02),
                        MyCarousel(categoryList: othersCategoryList),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: _getDrawer(context));
  }

/*   WidgetCarrusel(context, category) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Center(
        child: CarouselSlider(
          items: category,
          options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.25,
              autoPlayInterval: const Duration(seconds: 2),
              enableInfiniteScroll: false,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9),
        ),
      ),
    );
  } */

  Widget WidgetCategoryLine(String categoryName, ref, context) {
    return GestureDetector(
      onTap: () {
        ref.read(actualCategoryScreenProvider.notifier).state = categoryName;
        context.go('/categoryList');
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            categoryName,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _getDrawer(BuildContext context) {
    return Drawer(
      elevation: 1,
      backgroundColor: Color.fromARGB(186, 22, 21, 21),
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
              context.go('/buscarIA');
            }),
            _newDrawerListTileWidget('Categorias', Icons.category, () {
              context.go('/categoryList');
            }),
            _drawerListTileWidget('¿Problemas para ingresar?',
                Icons.sentiment_very_dissatisfied_sharp, () {
              context.go('/problemasIngreso');
            }),
            _drawerListTileWidget('Ayúdanos a mejorar', Icons.feedback, () {
              context.go('/feedback');
            }),
            _drawerListTileWidget('Eliminar anuncios', Icons.auto_delete, () {
              context.go('/eliminarAnuncios');
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
              context.go('/politica');
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
          go;
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
