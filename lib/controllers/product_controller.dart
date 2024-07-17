import 'package:baiflutter/consts/consts.dart';
import 'package:baiflutter/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  var quantity=0.obs;
  var colorIndex=0.obs;
  var totalPrice=0.obs;

var isFav=false.obs;


  var subcat = [];

  getSubCategories(String title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s = decoded.categories.where((element) => element.name == title).toList();

    // Gỡ lỗi: In ra các danh mục và tiêu đề
    print("Categories: ${decoded.categories.map((e) => e.name).toList()}");
    print("Title: $title");
    
    if (s.isNotEmpty) {
      for (var e in s[0].subcategory) {
        subcat.add(e);
      }
    } else {
      // Xử lý trường hợp không tìm thấy danh mục khớp
      print("No matching category found for title: $title");
    }
  }

  changeColorIndex(index){
    colorIndex  =  index;
  }

  IncreaseQuantity(totalQuantity){
    if(quantity.value<totalQuantity){
    quantity.value++;
    }
  }
  decreaseQuantity(){
    if(quantity.value>0){
    quantity.value--;
    }
  }

  calculateTotalPrice(price){
    totalPrice.value = price*quantity.value;
  }

  addToCart({
    title,img,sellername,color,qty,tprice,context,vendorID
  })async{
    await firestore.collection(cartCollection).doc().set({
      'title':title,
      'img':img,
      'sellername':sellername,
      'vendor_id':vendorID,
      'color':color,
      'qty':qty,
      'tprice':tprice,
      'added_by':currentUser!.uid

    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });

  }
  resetValues(){
    totalPrice.value=0;
    quantity.value=0;
    colorIndex.value=0;

  }


  addToWistlist(docId,context) async{
    await firestore.collection(productsCollection).doc(docId).set({

      'p_wishlist':FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Yêu thích thành công");
  }

 removeToWistlist(docId,context) async{
    await firestore.collection(productsCollection).doc(docId).set({

      'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));

    isFav(false);

    VxToast.show(context, msg: "Hủy yêu thích");
  }


  checkIfFav(data)async{
    if (data['p_wishlist'].contains(currentUser!.uid)){

      isFav(true);

    }else{
      isFav(false);
    }
  }


 
}
