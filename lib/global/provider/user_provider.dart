import 'package:flutter_application_1/model/app_user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var user = Rxn<AppUser>(); //

  void setUser(AppUser? newUser) {
    user.value = newUser;
  }

  void updateUsername(String newName) {
    if (user.value != null) {
      user.value!.name = newName;
      user.refresh();
    }
  }

  bool isLoggedIn() {
    return user.value != null;
  }
}
