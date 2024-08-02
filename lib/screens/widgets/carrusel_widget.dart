import 'package:flutter/material.dart';
import 'package:hubia/screens/screens_barril.dart';

class MyCarousel extends StatefulWidget {
  final List<IA> categoryList; // Agrega un campo para la lista de categorías
  const MyCarousel({Key? key, required this.categoryList}) : super(key: key);

  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  @override
  Widget build(BuildContext context) {
    double imageSize = 250;

    String loadingImg =
        'https://blogger.googleusercontent.com/img/a/AVvXsEjbWsuck6YxMLJQ8XSE1Hf7oP3qTbl0vbYlmidLWs76n5EgKJ714bmdkkJlLMZEXG4JjpMkkBJDHtUAHK1UJuHea5pJCjmSFSxk8X62tw93d-rOJxz38K8knBx95EOQWqbv3phWaFiB-tojm_ltY9ioDOO3Ydx9z6s4JeAWxzhy3esQJP7GjNSZjUvH';

    List<Widget> combinedItems = [];
    for (int i = 0; i < widget.categoryList.length; i += 2) {
      if (i + 1 < widget.categoryList.length) {
        combinedItems.add(
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child: CachedNetworkImage(
                    imageUrl: widget.categoryList[i].imageUrl ?? loadingImg,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    placeholderFadeInDuration:
                        const Duration(milliseconds: 500),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(width: 10), // Adjust spacing between images as needed
              Expanded(
                child: SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child: CachedNetworkImage(
                    imageUrl: widget.categoryList[i + 1].imageUrl ?? loadingImg,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    placeholderFadeInDuration:
                        const Duration(milliseconds: 800),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        // In case the number of categories is odd, handle the last one individually
        combinedItems.add(
          SizedBox(
            width: imageSize,
            height: imageSize,
            child: CachedNetworkImage(
              imageUrl: widget.categoryList[i].imageUrl ?? loadingImg,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              placeholderFadeInDuration: const Duration(milliseconds: 800),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        );
      }
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Center(
        child: CarouselSlider(
          items: combinedItems,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.25,
            autoPlayInterval: const Duration(seconds: 6),
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
