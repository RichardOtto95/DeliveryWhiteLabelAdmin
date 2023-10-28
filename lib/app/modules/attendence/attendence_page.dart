import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_admin_white_label/app/modules/messages/widgets/message.dart';
import 'package:delivery_admin_white_label/app/shared/responsive.dart';
import 'package:delivery_admin_white_label/app/shared/utilities.dart';
import 'package:delivery_admin_white_label/app/shared/widgets/default_app_bar.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:delivery_admin_white_label/app/modules/attendence/attendence_store.dart';
import 'package:flutter/material.dart';

import '../../core/models/message_model.dart';
import '../messages/widgets/message_bar.dart';

class AttendencePage extends StatefulWidget {
  final String title;
  const AttendencePage({Key? key, this.title = 'AttendencePage'})
      : super(key: key);
  @override
  AttendencePageState createState() => AttendencePageState();
}

class AttendencePageState extends State<AttendencePage> {
  final AttendenceStore store = Modular.get();

  final TextEditingController textController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Message> messages = [
      Message(
        author: "1",
        text: "text",
        createdAt: Timestamp.now(),
        file: null,
        fileType: null,
        id: "1",
        title: "title",
        userType: "customer",
      ),
      Message(
        author: "2",
        text: "text",
        createdAt: Timestamp.now(),
        file: null,
        fileType: null,
        id: "2",
        title: "title",
        userType: "customer",
      ),
      Message(
        author: "1",
        text: "text",
        createdAt: Timestamp.now(),
        file: null,
        fileType: null,
        id: "3",
        title: "title",
        userType: "customer",
      ),
      Message(
        author: "1",
        text: "text",
        createdAt: Timestamp.now(),
        file: null,
        fileType: null,
        id: "4",
        title: "title",
        userType: "customer",
      ),
      Message(
        author: "1",
        text: "text",
        createdAt: Timestamp.now(),
        file: null,
        fileType: null,
        id: "5",
        title: "title",
        userType: "customer",
      ),
      Message(
        author: "1",
        text: "text",
        createdAt: Timestamp.now(),
        file: null,
        fileType: null,
        id: "6",
        title: "title",
        userType: "customer",
      ),
      Message(
        author: "1",
        text: "text",
        createdAt: Timestamp.now(),
        file: null,
        fileType: null,
        id: "7",
        title: "title",
        userType: "customer",
      ),
      Message(
        author: "1",
        text: "text",
        createdAt: Timestamp.now(),
        file: null,
        fileType: null,
        id: "8",
        title: "title",
        userType: "customer",
      ),
      Message(
        author: "2",
        text: "text",
        createdAt: Timestamp.now(),
        file: null,
        fileType: null,
        id: "9",
        title: "title",
        userType: "customer",
      ),
      Message(
        author: "2",
        text: "text",
        createdAt: Timestamp.now(),
        file: null,
        fileType: null,
        id: "10",
        title: "title",
        userType: "customer",
      ),
      Message(
        author: "2",
        text: "text",
        createdAt: Timestamp.now(),
        file:
            "https://firebasestorage.googleapis.com/v0/b/white-label-cca4f.appspot.com/o/customers%2F7iMikvbeFScCAwl8FzigdYGWwrN2%2Favatar%2FFile%3A%20'%2Fdata%2Fuser%2F0%2Fcom.br.delivery.customer.white.label%2Fcache%2Fimage_picker2013266121270424268.jpg'?alt=media&token=43c79cd2-0fa5-410e-9558-c75ef5f3ba6e",
        fileType: ".jpg",
        id: "11",
        title: "title",
        userType: "customer",
      ),
    ];
    return Stack(
      children: [
        Responsive(
          mobile: Container(),
          desktop: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Row(
              children: [
                SizedBox(
                  width: maxWidth(context) / 4,
                  height: maxHeight(context),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ChatTile(),
                        ChatTile(),
                        ChatTile(),
                        ChatTile(),
                        ChatTile(),
                        ChatTile(),
                        ChatTile(),
                        ChatTile(),
                        ChatTile(),
                        ChatTile(),
                        ChatTile(),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              color: getColors(context).onBackground))),
                  width: maxWidth(context) * 3 / 4,
                  height: maxHeight(context),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 70),
                        reverse: true,
                        child: Column(
                          children: List.generate(
                            messages.length,
                            (index) {
                              Message message = messages[index];

                              return MessageWidget(
                                isAuthor: message.author == "1",
                                leftName: "Fulano de tal",
                                messageData: message,
                                rightName: "Ciclano de tal",
                                messageBold: false,
                                showUserData:
                                    message.id == "1" || message.id == '2',
                                leftAvatar:
                                    "https://firebasestorage.googleapis.com/v0/b/white-label-cca4f.appspot.com/o/customers%2F7iMikvbeFScCAwl8FzigdYGWwrN2%2Favatar%2FFile%3A%20'%2Fdata%2Fuser%2F0%2Fcom.br.delivery.customer.white.label%2Fcache%2Fimage_picker2013266121270424268.jpg'?alt=media&token=43c79cd2-0fa5-410e-9558-c75ef5f3ba6e",
                                rightAvatar:
                                    "https://firebasestorage.googleapis.com/v0/b/white-label-cca4f.appspot.com/o/customers%2F7iMikvbeFScCAwl8FzigdYGWwrN2%2Favatar%2FFile%3A%20'%2Fdata%2Fuser%2F0%2Fcom.br.delivery.customer.white.label%2Fcache%2Fimage_picker2013266121270424268.jpg'?alt=media&token=43c79cd2-0fa5-410e-9558-c75ef5f3ba6e",
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: MessageBar(
                          controller: textController,
                          focus: focusNode,
                          // onChanged: (val) => store.text = val,
                          onEditingComplete: () {},
                          onSend: () {},
                          takePictures: () async {
                            // List<XFile> xImages =
                            //     await ImagePicker().pickMultiImage() ?? [];

                            // List<File> images = [];
                            // List<Uint8List> imagesView = [];

                            // for (XFile _xFile in xImages) {
                            //   imagesView.add(await _xFile.readAsBytes());
                            //   images.add(File(_xFile.path));
                            // }

                            // store.images = images.asObservable();
                            // store.imagesView = imagesView.asObservable();
                            // store.imagesBool = images.isNotEmpty;
                          },
                          getCameraImage: () async {
                            // store.cameraImage = await pickCameraImage();
                            // store.sendImage(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        DefaultAppBar("Atendimento", main: true),
      ],
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        children: [
          SizedBox(
            height: 55,
            width: 55,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(90000)),
              child: Container(
                height: 55,
                width: 55,
                color: Colors.pink,
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: wXD(
                      300,
                      context,
                      ws: 300,
                      mediaWeb: true,
                    ),
                    child: Text(
                      "Fulano de tal",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textFamily(
                        context,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  // Spacer(),
                  Container(
                    alignment: Alignment.centerRight,
                    width: wXD(55, context),
                    child: Text(
                      "15:40",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textFamily(
                        context,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                children: [
                  SizedBox(
                    width: wXD(
                      300,
                      context,
                      ws: 320,
                      mediaWeb: true,
                    ),
                    child: Text(
                      "última mensagem",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textFamily(
                        context,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    height: wXD(20, context),
                    width: wXD(20, context),
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getColors(context).primary,
                    ),
                    child: Text(
                      "7",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textFamily(
                        context,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
