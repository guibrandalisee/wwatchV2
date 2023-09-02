import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wwatch/stores/movie_store.dart';

class VidSrcScreen extends StatefulWidget {
  VidSrcScreen(
      {Key? key,
      required this.movieId,
      this.seasonId,
      this.epId,
      required this.contentType})
      : super(key: key);

  final int movieId;
  final int? seasonId;
  final int? epId;
  final CustomContentType contentType;

  @override
  State<VidSrcScreen> createState() => _VidSrcScreenState();
}

class _VidSrcScreenState extends State<VidSrcScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  String url = "";
  final urlController = TextEditingController();

  // widget.contentType ==
  //           CustomContentType.MOVIE
  //       ? "https://vidsrc.to/embed/movie/${widget.movieId}"
  //       : "https://vidsrc.to/embed/tv/${widget.movieId}/${widget.seasonId}/${widget.epId}"

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    url = widget.contentType == CustomContentType.MOVIE
        ? "https://vidsrc.to/embed/movie/${widget.movieId}"
        : "https://vidsrc.to/embed/tv/${widget.movieId}/${widget.seasonId}/${widget.epId}";

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (await webViewController!.canGoBack()) {
            webViewController!.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: SafeArea(
          child: InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(
                url: Uri.parse(widget.contentType == CustomContentType.MOVIE
                    ? "https://vidsrc.to/embed/movie/${widget.movieId}"
                    : "https://vidsrc.to/embed/tv/${widget.movieId}/${widget.seasonId}/${widget.epId}")),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url!;

              if (![
                "http",
                "https",
                "file",
                "chrome",
                "data",
                "javascript",
                "about"
              ].contains(uri.scheme)) {
                if (await canLaunchUrl(uri)) {
                  // Launch the App
                  await launchUrl(
                    uri,
                  );
                  // and cancel the request
                  return NavigationActionPolicy.CANCEL;
                }
              }

              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (controller, url) async {
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {}
              setState(() {
                urlController.text = this.url;
              });
            },
            onUpdateVisitedHistory: (controller, url, androidIsReload) {
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });
            },
            onConsoleMessage: (controller, consoleMessage) {
              print(consoleMessage);
            },
          ),
        ),
      ),
    );
  }
}
