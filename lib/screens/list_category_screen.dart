import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hubia/screens/screens_barril.dart';

class ListCategoryScreen extends ConsumerWidget {
  const ListCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    late DatabaseHandlerIA dbhandler;

    Future<List<IA>>? _ia;

    final selectedCategory = ref.watch(selecCatProvider);

    return Scaffold(
      body: Stack(children: [
        AnimatedBackground(),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              AppBar(
                title: Text('$selectedCategory'),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
              const Text('hpla'),
            ],
          ),
        ),
      ]),
    );
  }
}
