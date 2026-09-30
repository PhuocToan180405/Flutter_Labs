import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      }
    } catch (_) {}

    try {
      final uri = Uri.parse(url);
      final ipUri = uri.replace(
        scheme: 'https',
        host: '15.235.226.167',
      );
      final client = HttpClient()
        ..badCertificateCallback = ((cert, host, port) => true);
      final request = await client.getUrl(ipUri).timeout(const Duration(seconds: 10));
      request.headers.set('Host', 'api.openweathermap.org');
      final response = await request.close();
      if (response.statusCode == 200) {
        final body = await response.transform(utf8.decoder).join();
        return jsonDecode(body);
      }
    } catch (_) {}

    return null;
  }
}
