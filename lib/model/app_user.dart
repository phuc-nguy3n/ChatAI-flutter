import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String id;
  String email;
  String name;
  String createdAt;

  AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    Timestamp timestamp = json['created_at'] ?? Timestamp.now();
    String formattedDate =
        timestamp.toDate().toString(); // Định dạng lại nếu cần
    return AppUser(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      createdAt: formattedDate,
    );
  }
}
