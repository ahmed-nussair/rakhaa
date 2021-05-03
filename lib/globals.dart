import 'package:http/http.dart' as http;

final String token = 'token';
final String name = 'name';
final String username = 'username';
final String email = 'email';
final String phone = 'phone';
final String imageUrl = 'imageUrl';
final String password = 'password';

Future<bool> getImage(String url) async {
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
