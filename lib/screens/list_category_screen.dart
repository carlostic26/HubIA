import 'package:flutter/material.dart';
import 'package:hubia/screens/screens_barril.dart';

class ListCategoryScreen extends ConsumerWidget {
  const ListCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    final imagesCategoryList = ref.watch(imagesCategoryProvider);
    final videoCategoryList = ref.watch(videoCategoryProvider);
    final audioCategoryList = ref.watch(audioCategoryProvider);
    final textCategoryList = ref.watch(textCategoryProvider);
    final othersCategoryList = ref.watch(othersCategoryProvider);

    late DbHandlerIA handler;

    Future<List<IA>>? _ia;

    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
