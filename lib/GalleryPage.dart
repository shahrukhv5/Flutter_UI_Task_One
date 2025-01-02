import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        backgroundColor: const Color(0xFF93ABFF),
        title: const Text(
          'Product Gallery',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ZoomableImageView(photos: photos, index: index),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 6,
                    color: const Color(0xFFE8F0FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: photos[index]['download_url'],
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Product ${photos[index]['id']}',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF3A4D7F),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.amber, size: 20),
                                        const Icon(Icons.star,
                                            color: Colors.amber, size: 20),
                                        const Icon(Icons.star,
                                            color: Colors.amber, size: 20),
                                        const Icon(Icons.star_half,
                                            color: Colors.amber, size: 20),
                                        const Icon(Icons.star_outline,
                                            color: Colors.grey, size: 20),
                                        const SizedBox(width: 6),
                                        Text(
                                          '(${5 + index})',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '₹${(index + 1) * 500 + 1000}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            Text(
                                              '₹${(index + 1) * 500}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFF43A047),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductInfoPage(
                                                      photo: photos[index]),
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF93ABFF),
                                            padding: const EdgeInsets.all(8),
                                          ),
                                          child: const Icon(Icons.info,
                                              size: 20, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Discount Badge
                        Positioned(
                          top: 20,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE53935),
                              // Red color for discount
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '-${10 + (index * 5)}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ZoomableImageView extends StatelessWidget {
  final List<dynamic> photos;
  final int index;

  const ZoomableImageView(
      {super.key, required this.photos, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF93ABFF),
        title: const Text('Zoomable Image'),
      ),
      body: PhotoViewGallery.builder(
        itemCount: photos.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(photos[index]['download_url']),
            initialScale: PhotoViewComputedScale.contained,
            heroAttributes: PhotoViewHeroAttributes(tag: photos[index]['id']),
          );
        },
        pageController: PageController(initialPage: index),
        scrollPhysics: const BouncingScrollPhysics(),
        loadingBuilder: (context, event) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class ProductInfoPage extends StatelessWidget {
  final dynamic photo;

  const ProductInfoPage({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    final url = photo['url'];
    if (url == null || !url.startsWith('http')) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Invalid URL')),
      );
    }

    final WebViewController controller = WebViewController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF93ABFF),
        title: const Text(
          'Product Info',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.reload();
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
