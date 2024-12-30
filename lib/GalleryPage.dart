import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<dynamic> photos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    final response = await http
        .get(Uri.parse('https://picsum.photos/v2/list?page=1&limit=10'));
    if (response.statusCode == 200) {
      setState(() {
        photos = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              padding: EdgeInsets.all(8),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageDetailPage(
                        photos: photos,
                        initialIndex: index,
                      ),
                    ),
                  ),
                  child: Hero(
                    tag: photos[index]['id'],
                    child: CachedNetworkImage(
                      imageUrl: photos[index]['download_url'],
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ImageDetailPage extends StatelessWidget {
  final List<dynamic> photos;
  final int initialIndex;

  ImageDetailPage({required this.photos, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
      ),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: photos.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(
                  photos[index]['download_url'],
                ),
                heroAttributes:
                    PhotoViewHeroAttributes(tag: photos[index]['id']),
              );
            },
            pageController: PageController(initialPage: initialIndex),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              child: Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductInfoPage(photo: photos[initialIndex]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductInfoPage extends StatelessWidget {
  final dynamic photo;

  const ProductInfoPage({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    // Ensure the URL is valid
    final url = photo['url'];
    if (url == null || !url.startsWith('http')) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Invalid URL')),
      );
    }

    // Create a WebViewController
    final WebViewController controller = WebViewController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Info'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller.reload(); // Reload the web page
            },
          ),
        ],
      ),
      body: WebViewWidget(
        controller: controller..loadRequest(Uri.parse(url)),
      ),
    );
  }
}
