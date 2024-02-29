import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hubia/screens/screens_barril.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProvider = StateProvider<bool>((ref) => true);

class WebViewScreen extends ConsumerWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ia = ref.watch(selectedIAProvider.notifier).state;
    final isLoading = ref.watch(loadingProvider);

    Future.delayed(const Duration(seconds: 5), () {
      ref.read(loadingProvider.notifier).state = false;
    });

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  ia!.name.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context.go('/detailScreen');
                      },
                    );
                  },
                ),
                actions: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //openUrl();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          disabledForegroundColor: Colors.transparent,
                          disabledBackgroundColor: Colors.transparent,
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.youtube,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: WebView(
                  initialUrl: ia.webUrl.toString(),
                  javascriptMode: JavascriptMode.unrestricted,
                  userAgent:
                      //'Mozilla/5.0 (Linux; Android 9.0; Build/N2G48H; Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Mobile Safari/537.3',
                      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36',
                ),
              ),
            ],
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
