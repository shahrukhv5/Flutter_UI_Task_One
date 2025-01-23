import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../models/ PhotoModel/Photo.dart';

class ZoomableImageView extends StatelessWidget {
  final List<Photo> photos;
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
            imageProvider: NetworkImage(photos[index].downloadUrl),
            initialScale: PhotoViewComputedScale.contained,
            heroAttributes: PhotoViewHeroAttributes(tag: photos[index].id),
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
