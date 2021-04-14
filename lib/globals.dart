import 'package:http/http.dart' as http;

Future<bool> getImage(String url) async {
  var response = await http.get(url);

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
