//ユーザ情報をマイページから持ってくるんじゃなくて、
//bodyのほぼ最初にwhenで自分のアカウント内容をとってきた方が、
//自分のアカウントのUserData型であるmyUserDataも取得できてやりやすい

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/common_widget/close_only_dialog.dart';
import 'package:twitter/config/utils/margin/margin_box.dart';
import 'package:twitter/data_models/user_data/userdata.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/repo/storage/storage_repo.dart';
import 'package:twitter/repo/user/user_repo.dart';
import 'package:twitter/views/enum/folder_enum.dart';
import 'package:twitter/views/my_page/components/edit_button.dart';

class EditProfilePage extends HookConsumerWidget {
  // final String userName;

  // final String imageUrl;

  // final String profile;

  EditProfilePage({
    super.key,
    // required this.userName,
    // required this.imageUrl,
    // required this.profile
  });
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController userNameController = useTextEditingController();
    final TextEditingController profileController = useTextEditingController();

    // File? image;
    // useState を使って `image` を管理
    final imageState = useState<File?>(null);

    Future getImageFromGallery() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageState.value = File(pickedFile.path);
        // print(image);
        // print(user!.uid);
      }
      // setState(() {
      //   if (pickedFile != null) {
      //     image = File(pickedFile.path);
      //     // print(image);
      //     // print(user!.uid);
      //   }
      // });
    }

    // Widget previewWidget;
    //   if (image != null) {
    //     previewWidget = CircleAvatar(
    //       backgroundImage: FileImage(image!),
    //       radius: 50,
    //     );
    //   } else if ((widget.imageUrl != "")) {
    //     previewWidget = CircleAvatar(
    //       backgroundImage: NetworkImage(widget.imageUrl),
    //       radius: 50,
    //     );
    //   } else {
    //     previewWidget = CircleAvatar(
    //       backgroundImage: const AssetImage("assets/images/image.png"),
    //       radius: 50,
    //     );
    //   }

    return GestureDetector(
      //他のとこタップでunfocusのためにすること二点！
      //①ScaffoldをGestureDetectorで囲む
      //②このふたつのプロパティ入れる
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(title: const Text("プロフィール変更")),
          body: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: ref.watch(myUserStreamProvider).when(
                    data: (UserData myUserData) {
                  userNameController.text = myUserData.userName;
                  profileController.text = myUserData.profile;

                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                            // alignment: Alignment(x, y),
                            children: [
                              (imageState.value != null)
                                  ? CircleAvatar(
                                      backgroundImage:
                                          FileImage(imageState.value!),
                                      radius: 50,
                                    )
                                  : (myUserData.imageUrl != "")
                                      ?
                                      //imageUrlのアイコン
                                      CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(myUserData.imageUrl),
                                          radius: 50,
                                        )

                                      //デフォルトアイコン
                                      : CircleAvatar(
                                          backgroundImage: const AssetImage(
                                              "assets/images/image.png"),
                                          radius: 50,
                                        ),
                              if (myUserData.imageUrl != "")
                                Positioned(
                                  top: -20,
                                  right: -20,
                                  child: IconButton(
                                      onPressed: () async {
                                        //バツボタン押すとアイコン削除処理
                                        //firestore上書き処理
                                        UserData updateAccount =
                                            myUserData.copyWith(
                                                imageUrl: "",
                                                updatedAt: Timestamp.now());
                                        ref
                                            .read(userRepoProvider.notifier)
                                            .updateUser(updateAccount);
                                        //storage削除処理
                                        await ref
                                            .read(storageRepoProvider.notifier)
                                            .deleteImage(myUserData.userId);
                                        // await FirebaseStorage.instance
                                        //     .ref("UsersIcon/${user!.uid}")
                                        //     .delete();
                                        // myUserData.imageUrl = "";
                                        // setState(() {});
                                      },
                                      icon: const Icon(Icons.close,
                                          size: 50, color: Colors.red)),
                                )
                            ]),
                        MarginBox.mediumHeightMargin,
                        EditButton(
                            buttonText: "画像を変更する",
                            onEditButtonPressed: () async {
                              await getImageFromGallery();
                              // if (imageState.value != null) {
                              //   print("image選択はできてる");
                              // }
                              try {
                                //ストレージにあげる処理を行い、そのURLを取得
                                String downloadImageUrl = await ref
                                    .read(storageRepoProvider.notifier)
                                    .uploadImageAndGetUrl(
                                        ImageFolder.usersIcon.name,
                                        myUserData.userId,
                                        imageState.value!);

                                //ストレージにあげる
                                // final storageRef = FirebaseStorage.instance
                                //     .ref("UsersIcon/${user!.uid}");
                                // final storageRef=ref.read(storageRepoProvider.notifier).uploadImageAndGetUrl(userId, uint8list);
                                // await storageRef.putFile(image!);

                                // final String chooseImageUrl =
                                //     await storageRef.getDownloadURL();
                                // final storedImage = await FirebaseStorage.instance
                                //     .ref("UsersIcon/${user!.uid}")
                                //     .putFile(image!);
                                // final String imageUrl =
                                //     await storedImage.ref.getDownloadURL();
                                UserData updateAccount = myUserData.copyWith(
                                    imageUrl: downloadImageUrl,
                                    updatedAt: Timestamp.now());
                                ref
                                    .read(userRepoProvider.notifier)
                                    .updateUser(updateAccount);
                                // await FirebaseFirestore.instance
                                //     .collection("users")
                                //     .doc(user!.uid)
                                //     .update({
                                //   "imageUrl": chooseImageUrl,
                                //   // "userName": userNameController.text,
                                //   // "profile": profileController.text,
                                //   "updatedAt": Timestamp.now()
                                // });
                                showToast("画像を変更しました！");
                                imageState.value = null;
                                // widget.imageUrl = chooseImageUrl;
                                // setState(() {});
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                // print(e);
                                if (context.mounted) {
                                  showCloseOnlyDialog(
                                      context, "失敗", "画像変更に失敗しました");
                                }
                              }
                            }),
                        MarginBox.bigWidthMargin,
                        TextFormField(
                            controller: userNameController,
                            maxLength: 12,
                            decoration:
                                const InputDecoration(label: Text("ユーザーネーム")),
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
                              UserData updateUser = myUserData.copyWith(
                                  userName: userNameController.text,
                                  profile: profileController.text,
                                  updatedAt: Timestamp.now());
                              ref
                                  .read(userRepoProvider.notifier)
                                  .updateUser(updateUser);
                              // await FirebaseFirestore.instance
                              //     .collection("users")
                              //     .doc(user!.uid)
                              //     .update({
                              //   "userName": userNameController.text,
                              //   "profile": profileController.text,
                              //   "updatedAt": Timestamp.now()
                              // });
                              // }
                              showToast("変更成功しました");
                              //ボタン押したらフォーカス外れてキーボード消える＆その後TextFormをタップするとフォーカスできる！
                              FocusManager.instance.primaryFocus?.unfocus();

                              // context.goNamed(AppRoute.mypage.name);
                            } catch (e) {
                              // ignore: use_build_context_synchronously
                              showCloseOnlyDialog(context, "変更失敗", "予期せぬエラーです");
                              // print(e.toString());
                            }
                          },
                        )
                      ],
                    ),
                  );
                }, error: (error, stackTrace) {
                  return Text("エラーです");
                }, loading: () {
                  return Text("読み込み中");
                })),
          )),
    );
  }
}
