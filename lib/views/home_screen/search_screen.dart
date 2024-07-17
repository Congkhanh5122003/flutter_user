import 'package:baiflutter/consts/colors.dart';
import 'package:baiflutter/consts/consts.dart';
import 'package:baiflutter/services/firestore_services.dart';
import 'package:baiflutter/views/category_screen/item_details.dart';
import 'package:baiflutter/widget.common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.seachProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "Không tìm thấy sản phẩm".text.makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filtered = data.where(
              (element) => element['p_name']
                  .toString()
                  .toLowerCase()
                  .contains(title!.toLowerCase()),
            ).toList();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 300,
                ),
                children: filtered.mapIndexed(
                  (currentValue, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        filtered[index]['p_imgs'][0],
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      const Spacer(),
                      10.heightBox,
                      "${filtered[index]['p_name']}"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      "${filtered[index]['p_price']}"
                          .text
                          .fontFamily(bold)
                          .size(16)
                          .color(redColor)
                          .make(),
                      10.heightBox,
                    ],
                  ).box.white.shadowMd.margin(
                    const EdgeInsets.symmetric(horizontal: 4),
                  ).roundedSM.padding(const EdgeInsets.all(12)).make().onTap(() {
                    Get.to(
                      () => ItemDetails(
                        title: "${filtered[index]['p_name']}",
                        data: filtered[index],
                      ),
                    );
                  }),
                ).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
