import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter_application_1/global/common/toast.dart';
import 'package:flutter_application_1/global/provider/user_provider.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HomePage")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Welcome Home!",
                style: TextStyle(fontWeight: FontWeight.bold)),
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
