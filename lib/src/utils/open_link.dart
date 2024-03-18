import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(String url) async {
  final Uri link = Uri.parse(url);

  if (!await launchUrl(link, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $link');
  }
}
