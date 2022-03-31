import 'dart:io';

class AdMobService {
  String getAdMobAppId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3194449839922061~6470256570';
    }
    return 'ca-app-pub-3194449839922061/5157174901';
  }

  String getBannerAdId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3194449839922061/5157174901';
    }
    return 'ca-app-pub-3194449839922061/5157174901';
  }
}
