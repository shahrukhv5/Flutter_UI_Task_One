import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sigup_sigin_ui/views/GalleryPages/ProductInfoPage.dart';
import 'package:sigup_sigin_ui/views/GalleryPages/ZoomableImageView.dart';
import '../../controllers/GalleryController/GalleryController.dart';
import '../../models/ PhotoModel/Photo.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final GalleryController _galleryController = GalleryController();
  List<Photo> photos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    setState(() => isLoading = true);
    try {
      photos = await _galleryController.fetchPhotos();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF93ABFF),
        title: Text(
          'Product Gallery',
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
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
                    margin: EdgeInsets.only(bottom: 16.h),
                    elevation: 6,
                    color: const Color(0xFFE8F0FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0.w, vertical: 16.0.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: CachedNetworkImage(
                                  imageUrl: photo.downloadUrl,
                                  height: 150.h,
                                  width: 150.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Product ${photo.id}',
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF3A4D7F),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 20.sp),
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 20.sp),
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 20.sp),
                                        Icon(Icons.star_half,
                                            color: Colors.amber, size: 20.sp),
                                        Icon(Icons.star_outline,
                                            color: Colors.grey, size: 20.sp),
                                        SizedBox(width: 6.w),
                                        Text(
                                          '(${5 + index})',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12.h),
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
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            Text(
                                              '₹${(index + 1) * 500}',
                                              style: TextStyle(
                                                fontSize: 20.sp,
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w, vertical: 8.w),
                                          ),
                                          child: Icon(Icons.info,
                                              size: 20.sp, color: Colors.white),
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
                          top: 20.h,
                          right: 20.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE53935),
                              // Red color for discount
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              '-${10 + (index * 5)}%',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
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
