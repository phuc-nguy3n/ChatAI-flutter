import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/repositories/firebase_repository.dart';
import 'package:flutter_application_1/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter_application_1/global/common/toast.dart';
import 'package:flutter_application_1/global/provider/user_provider.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isUpdating = false;

  final TextEditingController _userNameController = TextEditingController();
  final UserController _userController = Get.find<UserController>();
  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  @override
  void dispose() {
    _userNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Info User")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormContainerWidget(
              controller: _userNameController,
              hintText: "Username",
              isPasswordField: false,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _updateUserName();
              },
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: _isUpdating
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Update",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateUserName() async {
    String uid = _userController.user.value!.id;
    String username = _userNameController.text;

    if (username == '') {
      showToast(message: "Please enter your name");
    } else {
      setState(() {
        _isUpdating = true;
      });
      await _firebaseRepository.updateUserName(uid, username);
      setState(() {
        _isUpdating = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, "/home");
    }
  }
}
