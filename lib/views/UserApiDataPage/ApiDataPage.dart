import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sigup_sigin_ui/views/UserApiDataPage/UserDetailPage/UserDetailPage.dart';
import 'package:sigup_sigin_ui/controllers/UserController/UserController.dart';
import 'package:sigup_sigin_ui/models/UserModel/User.dart';

class ApiDataPage extends StatefulWidget {
  const ApiDataPage({super.key});

  @override
  _ApiDataPageState createState() => _ApiDataPageState();
}

class _ApiDataPageState extends State<ApiDataPage> {
  final UserController _userController = UserController();
  List<User> _users = [];
  List<User> _filteredUsers = [];
  bool _isLoading = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    setState(() => _isLoading = true);
    try {
      final users = await _userController.fetchUsers();
      setState(() {
        _users = users;
        _filteredUsers = users;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _addUser(Map<String, dynamic> newUser) async {
    setState(() => _isLoading = true);
    try {
      final user = await _userController.createUser(newUser);
      setState(() {
        _users.add(user);
        _filteredUsers = _users;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User added successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _filterUsers(String query) {
    setState(() {
      _searchQuery = query;
      _filteredUsers = query.isEmpty
          ? _users
          : _users
              .where((user) =>
                  user.name.toLowerCase().contains(query.toLowerCase()) ||
                  user.email.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  void _showAddUserDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name')),
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email')),
            TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final newUser = {
                'name': nameController.text,
                'email': emailController.text,
                'phone': phoneController.text,
              };
              _addUser(newUser);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users List',
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF93ABFF),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddUserDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF93ABFF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.r),
                bottomRight: Radius.circular(25.r),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                TextField(
                  onChanged: _filterUsers,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search",
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFF93ABFF)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = _filteredUsers[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailPage(user: user),
                            ),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          elevation: 5,
                          shadowColor: Colors.blue.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xFF93ABFF),
                                  radius: 30.r,
                                  child: Text(
                                    user.id.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name: ${user.name.toUpperCase()}",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Email: ${user.email}",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Address: ${user.address}, ${user.city}",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
