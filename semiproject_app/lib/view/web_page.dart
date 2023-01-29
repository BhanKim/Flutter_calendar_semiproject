import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webPage extends StatefulWidget {
  const webPage({super.key});

  @override
  State<webPage> createState() => _webPageState();
}

class _webPageState extends State<webPage> {
  late WebViewController webController;
  late bool isLoading;
  late String siteName;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    siteName = 'www.kr.playblackdesert.com/ko-KR/main/index';
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              isLoading = true;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://$siteName'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        backgroundColor: Color.fromARGB(255, 41, 35, 35),
        foregroundColor: Color.fromARGB(255, 206, 186, 0),
      ),
      body: Stack(
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
          WebViewWidget(
            controller: webController,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.arrow_back),
        onPressed: () {
          backProcess(context);
        },
      ),
    );
  }

  // --- Fuctions ---
  Future<bool> backProcess(BuildContext context) async {
    if (await webController.canGoBack()) {
      webController.goBack();
    } else {
      snackBarFunction(context);
      return Future.value(false);
    }
    return Future.value(true);
  }

  snackBarFunction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No more to go!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
} //END
