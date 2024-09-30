import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/global/provider/user_provider.dart';
import 'package:flutter_application_1/model/app_user.dart';
import 'package:get/get.dart';

class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController userController = Get.find<UserController>();

  // Phương thức để tạo người dùng mới
  Future<void> createUser(String id, String email) async {
    try {
      await _firestore.collection('users').doc(id).set({
        'id': id,
        'email': email,
        'created_at': FieldValue.serverTimestamp(),
        'name': ''
      });
      print('User created successfully');
    } catch (e) {
      print('Failed to create user: $e');
      throw Exception('Failed to create user');
    }
  }

  Future<void> updateUserName(String id, String newName) async {
    try {
      await _firestore.collection('users').doc(id).update({
        'name': newName,
      });

      print('User name updated successfully.');
    } catch (e) {
      print('Error updating name: $e');
      throw Exception('Error updating name: $e');
    }
  }

  Future<AppUser?> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(id).get();

      if (snapshot.exists) {
        return AppUser.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        print('User not found');
        return null; // Người dùng không tồn tại
      }
    } catch (e) {
      print('Error getting user: $e');
      throw Exception('Error getting user: $e');
    }
  }
}
