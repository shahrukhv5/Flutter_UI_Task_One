import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/ PhotoModel/Photo.dart';

class GalleryController {
  final String apiUrl = 'https://picsum.photos/v2/list?page=1&limit=10';

  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
