// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class ApiDataPage extends StatefulWidget {
//   const ApiDataPage({Key? key}) : super(key: key);
//
//   @override
//   _ApiDataPageState createState() => _ApiDataPageState();
// }
//
// class _ApiDataPageState extends State<ApiDataPage> {
//   List<dynamic> _data = [];
//   List<dynamic> _filteredData = [];
//   bool _isLoading = false;
//   String _searchQuery = '';
//
//   Future<void> fetchData() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       // final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/');
//       final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = json.decode(response.body);
//         setState(() {
//           _data = responseData;
//           _filteredData = responseData;
//         });
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching data: $e')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _filterData(String query) {
//     setState(() {
//       _searchQuery = query;
//       if (query.isEmpty) {
//         _filteredData = _data;
//       } else {
//         _filteredData = _data
//             .where((item) =>
//                 item['name']
//                     .toString()
//                     .toLowerCase()
//                     .contains(query.toLowerCase()) ||
//                 item['body']
//                     .toString()
//                     .toLowerCase()
//                     .contains(query.toLowerCase()))
//             .toList();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Search Box
//           Expanded(
//             child: _isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : _filteredData.isEmpty
//                     ? const Center(child: Text('No data available'))
//                     : ListView.builder(
//                         itemCount: _filteredData.length,
//                         itemBuilder: (context, index) {
//                           final item = _filteredData[index];
//                           return Card(
//                             margin: const EdgeInsets.symmetric(
//                                 horizontal: 15, vertical: 10),
//                             elevation: 8,
//                             shadowColor: Colors.blue.shade100,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Container(
//                               width: 350,
//                               padding: EdgeInsets.all(20),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                         backgroundColor: Color(0xFF93ABFF),
//                                         radius: 30,
//                                         child: Text(
//                                           item['id'].toString(),
//                                           style: const TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       SizedBox(width: 15),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Name: " +
//                                                   item['name']
//                                                       .toString()
//                                                       .toUpperCase(),
//                                               style: TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                             Text(
//                                               "Email: " + item['email'],
//                                               style: TextStyle(
//                                                 fontSize: 18,
//                                                 color: Colors.grey,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                             Text(
//                                               "Address: ${item['address']['street']}, ${item['address']['city']}",
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.grey,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: fetchData,
//         backgroundColor: Colors.blue,
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class ApiDataPage extends StatefulWidget {
//   const ApiDataPage({Key? key}) : super(key: key);
//
//   @override
//   _ApiDataPageState createState() => _ApiDataPageState();
// }
//
// class _ApiDataPageState extends State<ApiDataPage> {
//   List<dynamic> _data = [];
//   List<dynamic> _filteredData = [];
//   bool _isLoading = false;
//   String _searchQuery = '';
//
//   Future<void> fetchData() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = json.decode(response.body);
//         setState(() {
//           _data = responseData;
//           _filteredData = responseData;
//         });
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching data: $e')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _filterData(String query) {
//     setState(() {
//       _searchQuery = query;
//       if (query.isEmpty) {
//         _filteredData = _data;
//       } else {
//         _filteredData = _data
//             .where((item) =>
//                 item['name']
//                     .toString()
//                     .toLowerCase()
//                     .contains(query.toLowerCase()) ||
//                 item['email']
//                     .toString()
//                     .toLowerCase()
//                     .contains(query.toLowerCase()))
//             .toList();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Custom AppBar
//           Container(
//             decoration: BoxDecoration(
//               color: Color(0xFF93ABFF), // Purple background color
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(25),
//                 bottomRight: Radius.circular(25),
//               ),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Stack(
//                   alignment: Alignment.center,
//                   // Center all children in the stack
//                   children: [
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: GestureDetector(
//                         child: Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       "Users List",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 50),
//                 TextField(
//                   onChanged: _filterData,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     hintText: "Search",
//                     prefixIcon: Icon(Icons.search, color: Color(0xFF93ABFF)),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Data List
//           Expanded(
//             child: _isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : _filteredData.isEmpty
//                     ? Column(
//                         children: [
//                           const Center(child: Text('No data available')),
//                           FloatingActionButton(
//                             onPressed: fetchData,
//                             backgroundColor: Color(0xFF93ABFF),
//                             child: const Icon(Icons.refresh),
//                           ),
//                         ],
//                       )
//                     : ListView.builder(
//                         itemCount: _filteredData.length,
//                         itemBuilder: (context, index) {
//                           final item = _filteredData[index];
//                           return Card(
//                             margin: const EdgeInsets.symmetric(
//                                 horizontal: 15, vertical: 10),
//                             elevation: 5,
//                             shadowColor: Colors.blue.shade100,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Container(
//                               padding: EdgeInsets.all(20),
//                               child: Row(
//                                 children: [
//                                   CircleAvatar(
//                                     backgroundColor: Color(0xFF93ABFF),
//                                     radius: 30,
//                                     child: Text(
//                                       item['id'].toString(),
//                                       style: const TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   SizedBox(width: 15),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Name: " +
//                                               item['name']
//                                                   .toString()
//                                                   .toUpperCase(),
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         Text(
//                                           "Email: " + item['email'],
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             color: Colors.grey,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         Text(
//                                           "Address: ${item['address']['street']}, ${item['address']['city']}",
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiDataPage extends StatefulWidget {
  const ApiDataPage({Key? key}) : super(key: key);

  @override
  _ApiDataPageState createState() => _ApiDataPageState();
}

class _ApiDataPageState extends State<ApiDataPage> {
  List<dynamic> _data = [];
  List<dynamic> _filteredData = [];
  bool _isLoading = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchData(); // Automatically fetch data when the widget is initialized
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _data = responseData;
          _filteredData = responseData;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterData(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredData = _data;
      } else {
        _filteredData = _data
            .where((item) =>
                item['name']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                item['email']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF93ABFF), // Purple background color
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      "Users List",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                TextField(
                  onChanged: _filterData,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search, color: Color(0xFF93ABFF)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Data List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filteredData.length,
                    itemBuilder: (context, index) {
                      final item = _filteredData[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        elevation: 5,
                        shadowColor: Colors.blue.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xFF93ABFF),
                                radius: 30,
                                child: Text(
                                  item['id'].toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name: " +
                                          item['name'].toString().toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Email: " + item['email'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Address: ${item['address']['street']}, ${item['address']['city']}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
