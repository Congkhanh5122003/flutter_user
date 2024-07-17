import 'package:baiflutter/consts/consts.dart';
import 'package:baiflutter/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart'; // Import velocity_x package
import 'package:baiflutter/consts/colors.dart'; // Import đúng file chứa redColor
import '../../widget.common/applogo.widget.dart';
import '../auth_screen/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 changeScreen(){
  Future.delayed(const Duration(seconds: 3),(){
    //Get.to(()=>const LoginScreen());

auth.authStateChanges().listen((User?user){
if(user==null && mounted){
  Get.to(()=>const LoginScreen());
}else{
  Get.to(()=>const Home());
}
});
  });
}
@override
 void initState(){
   changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            20.heightBox,
            applogoWidget(), 

            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),

          ],
        ),
      ),
    );
  }
}
