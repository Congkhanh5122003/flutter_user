import 'package:baiflutter/consts/consts.dart';
import 'package:baiflutter/consts/list.dart';
import 'package:baiflutter/controllers/auth_controller.dart';
import 'package:baiflutter/views/home_screen/home.dart';
import 'package:baiflutter/widget.common/applogo.widget.dart';
import 'package:baiflutter/widget.common/custom_textfield.dart';
import 'package:baiflutter/widget.common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widget.common/bg_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool ? isCheck = false;
  var controller=Get.put(AuthController());

  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var passwordRetypeController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Signup to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Column(
                children: [
                  customTextField(hint: nameHint, title: name,controller: nameController,isPass:false),
                  customTextField(hint: emailHint, title: email,controller: emailController,isPass:false),
                  customTextField(hint: passwordHint, title: password,controller: passwordController,isPass:true),
                  customTextField(hint: passwordHint, title: retypePassword,controller: passwordRetypeController,isPass:true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgetPass.text.make(),
                    ),
                  ),
                  10.heightBox,
                  Row(
                    
                    children: [
                      Checkbox(
                        activeColor: redColor,
                        checkColor: whiteColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                          
                        },
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: termAndCond,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: redColor,
                                ),
                              ),
                              TextSpan(
                                text: " & ",
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: redColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.heightBox,
                  ourButton(
                    color: isCheck == true ? redColor : lightGrey,
                    title: signup,
                    textcolor: whiteColor,
                    onPress: () async{
                      if(isCheck!=false){
                        try{
                          await controller.signupMethod(context: context,email: emailController.text,password: passwordController.text).then((value){
                            return controller.storeUserData(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text
                            );
                          }).then((value){
                            VxToast.show(context, msg: loggedin);
                            Get.offAll(()=>const Home());
                          });



                        }catch(e){
                          auth.signOut();
                          VxToast.show(context, msg: e.toString());

                        }
                      }

                    },
                  ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: alreadyHaveAccount,
                            style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: login,
                            style: TextStyle(
                              fontFamily: bold,
                              color: redColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
            ],
          ),
        ),
      ),
    );
  }
}
