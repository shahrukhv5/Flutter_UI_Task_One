import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sigup_sigin_ui/models/UserModel/User.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "User Details",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF93ABFF),
      ),
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Container(
            width: 350.w,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF93ABFF),
                      radius: 30.r,
                      child: Text(
                        user.id.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: ${user.name ?? 'N/A'}", // Null check
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Email: ${user.email ?? 'N/A'}", // Null check
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Phone: ${user.phone ?? 'N/A'}", // Null check
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Divider(color: Colors.grey.shade400, thickness: 1),
                SizedBox(height: 10.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Website: ${user.website ?? 'N/A'}", // Null check
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Address:",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Null check for address fields
                    Text(
                      user.address != null
                          ? "${user.address}, Suite: ${user.suite}, ${user.city}, Zipcode: ${user.zipcode}"
                          : "N/A",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Company:",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Null check for company fields
                    Text(
                      user.company != null ? "${user.company}" : "N/A",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
