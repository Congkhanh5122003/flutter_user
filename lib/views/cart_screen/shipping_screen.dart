import 'package:baiflutter/consts/consts.dart';
import 'package:baiflutter/controllers/cart_controller.dart';
import 'package:baiflutter/views/cart_screen/payment_method.dart';
import 'package:baiflutter/widget.common/custom_textfield.dart';
import 'package:baiflutter/widget.common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {

    var controller=Get.find<CartController>();



    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Thông tin giao hàng".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),

      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          
        
          onPress: (){
            if(controller.addressController.text.length>10)
            {
              Get.to(()=>const PaymentMethod());


            }
            {

              VxToast.show(context, msg: "Điền thông tin");
            }
          },
          color: redColor,
          textcolor: whiteColor,
          title: "Tiếp tục"
        
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(hint: "Địa chỉ",isPass: false,title: "Địa chỉ",controller: controller.addressController),
            customTextField(hint: "Thành Phố",isPass: false,title: "Thành Phố",controller: controller.cityController),
            customTextField(hint: "Quận",isPass: false,title: "Quận",controller: controller.stateController),
            customTextField(hint: "Số điện thoại",isPass: false,title: "Số điện thoại",controller: controller.phoneController),
            
        
          
          ],
        
          
          ),
      ),
    );
  }
}