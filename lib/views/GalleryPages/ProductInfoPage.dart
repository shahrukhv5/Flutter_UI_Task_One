import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../models/ PhotoModel/Photo.dart';

class ProductInfoPage extends StatelessWidget {
  final Photo photo;

  const ProductInfoPage({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF93ABFF),
        title: Text(
          'Product Info',
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold),
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
        controller: controller..loadRequest(Uri.parse(photo.url)),
      ),
    );
  }
}
