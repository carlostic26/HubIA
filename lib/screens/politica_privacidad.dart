import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:hubia/screens/screens_barril.dart';

class politicaPrivacidad extends StatelessWidget {
  const politicaPrivacidad({super.key});

  @override
  Widget build(BuildContext context) {
    String politicaUrl =
        'https://ticnoticos.blogspot.com/2024/03/privacy-policy-hubia.html';

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
                child: WebView(
                  initialUrl: politicaUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  userAgent:
                      //'Mozilla/5.0 (Linux; Android 9.0; Build/N2G48H; Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Mobile Safari/537.3',
                      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
