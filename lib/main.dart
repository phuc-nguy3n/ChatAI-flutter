import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/app/splash_screen/splash_screen.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/home_page.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/setting_page.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/user_info_page.dart';
import 'global/provider/user_provider.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAtpoCFbbwV0G_D5sDohYpPer52hGj_ToU",
        appId: "1:640126062967:web:8756d5f8d5a1db336f5172",
        messagingSenderId: "640126062967",
        projectId: "chatai-32cb0",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/': (context) => const SplashScreen(
              // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
              child: LoginPage(),
            ),
        '/login': (context) => const LoginPage(),
        '/signUp': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/setting': (context) => const SettingPage(),
        '/userInfo': (context) => const UserInfoPage(),
      },
    );
  }
}
