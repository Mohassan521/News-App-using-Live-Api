import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;

  const ArticleView({super.key, required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late final PlatformWebViewControllerCreationParams params;
  late final WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.blogUrl));

    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_sharp)),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Insight',
                style: TextStyle(color: Colors.black),
              ),
              const Text(
                'Blend',
                style: TextStyle(color: Colors.blue),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.save))
            ],
          ),
        ),
        body: WebViewWidget(controller: controller));
  }
}
