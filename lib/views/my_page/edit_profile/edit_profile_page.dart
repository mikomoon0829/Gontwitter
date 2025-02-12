import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/common_widget/close_only_dialog.dart';
import 'package:twitter/common_widget/margin_box.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/views/my_page/components/edit_button.dart';

// ignore: must_be_immutable
class EditProfilePage extends StatefulWidget {
  EditProfilePage(
      {super.key,
      required this.userName,
      required this.imageUrl,
      required this.profile});
  final String userName;
  final String profile;
  String imageUrl;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController profileController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;
  File? image;

  @override
  Widget build(BuildContext context) {
    userNameController.text = widget.userName;
    profileController.text = widget.profile;

    Widget previewWidget;
    if (image != null) {
      previewWidget = CircleAvatar(
        backgroundImage: FileImage(image!),
        radius: 50,
      );
    } else if ((widget.imageUrl != "")) {
      previewWidget = CircleAvatar(
        backgroundImage: NetworkImage(widget.imageUrl),
        radius: 50,
      );
    } else {
      previewWidget = CircleAvatar(
        backgroundImage: const AssetImage("assets/images/image.png"),
        radius: 50,
      );
    }

    return Scaffold(
        appBar: AppBar(title: const Text("プロフィール変更")),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                      // alignment: Alignment(x, y),
                      children: [
                        previewWidget,
                        if (widget.imageUrl != "")
                          Positioned(
                            top: -20,
                            right: -20,
                            child: IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(user!.uid)
                                      .update({
                                    "imageUrl": "",
                                  });
                                  await FirebaseStorage.instance
                                      .ref("UsersIcon/${user!.uid}")
                                      .delete();
                                  widget.imageUrl = "";
                                  setState(() {});
                                },
                                icon: const Icon(Icons.close,
                                    size: 50, color: Colors.red)),
                          )
                      ]),
                  MarginBox.mediumHeightMargin,
                  EditButton(
                      buttonText: "画像を変更する",
                      onEditButtonPressed: () async {
                        // File? image;
                        // final picker =ImagePicker();
                        await getImageFromGallery();
                        try {
                          final storageRef = FirebaseStorage.instance
                              .ref("UsersIcon/${user!.uid}");
                          await storageRef.putFile(image!);

                          final String chooseImageUrl =
                              await storageRef.getDownloadURL();
                          // final storedImage = await FirebaseStorage.instance
                          //     .ref("UsersIcon/${user!.uid}")
                          //     .putFile(image!);
                          // final String imageUrl =
                          //     await storedImage.ref.getDownloadURL();
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(user!.uid)
                              .update({
                            "imageUrl": chooseImageUrl,
                            // "userName": userNameController.text,
                            // "profile": profileController.text,
                            "updatedAt": Timestamp.now()
                          });
                          showToast("画像を変更しました！");
                          image = null;
                          widget.imageUrl = chooseImageUrl;
                          setState(() {});
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          showCloseOnlyDialog(context, "失敗", "画像変更に失敗しました");
                        }
                      }),
                  MarginBox.bigWidthMargin,
                  TextFormField(
                      controller: userNameController,
                      maxLength: 12,
                      decoration: const InputDecoration(label: Text("ユーザーネーム")),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "テキストを入力してください";
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: profileController,
                      maxLines: 3,
                      decoration: InputDecoration(label: Text("自己紹介文")),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "テキストを入力してください";
                        }
                        return null;
                      }),
                  EditButton(
                    buttonText: "プロフィールを変更する",
                    onEditButtonPressed: () async {
                      if (formKey.currentState!.validate() == false) {
                        //失敗したときに処理をストップ
                        return;
                      }
                      try {
                        // //画像があるとき↓
                        // if (image != null) {
                        //   final storageRef = FirebaseStorage.instance
                        //       .ref("UsersIcon/${user!.uid}");
                        //   await storageRef.putFile(image!);

                        //   final String imageUrl =
                        //       await storageRef.getDownloadURL();
                        //   // final storedImage = await FirebaseStorage.instance
                        //   //     .ref("UsersIcon/${user!.uid}")
                        //   //     .putFile(image!);
                        //   // final String imageUrl =
                        //   //     await storedImage.ref.getDownloadURL();
                        //   await FirebaseFirestore.instance
                        //       .collection("users")
                        //       .doc(user!.uid)
                        //       .update({
                        //     "imageUrl": imageUrl,
                        //     "userName": userNameController.text,
                        //     "profile": profileController.text,
                        //     "updatedAt": Timestamp.now()
                        //   });
                        // } else {
                        FocusScope.of(context).unfocus();
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(user!.uid)
                            .update({
                          "userName": userNameController.text,
                          "profile": profileController.text,
                          "updatedAt": Timestamp.now()
                        });
                        // }
                        showToast("変更成功しました");
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        showCloseOnlyDialog(context, "変更失敗", "予期せぬエラーです");
                        // print(e.toString());
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        // print(image);
        // print(user!.uid);
      }
    });
  }
}
