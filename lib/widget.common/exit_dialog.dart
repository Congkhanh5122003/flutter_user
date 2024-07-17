import 'package:baiflutter/consts/consts.dart';

import 'package:baiflutter/widget.common/our_button.dart';
import 'package:flutter/services.dart';


Widget exitDialog(context){
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12)
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Chấp Nhận".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Bạn có chắc chắn muốn thoát" .text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
              color: redColor,
              onPress: (){
                SystemNavigator.pop();
              },
              textcolor: whiteColor,
              title: "Đồng ý"
            ),
            ourButton(
              color: redColor,
              onPress: (){
                Navigator.pop(context);
              },
              textcolor: whiteColor,
              title: "Không đồng ý"
            ),
          ],
        )

      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );

}