// class User {
//   final int id;
//   final String name;
//   final String email;
//   final String phone;
//   final String address;
//   final String city;
//   final String website;
//   final String company;
//
//   User(
//       {required this.id,
//       required this.name,
//       required this.email,
//       required this.phone,
//       required this.address,
//       required this.city,
//       required this.website,
//       required this.company});
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       email: json['email'] as String,
//       phone: json['phone'] as String,
//       address: json['address']?['street'] ?? 'No address available',
//       city: json['address']?['city'] ?? 'No city available',
//       website: json['website'] as String,
//       company: json['company']['name'] as String,
//     );
//   }
// }
// second code
// class User {
//   final int id;
//   final String name;
//   final String email;
//   final String phone;
//   final String address; // Street
//   final String suite;
//   final String city;
//   final String zipcode;
//   final String website;
//   final String company;
//
//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.address,
//     required this.suite,
//     required this.city,
//     required this.zipcode,
//     required this.website,
//     required this.company,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       email: json['email'] as String,
//       phone: json['phone'] as String,
//       address: json['address']?['street'] ?? 'No street available',
//       suite: json['address']?['suite'] ?? 'No suite available',
//       city: json['address']?['city'] ?? 'No city available',
//       zipcode: json['address']?['zipcode'] ?? 'No zipcode available',
//       website: json['website'] as String,
//       company: json['company']['name'] as String,
//     );
//   }
// }
class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address; // Street
  final String city;
  final String website;
  final String company;
  final String suite;
  final String zipcode;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.website,
    required this.company,
    required this.suite,
    required this.zipcode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      // Default ID
      name: json['name'] ?? 'Unknown',
      // Default name
      email: json['email'] ?? 'No email',
      // Default email
      phone: json['phone'] ?? 'No phone',
      // Default phone
      address: json['address']?['street'] ?? 'No street',
      // Default address
      city: json['address']?['city'] ?? 'No city',
      // Default city
      website: json['website'] ?? 'No website',
      // Default website
      company: json['company']?['name'] ?? 'No company',
      // Default company
      zipcode: json['address']?['zipcode'] ?? 'No zipcode available',
      suite: json['address']?['suite'] ?? 'No suite available',
    );
  }
}
