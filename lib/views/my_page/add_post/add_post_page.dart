import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/common_widget/margin_box.dart';
import 'package:twitter/data_models/posts/posts.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/views/my_page/components/edit_button.dart';
import 'package:uuid/uuid.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});
  // final String userName;
  // String imageUrl;

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController postController = TextEditingController();
  // final TextEditingController profileController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;
  File? image;

  @override
  Widget build(BuildContext context) {
    // userNameController.text = widget.userName;

    Widget previewWidget;
    if (image != null) {
      previewWidget = Image.file(
        image!,
        height: 150,
        width: 150,
      );
    } else {
      previewWidget = Image.asset(
        "assets/images/image_photo.png",
        height: 150,
        width: 150,
      );
    }

    return Scaffold(
        appBar: AppBar(title: Text("投稿追加")),
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
                      if (image != null)
                        Positioned(
                          top: -20,
                          right: -20,
                          child: IconButton(
                              onPressed: () async {
                                image = null;
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
                MarginBox.bigWidthMargin,
                TextFormField(
                    controller: postController,
                    maxLines: 3,
                    maxLength: 100,
                    decoration: InputDecoration(label: Text("投稿文")),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "テキストを入力してください";
                      }
                      return null;
                    }),
                EditButton(
                  buttonText: "投稿!",
                  onEditButtonPressed: () async {
                    if (formKey.currentState!.validate() == false) {
                      //失敗したときに処理をストップ
                      return;
                    }
                    // final String uuid = const Uuid().v4();
                    // Todo addTodoData = Todo(
                    //     taskName: taskNameController.text,
                    //     userId: FirebaseAuth.instance.currentUser!.uid,
                    //     createdAt: Timestamp.now(),
                    //     updatedAt: Timestamp.now(),
                    //     todoId: uuid,
                    //     isCompleted: false);
                    final String uuid = const Uuid().v4();

                    //画像があるとき↓
                    if (image != null) {
                      final storedImage = await FirebaseStorage.instance
                          .ref("PostsIcon/${user!.uid}")
                          .putFile(image!);
                      final String imageUrl =
                          await storedImage.ref.getDownloadURL();

                      Posts newPost = Posts(
                          imageUrl: imageUrl,
                          postText: postController.text,
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          postId: uuid,
                          createdAt: Timestamp.now(),
                          updatedAt: Timestamp.now());
                      await FirebaseFirestore.instance
                          .collection("posts")
                          .doc(uuid)
                          .set(newPost.toJson());
                      showToast("投稿されました！");
                      postController.clear();
                      image = null;
                    } else {
                      Posts newPost = Posts(
                          imageUrl: "",
                          postText: postController.text,
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          postId: uuid,
                          createdAt: Timestamp.now(),
                          updatedAt: Timestamp.now());
                      await FirebaseFirestore.instance
                          .collection("posts")
                          .doc(uuid)
                          .set(newPost.toJson());
                      showToast("投稿されました！");
                      postController.clear();
                    }
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
