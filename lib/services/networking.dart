import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class NetworkingHelper {
  final Uri uri;
  late int requestFailed;

  NetworkingHelper({required this.uri});

  getData() async {
    final Uri urlComposed = uri;
    final response = await http.get(urlComposed);
    if (response.statusCode == 200) {
      final jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      return requestFailed = response.statusCode;
    }
  }
}
