// serach bar code
// Padding(
// padding: const EdgeInsets.all(10.0),
// child: TextField(
// onChanged: _filterData,
// decoration: InputDecoration(
// labelText: 'Search',
// hintText: 'Search by title or comment',
// prefixIcon: const Icon(Icons.search, color: Color(0xFF93ABFF)),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(20),
// ),
// focusedBorder: OutlineInputBorder(
// borderSide:
// const BorderSide(color: Color(0xFF93ABFF), width: 2),
// borderRadius: BorderRadius.circular(20),
// ),
// ),
// ),
// ),

import 'package:flutter/material.dart';

class PerformanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Performance Card"),
        backgroundColor: Color(0xFF93ABFF),
      ),
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 350,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      // backgroundImage: AssetImage('assets/avatar.png'),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TOP USER",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Gillian P.",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Daily Purchase: 10 items",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
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
//this is my api page code
// child: Padding(
//   padding: const EdgeInsets.all(15),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         crossAxisAlignment:
//             CrossAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             backgroundColor: Color(0xFF93ABFF),
//             child: Text(
//               item['id'].toString(),
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               "Name: " +
//                   item['name']
//                       .toString()
//                       .toUpperCase(),
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF93ABFF),
//               ),
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 10),
//       Text(
//         "Email: " + item['email'],
//         style: const TextStyle(
//           fontSize: 16,
//           color: Colors.black87,
//         ),
//         textAlign: TextAlign.justify,
//       ),
//       const SizedBox(height: 8),
//       Text(
//         "Address: ${item['address']['street']}, ${item['address']['city']}",
//         style: const TextStyle(fontSize: 16),
//       ),
//     ],
//   ),
// ),
//this is second code
// import 'dart:convert'; // JSON data ko parse karne ke liye import kiya hai
// import 'package:flutter/material.dart'; // Flutter ka UI framework
// import 'package:http/http.dart'
//     as http; // API requests bhejne ke liye http package import kiya hai
//
// // StatefulWidget jisme state change ho sakta hai
// class ApiDataPage extends StatefulWidget {
//   const ApiDataPage({Key? key}) : super(key: key);
//
//   @override
//   _ApiDataPageState createState() =>
//       _ApiDataPageState(); // State create karte hain
// }
//
// class _ApiDataPageState extends State<ApiDataPage> {
//   List<dynamic> _data =
//       []; // API se milne wale data ko store karne ke liye empty list
//   bool _isLoading =
//       false; // Is flag ka use loading state ko track karne ke liye kiya jaata hai
//
//   // API se data fetch karne ke liye function
//   Future<void> fetchData() async {
//     setState(() {
//       _isLoading =
//           true; // Jab data fetch ho raha ho, loading indicator show karne ke liye _isLoading true karte hain
//     });
//
//     try {
//       final url =
//           Uri.parse('https://jsonplaceholder.typicode.com/posts'); // API ka URL
//       final response = await http.get(url); // API se GET request bhejte hain
//
//       if (response.statusCode == 200) {
//         // Agar response 200 OK ho
//         final List<dynamic> responseData = json.decode(
//             response.body); // Response body ko JSON format me decode karte hain
//         setState(() {
//           _data = responseData; // Data ko _data list me store karte hain
//         });
//       } else {
//         throw Exception(
//             'Failed to load data'); // Agar status code 200 nahi hai toh error throw karte hain
//       }
//     } catch (e) {
//       // Agar error aata hai toh user ko snackbar se inform karte hain
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching data: $e')),
//       );
//     } finally {
//       // Finally block me loading indicator ko hide karte hain
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Fetch API Data'), // App bar ka title
//         backgroundColor: Colors.blue, // App bar ka color
//       ),
//       body: _isLoading
//           ? const Center(
//               child:
//                   CircularProgressIndicator()) // Agar data load ho raha ho toh loading indicator show hoga
//           : _data.isEmpty
//               ? const Center(
//                   child: Text(
//                       'No data available')) // Agar data empty ho toh yeh message dikhega
//               : ListView.builder(
//                   // Agar data available ho toh ListView me items show karenge
//                   itemCount: _data.length, // List me total items ki count
//                   itemBuilder: (context, index) {
//                     final item =
//                         _data[index]; // List se ek item ko fetch karte hain
//                     return Card(
//                       // Card widget use karte hain har item ko show karne ke liye
//                       margin: const EdgeInsets.all(10),
//                       // Card ke around margin add karte hain
//                       elevation: 5,
//                       // Card ka elevation
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                             10), // Card ko rounded corners dete hain
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15),
//                         // Card ke andar padding add karte hain
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           // Text ko left side me align karte hain
//                           children: [
//                             Text(
//                               "Title: ${item['title']}", // Title ko display karte hain
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight:
//                                     FontWeight.bold, // Title ko bold karte hain
//                               ),
//                             ),
//                             const SizedBox(
//                                 height: 8), // Text ke beech me gap daalte hain
//                             Text(
//                               "Comment: ${item['body']}", // Body ko display karte hain
//                               style: const TextStyle(fontSize: 16),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: fetchData,
//         // Refresh button click par fetchData call hota hai
//         backgroundColor: Colors.blue,
//         child: const Icon(Icons.refresh), // Button me refresh icon dikhata hai
//       ),
//     );
//   }
// }
//Second Code..........
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
//   List<dynamic> _data = []; // API data
//   List<dynamic> _filteredData = []; // Filtered data for search
//   bool _isLoading = false;
//   String _searchQuery = ''; // Search query
//
//   Future<void> fetchData() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       final url = Uri.parse(
//           'https://jsonplaceholder.typicode.com/posts'); // API endpoint
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = json.decode(response.body);
//         setState(() {
//           _data = responseData;
//           _filteredData = responseData; // Initially, all data is shown
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
//         _filteredData = _data; // Reset to full data when query is empty
//       } else {
//         _filteredData = _data
//             .where((item) =>
//                 item['title']
//                     .toString()
//                     .toLowerCase()
//                     .contains(query.toLowerCase()) || // Filter by title
//                 item['body']
//                     .toString()
//                     .toLowerCase()
//                     .contains(query.toLowerCase())) // Filter by body
//             .toList();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search API Data'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: TextField(
//               onChanged: _filterData, // Call _filterData on text change
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 hintText: 'Enter title or comment',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           ),
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
//                             margin: const EdgeInsets.all(10),
//                             elevation: 5,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(15),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Title: ${item['title']}",
//                                     style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     "Comment: ${item['body']}",
//                                     style: const TextStyle(fontSize: 16),
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
