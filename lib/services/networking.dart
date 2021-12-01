import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  // This should throw an error so it would be easier for it to get caught.

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;

      // For debugging purposes.
      print(url);

      // Decodes the data into JSON.
      return jsonDecode(data);
    } else {
      print(url);
      print(response.statusCode);
    }
  }
}
