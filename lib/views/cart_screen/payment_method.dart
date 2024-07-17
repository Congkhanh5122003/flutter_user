import 'package:baiflutter/consts/consts.dart';
import 'package:baiflutter/consts/list.dart';
import 'package:baiflutter/controllers/cart_controller.dart';
import 'package:baiflutter/views/home_screen/home.dart';
import 'package:baiflutter/widget.common/loading_indicator.dart';
import 'package:baiflutter/widget.common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart'; 

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(() => Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: controller.placingOrder.value ? Center(
          child: loadingIndicator(),
        ) : ourButton(
          onPress: ()async {
           await controller.placeMyOrder(
              orderPaymentMethod: paymentMethod[controller.paymentIndex.value],
              totalAmount: controller.totalP.value,
              
            );
            await controller.clearCart();
            VxToast.show(context, msg: "Đặt hàng thành công");
            Get.offAll(const Home());

          },
          color: redColor,
          textcolor: whiteColor,
          title: "Đặt hàng",
        ),
      ),
      appBar: AppBar(
        title: "Phương thức thanh toán".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(() => Column(
          children: List.generate(paymentMethodImg.length, (index) {
            return GestureDetector(
              onTap: () {
                controller.changePaymentIndex(index);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: controller.paymentIndex.value == index ? redColor : Colors.transparent,
                    width: 5,
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 12.0),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(
                      paymentMethodImg[index],
                      width: double.infinity,
                      height: 120,
                      colorBlendMode: controller.paymentIndex.value == index ? BlendMode.darken : BlendMode.color,
                      color: controller.paymentIndex.value == index ? Colors.black.withOpacity(0.4) : Colors.transparent,
                      fit: BoxFit.cover,
                    ),
                    controller.paymentIndex.value == index ? Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        activeColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        value: true,
                        onChanged: (value) {},
                      ),
                    ) : Container(),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: paymentMethod[index].text.white.fontFamily(semibold).size(16).make(),
                    ),
                  ],
                ),
              ),
            );
          }),
        )),
      ),
    ));
  }
}
