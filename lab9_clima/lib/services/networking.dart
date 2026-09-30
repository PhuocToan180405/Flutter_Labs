import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  /// Gọi API và phân tích dữ liệu JSON trả về
  Future<dynamic> getData() async {
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        // Trả về mã lỗi từ server (ví dụ 401: Invalid API key, 404: City not found)
        return null;
      }
    } catch (e) {
      // Lỗi kết nối mạng hoặc timeout
      return null;
    }
  }
}
