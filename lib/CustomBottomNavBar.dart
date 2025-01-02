import 'package:flutter/material.dart';
import 'Home.dart';
import 'GalleryPage.dart';
import 'ApiDataPage.dart';
import 'Profile.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFF93ABFF),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, Icons.home, "Home", 0),
            _buildNavItem(context, Icons.shop, "Gallery", 1),
            _buildNavItem(context, Icons.api, "API Data", 2),
            _buildNavItem(context, Icons.person, "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, IconData icon, String label, int index) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF93ABFF) : Colors.white,
            ),
            if (isSelected) const SizedBox(width: 8),
            if (isSelected)
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
