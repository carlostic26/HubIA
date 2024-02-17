import 'package:flutter/material.dart';
import 'package:hubia/screens/screens_barril.dart';

class ListCategoryScreen extends ConsumerWidget {
  const ListCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    late DbHandlerIA handler;

    Future<List<IA>>? _ia;

    final actualCategoryScreen = ref.watch(actualCategoryScreenProvider);

    return const Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
            Text('hpla'),
          ],
        ),
      ),
    );
  }
}
