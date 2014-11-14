import 'dart:html';
import 'package:route/client.dart';
import 'package:liquid_web/pages/home.dart' deferred as home;

void main() {
  final homeUrl = new UrlPattern(r'(/|/index.html)');

  final router = new Router()
    ..addHandler(homeUrl, (_) {
      home.loadLibrary().then((_) {
        home.main();
      });
    });

  router.handle(window.location.pathname);
}
