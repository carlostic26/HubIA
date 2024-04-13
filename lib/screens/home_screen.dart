import 'package:flutter/material.dart';
import 'package:hubia/screens/screens_barril.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;

    final imgUrlimages = ref.watch(imagesCategoryProvider);
    final imgUrlvideo = ref.watch(videoCategoryProvider);
    final imgUrlaudio = ref.watch(audioCategoryProvider);
    final imgUrltext = ref.watch(textCategoryProvider);
    final imgUrlnumber = ref.watch(numberCategoryProvider);
    final imgUrlothers = ref.watch(othersCategoryProvider);

    final selectedCategory = ref.watch(selecCatProvider);

    return Scaffold(
        body: Stack(
          children: [
            AnimatedBackground(),
            Column(
              children: [
                AppBar(
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text(
                    "HubIA - IA's de uso libre",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  centerTitle: true,
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
                ),
                SizedBox(height: height * 0.02),
                saludoWidget(context, ref),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.02),
                        GestureDetector(
                            onTap: () {
                              ref.read(selecCatProvider.notifier).state =
                                  'image';
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
                                  loading: () =>
                                      const CircularProgressIndicator(),
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
                                loading: () =>
                                    const CircularProgressIndicator(),
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
                                loading: () =>
                                    const CircularProgressIndicator(),
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
                                loading: () =>
                                    const CircularProgressIndicator(),
                                error: (err, stack) =>
                                    Text('Ha ocurrido un error: $err'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        GestureDetector(
                          onTap: () {
                            ref.read(selecCatProvider.notifier).state =
                                'number';
                            context.push('/categoryList');
                          },
                          child: Column(
                            children: [
                              WidgetCategoryLine('🔢 Números'),
                              SizedBox(height: height * 0.02),
                              imgUrlnumber.when(
                                data: (numero) {
                                  return MyCarousel(categoryList: numero);
                                },
                                loading: () =>
                                    const CircularProgressIndicator(),
                                error: (err, stack) =>
                                    Text('Ha ocurrido un error: $err'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        GestureDetector(
                          onTap: () {
                            ref.read(selecCatProvider.notifier).state = 'other';
                            context.push('/categoryList');
                          },
                          child: Column(
                            children: [
                              WidgetCategoryLine('📌 Otros'),
                              SizedBox(height: height * 0.02),
                              imgUrlothers.when(
                                data: (numero) {
                                  return MyCarousel(categoryList: numero);
                                },
                                loading: () =>
                                    const CircularProgressIndicator(),
                                error: (err, stack) =>
                                    Text('Ha ocurrido un error: $err'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: _getDrawer(context, ref));
  }

  Widget saludoWidget(BuildContext context, ref) {
    double sizeWidth = MediaQuery.of(context).size.width;
    double sizeHeight = MediaQuery.of(context).size.height;
    String palabraBusqueda = '';

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 5, 0),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Hey! ¿Qué IA vas a buscar?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Explorar IA's",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(nameTutorialInside.notifier).state = 'HubIA';
                      ref.read(urlTutorialInside.notifier).state =
                          'https://youtu.be/PLo_1FW86bg';
                      context.go('/tutorialInside');
                    },
                    icon: Icon(
                      Icons.ondemand_video,
                      size: 35.0,
                      color: Colors.grey,
                    ),
                    label: Text(''),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      'Tutorial',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: sizeWidth * 0.95,
            child: Row(
              children: [
                Container(
                  height: sizeHeight * 0.05,
                  width: 5.0,
                  color: Color.fromARGB(255, 84, 84, 84),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: TextField(
                      onTap: () {
                        context.push('/search');
                      },
                      onChanged: (text) {
                        palabraBusqueda = text;
                      },
                      style: TextStyle(
                        color: Color.fromARGB(150, 255, 255, 255),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Buscar...',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255),
                          fontSize: 12,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Color.fromARGB(150, 255, 255, 255),
                          ),
                          onPressed: () {
                            context.push('/search');
                            // searchCourse(palabraBusqueda);
                          },
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  Widget _getDrawer(BuildContext context, ref) {
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
            _drawerListTileWidget('Categorias', Icons.category, () {
              context.pop();
            }),
            _drawerListTileWidget('IAS favoritos', Icons.favorite, () {
              context.push('/favs');

              //Navigator.pushNamed(context, '/favs');

/*               Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FavoriteScreen()),
              ); */
            }),
            _drawerListTileWidget('Tutorial', Icons.ondemand_video, () {
              ref.read(nameTutorialInside.notifier).state = 'HubIA';
              ref.read(urlTutorialInside.notifier).state =
                  'https://youtu.be/PLo_1FW86bg';
              context.go('/tutorialInside');

              //Navigator.pushNamed(context, '/favs');

/*               Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FavoriteScreen()),
              ); */
            }),
            _drawerListTileWidget(
                '¿Problemas?', Icons.sentiment_very_dissatisfied_sharp, () {
              _showDialogProblemasAcceso(context);
            }),
/*             _drawerListTileWidget('Ayúdanos a mejorar', Icons.feedback, () {
              context.push('/feedback');
            }),
            _drawerListTileWidget('Eliminar anuncios', Icons.auto_delete, () {
              context.push('/eliminarAnuncios');
            }), */
            const SizedBox(height: 20),
            const Divider(
              color: Colors.grey,
            ),
            const Text("  Información", style: TextStyle(color: Colors.white)),
            _drawerListTileWidget('Info de la app', Icons.info, () {}),
            _drawerListTileWidget('Politica de privacidad', Icons.policy, () {
              //context.push('/politica');
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
            Text(title,
                style: const TextStyle(color: Colors.white, fontSize: 13)),
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

  void _showDialogProblemasAcceso(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "¿Problemas para ingresar?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '\nTe recomendamos 4 posibles soluciones: \n\n' +
                          '1. No uses bloqueadores de anuncios DNS. Necesitamos de los anuncios para poder mantener la app.' +
                          ' \n\n2. Verifica tu conexión a internet. Los accesos funcionan solo si tienes conexión a internet, cambiate a WiFi si no puedes entrar con datos móviles.' +
                          ' \n\n3. Abre el acceso de la IA con la opcion de "Abrir con el navegador"' +
                          '\n\n4. En algunos teléfonos la carga de anuncios suele tardarse más que en otros, dependiendo del tipo de smartphone que tengas. Si no te cargan, entra de nuevo.',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 50, 50, 50),
                          fontSize: 13.0),
                    ),
                  ]),
              children: <Widget>[
                Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey), // Cambia el color del botón a verde
                      ),
                      child: Text(
                        'Entiendo',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
              ]);
        });
  }
}
