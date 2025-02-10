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
      required String profile});
  final String userName;
  String imageUrl;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController profileTextController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;
  File? image;

  @override
  Widget build(BuildContext context) {
    userNameController.text = widget.userName;

    Widget previewWidget;
    if (image != null) {
      previewWidget = CircleAvatar(
        backgroundImage: FileImage(image!),
        radius: 75,
      );
    } else if ((widget.imageUrl != "")) {
      previewWidget = CircleAvatar(
        backgroundImage: NetworkImage(widget.imageUrl),
        radius: 75,
      );
    } else {
      previewWidget = CircleAvatar(
        backgroundImage: AssetImage("assets/images/image.png"),
        radius: 75,
      );
    }

    return Scaffold(
        appBar: AppBar(title: Text("プロフィール変更")),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                              icon: Icon(Icons.close,
                                  size: 50, color: Colors.red)),
                        )
                    ]),
                MarginBox.mediumHeightMargin,
                EditButton(
                    buttonText: "画像を選択する",
                    onEditButtonPressed: () {
                      // File? image;
                      // final picker =ImagePicker();
                      getImageFromGallery();
                    }),
                // MarginBox.mediumHeightMargin,
                EditButton(
                    buttonText: "画像アップロード",
                    onEditButtonPressed: () async {
                      if (image == null) {
                        showToast("画像が選択されていません");
                      }
                      try {
                        final storedImage = await FirebaseStorage.instance
                            .ref("UsersIcon/${user!.uid}")
                            .putFile(image!);
                        final String imageUrl =
                            await storedImage.ref.getDownloadURL();
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(user!.uid)
                            .update({
                          "imageUrl": imageUrl,
                          "updatedAt": Timestamp.now()
                        });

                        showToast("画像アップロードが成功したよ");
                      } catch (e) {
                        showCloseOnlyDialog(
                            // ignore: use_build_context_synchronously
                            context,
                            "画像アップロード失敗",
                            e.toString());
                        print(e);
                      }
                    }),
                MarginBox.bigWidthMargin,
                TextFormField(
                    controller: userNameController,
                    maxLength: 12,
                    decoration: InputDecoration(label: Text("ユーザーネーム")),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }
                      return null;
                    }),
                TextFormField(
                    controller: profileTextController,
                    maxLines: 3,
                    decoration: InputDecoration(label: Text("自己紹介文")),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
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
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(user!.uid)
                        .update({
                      "userName": userNameController.text,
                      "updatedAt": Timestamp.now()
                    });

                    showToast("変更成功しました");
                  },
                )
              ],
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
        print(image);
        print(user!.uid);
      }
    });
  }
}
