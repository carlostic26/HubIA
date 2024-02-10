import 'package:flutter/material.dart';
import 'package:hubia/screens/screens_barril.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    final imagesCategoryList = ref.watch(imagesCategoryProvider);

    final videoCategoryList = ref.watch(videoCategoryProvider);

    final audioCategoryList = ref.watch(audioCategoryProvider);

    final othersCategoryList = ref.watch(othersCategoryProvider);

    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(),
          Column(
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
              WidgetCategoryLine('📷 Imágenes'),
              SizedBox(height: height * 0.02),
              MyCarousel(categoryList: imagesCategoryList),
              SizedBox(height: height * 0.02),
              WidgetCategoryLine('📽️ Videos'),
              SizedBox(height: height * 0.02),
              MyCarousel(categoryList: videoCategoryList),
              SizedBox(height: height * 0.02),
              WidgetCategoryLine('🎶 Audio'),
              SizedBox(height: height * 0.02),
              MyCarousel(categoryList: audioCategoryList),
              SizedBox(height: height * 0.02),
              WidgetCategoryLine('🎶 Audio'),
              SizedBox(height: height * 0.02),
              MyCarousel(categoryList: othersCategoryList),
            ],
          ),
        ],
      ),
    );
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

  WidgetCategoryLine(String categoryName) {
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
}
