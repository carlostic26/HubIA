import 'package:flutter/material.dart';
import 'package:hubia/model/db/ia_model.dart';
import 'package:hubia/screens/screens_barril.dart';

class MyCarousel extends StatefulWidget {
  final List<IA> categoryList; // Agrega un campo para la lista de categorías

  // Constructor que requiere categoryList al crear la clase
  const MyCarousel({Key? key, required this.categoryList}) : super(key: key);

  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  @override
  Widget build(BuildContext context) {
    double widthCertifiedImage = 500;
    String loadingImg =
        'https://blogger.googleusercontent.com/img/a/AVvXsEjbWsuck6YxMLJQ8XSE1Hf7oP3qTbl0vbYlmidLWs76n5EgKJ714bmdkkJlLMZEXG4JjpMkkBJDHtUAHK1UJuHea5pJCjmSFSxk8X62tw93d-rOJxz38K8knBx95EOQWqbv3phWaFiB-tojm_ltY9ioDOO3Ydx9z6s4JeAWxzhy3esQJP7GjNSZjUvH';

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Center(
        child: CarouselSlider(
          items: widget.categoryList.map((category) {
            return CachedNetworkImage(
              imageUrl: category.imageUrl ?? loadingImg,
              width: widthCertifiedImage,
              fit: BoxFit.contain,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              placeholderFadeInDuration: const Duration(milliseconds: 200),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          }).toList(),
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.25,
            autoPlayInterval: const Duration(
                seconds: 1), // Cambiado a 1 segundo como solicitaste
            enableInfiniteScroll: false,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
          ),
        ),
      ),
    );
  }
}
