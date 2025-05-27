import 'package:html2md/html2md.dart' as html2md;

String htmlToMarkdown(String html) {
  return html2md.convert(html);
}
