import 'package:fyp/models/Detail.dart';
import 'package:url_launcher/url_launcher.dart';

launchMap(Coordinates coord) async {
  final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${coord.latitude},${coord.longitude}');
  try {
    await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    );
  } catch (e) {
    print(e);
  }
}
