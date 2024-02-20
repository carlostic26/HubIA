import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hubia/screens/screens_barril.dart';

class DetailScreen extends ConsumerWidget {
  final IA? ia;

  DetailScreen({this.ia, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    late DatabaseHandlerIA dbhandler;

    //final nameIA = ref.watch(nameIAProvider);

    final ia = ref.watch(selectedIAProvider.notifier).state;

    return Scaffold(
      body: Stack(children: [
        AnimatedBackground(),
        Column(
          children: [
            _appBar(ia != null ? ia.name.toString() : 'Nombre no disponible',
                context),
            Padding(
                padding: const EdgeInsets.fromLTRB(
                    1.0, 1.0, 0.0, 1.0), //borde de la imagen
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CachedNetworkImage(
                    imageUrl: ia != null
                        ? ia.imageUrl.toString()
                        : 'Img no disponible',
                    width: 400.0,
                    height: 210.0,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                      color: Colors.grey,
                    )),
                    placeholderFadeInDuration:
                        const Duration(milliseconds: 200),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )),
          ],
        )
      ]),
    );
  }

  AppBar _appBar(String selectedIA, BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        selectedIA,
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
            context.go('/categoryList');
          }
        },
      ),
    );
  }
}
