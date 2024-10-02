import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter_application_1/global/common/toast.dart';
import 'package:flutter_application_1/global/provider/user_provider.dart';
import 'package:get/get.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final UserController _userController = Get.find<UserController>();

  String? userName;

  @override
  void initState() {
    super.initState();

    if (_userController.user.value != null) {
      userName = _userController.user.value!.name;
    } else {
      userName = 'user';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Info")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Username: $userName",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              _auth.signOut();
              _userController.setUser(null);
              Navigator.pushReplacementNamed(context, "/login");
              showToast(message: "Successfully signed out");
            },
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  "Sign out",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
