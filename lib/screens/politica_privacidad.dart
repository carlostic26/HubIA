import 'package:flutter/material.dart';
import 'package:hubia/screens/screens_barril.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PoliticaScreen extends StatefulWidget {
  const PoliticaScreen({super.key});

  @override
  State<PoliticaScreen> createState() => _PoliticaScreenState();
}

class _PoliticaScreenState extends State<PoliticaScreen> {
  late WebViewController _controller;

  String politicaUrl =
      'https://ticnoticos.blogspot.com/2024/03/privacy-policy-hubia.html';

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36')
      ..loadRequest(Uri.parse(politicaUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Política de privacidad',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context.go('/home');
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: WebViewWidget(
                  controller: _controller,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
