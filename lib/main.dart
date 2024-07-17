import 'package:baiflutter/consts/colors.dart';
import 'package:baiflutter/views/auth_screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:baiflutter/views/splash_screen/splash_screen.dart';
import 'package:baiflutter/views/auth_screen/login_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "G-LAB",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: darkFontGrey,
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent),
        fontFamily: 'sans_regular', // sử dụng font sans_regular mặc định

      ),
      home: const SplashScreen(
        
      ),
    );
  }
}
