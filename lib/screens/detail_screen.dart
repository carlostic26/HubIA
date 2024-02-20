import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hubia/screens/screens_barril.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    late DatabaseHandlerIA dbhandler;

    final selectedIA = ref.watch(selectedIAProvider);

    return Scaffold(
      body: Stack(children: [
        AnimatedBackground(),
        Column(
          children: [_appBar(selectedIA.toString(), context)],
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
          //context.go('/home');
          context.pop();
        },
      ),
    );
  }
}
