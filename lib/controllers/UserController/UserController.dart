import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sigup_sigin_ui/models/UserModel/User.dart';

class UserController {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> createUser(Map<String, dynamic> newUser) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newUser),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }
}
