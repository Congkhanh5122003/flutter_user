import 'package:baiflutter/consts/consts.dart';
import 'package:baiflutter/services/firestore_services.dart';
import 'package:baiflutter/views/chat_screen/chat_screen.dart';
import 'package:baiflutter/widget.common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Tin nhắn".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        
        
        stream: FirestoreServices.getAllMessages(),
        
         builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );

          }else if(snapshot.data!.docs.isEmpty){
            return "Không có tin nhắn!".text.color(darkFontGrey).makeCentered();
          }else{
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: ListView.builder(
                    itemCount: data.length,
                    
                    itemBuilder: (BuildContext context, int index)
                    {
                      return Card(
                        child: ListTile(
                          onTap: (){
                            Get.to(()=>const ChatScreen(),
                             arguments:[
                             data[index]['friend_name'],
                             data[index]['toId'],
                             ]
                             
                             
                             );
                          },
                          leading: const CircleAvatar(backgroundColor: redColor,
                          child: Icon(Icons.person,
                          color: whiteColor
                          ,)
                          ),
                          title: "${data[index]['friend_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                          subtitle: "${data[index]['last_msg']}".text.make(),
                        ),
                      );
              
                    })
                    )
                ],
              ),
            );
          }
         }),
    );
  }
}