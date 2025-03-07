//ユーザ情報をマイページから持ってくるんじゃなくて、
//bodyのほぼ最初にwhenで自分のアカウント内容をとってきた方が、
//自分のアカウントのUserData型であるmyUserDataも取得できてやりやすい

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:twitter/common_widget/close_only_dialog.dart';
import 'package:twitter/config/utils/style/color/color_style.dart';
import 'package:twitter/config/utils/style/margin/margin_box.dart';
import 'package:twitter/data_models/user_data/user_data.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/repo/auth/auth_repo.dart';
import 'package:twitter/repo/storage/storage_repo.dart';
import 'package:twitter/repo/user/user_repo.dart';
import 'package:twitter/config/utils/enum/folder_enum.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController userNameController = useTextEditingController();
    final TextEditingController profileController = useTextEditingController();

    // File? image;
    // useState を使って `image` を管理
    final ValueNotifier<File?> imageState = useState(null);
    final ValueNotifier<UserData?> myUserData = useState(null);
    final ValueNotifier<bool> isLoading = useState(false);

    useEffect(() {
      //普通useEffectの中は画面描画の部分(Scaffoldの中)より先に走る
      //ただ、useStateの中でFutureでかこったものは非同期処理となるので、先に他の部分に処理を譲ってしまう
      //つまり今回だとFutureの中より先に、つまりisLoadingがtrueにもなっていないのにScaffold部分が走ってしまって
      //Paddingが描画されmyUserData！ってしてるけどmyUserDataがnullだよーーってなってた
      //よって、Futureの前でisLoadingをtrueにする！
      isLoading.value = true;
      Future(() async {
        myUserData.value = await ref
            .read(userRepoProvider.notifier)
            .getUser(ref.read(authRepoProvider)!.uid);

        //ページ遷移した瞬間のみはデータベースからとってきた情報を代入する
        userNameController.text = myUserData.value!.userName;
        profileController.text = myUserData.value!.profile;
        //imageUrlからPreviewに入るFile?のimageに変換
        if (myUserData.value!.imageUrl != '') {
          print(myUserData.value!.imageUrl);
          imageState.value = await urlToFile(myUserData.value!.imageUrl);
          print('⭐️');
          print(myUserData.value!.imageUrl);
        }

        isLoading.value = false;
        return null;
      });

      // return null;
    }, []);

    // Future getImageFromGallery() async {
    //   final ImagePicker picker = ImagePicker();
    //   final XFile? pickedFile =
    //       await picker.pickImage(source: ImageSource.gallery);
    //   if (pickedFile != null) {
    //     imageState.value = File(pickedFile.path);
    //     // print(image);
    //     // print(user!.uid);
    //   }
    //   // setState(() {
    //   //   if (pickedFile != null) {
    //   //     image = File(pickedFile.path);
    //   //     // print(image);
    //   //     // print(user!.uid);
    //   //   }
    //   // });
    // }

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
      //他のとこタップでunfocusのためにすること3点！
      //①ScaffoldをGestureDetectorで囲む
      //②このふたつのプロパティ入れる
      //③テキストを送信する関数の最後にFocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('プロフィール変更'),
          leading: IconButton(
            onPressed: () {
              imageState.value = null;
              context.pop();
            },
            icon: Icon(Icons.abc_outlined),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: (isLoading.value)
                ? Center(
                    child: Center(child: const CircularProgressIndicator()),
                  )
                : Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          // alignment: Alignment(x, y),
                          children: [
                            (imageState.value != null)
                                ? SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: ClipOval(
                                      child: Image.file(imageState.value!),
                                    ),
                                  )
                                // ? CircleAvatar(
                                //     backgroundImage:
                                //         FileImage(imageState.value!),
                                //     radius: 50,
                                //   )
                                // (myUserData.value!.imageUrl != '')
                                //     ?
                                //     //imageUrlのアイコン
                                //     SizedBox(
                                //         height: 100,
                                //         width: 100,
                                //         child: ClipOval(
                                //           child: CachedNetworkImage(
                                //               imageUrl: myUserData
                                //                   .value!.imageUrl),
                                //         ),
                                //       )
                                : SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/image.png',
                                      ),
                                    ),
                                  ),
                            if (imageState.value != null)
                              Positioned(
                                top: -20,
                                right: -20,
                                child: IconButton(
                                  onPressed: () async {
                                    //バツボタン押すとアイコン削除処理
                                    //firestore上書き処理
                                    // UserData updateAccount =
                                    //     myUserData.value!.copyWith(
                                    //   imageUrl: '',
                                    //   updatedAt: Timestamp.now(),
                                    // );
                                    // await ref
                                    //     .read(userRepoProvider.notifier)
                                    //     .updateUser(updateAccount);
                                    // //storage削除処理
                                    // await ref
                                    //     .read(storageRepoProvider.notifier)
                                    //     .deleteImage(
                                    //         myUserData.value!.userId);
                                    // await FirebaseStorage.instance
                                    //     .ref("UsersIcon/${user!.uid}")
                                    //     .delete();
                                    // myUserData.imageUrl = "";
                                    // setState(() {});
                                    imageState.value = null;
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 50,
                                    color: ColorStyle.red,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        MarginBox.mediumHeightMargin,
                        EditButton(
                          buttonText: '画像を選択する',
                          onEditButtonPressed: () async {
                            await _getImageFromGallery(
                              imageState: imageState,
                            );
                            // await _changeImage(
                            //     // getImageFromGallery,
                            //     ref: ref,
                            //     myUserData: myUserData,
                            //     imageState: imageState,
                            //     context: context);
                          },
                        ),
                        MarginBox.bigWidthMargin,
                        TextFormField(
                          controller: userNameController,
                          maxLength: 12,
                          decoration: const InputDecoration(
                            label: Text('ユーザーネーム'),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'テキストを入力してください';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: profileController,
                          maxLines: 3,
                          decoration: InputDecoration(label: Text('自己紹介文')),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'テキストを入力してください';
                            }
                            return null;
                          },
                        ),
                        MarginBox.smallHeightMargin,
                        EditButton(
                          buttonText: 'プロフィールを変更する',
                          onEditButtonPressed: () async {
                            _changeProfile(
                              myUserData: myUserData.value!,
                              userNameController: userNameController,
                              profileController: profileController,
                              imageState: imageState,
                              ref: ref,
                              context: context,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<File?> urlToFile(String imageUrl) async {
    try {
      // 画像をダウンロード
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // 一時フォルダを取得
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/downloaded_image.jpg';

        // ファイルを作成して保存
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        return file;
      } else {
        return null; // 画像の取得に失敗した場合
      }
    } catch (e) {
      return null; // エラー発生時
    }
  }

  Future _getImageFromGallery({
    required ValueNotifier<File?> imageState,
  }) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
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

  void _changeProfile({
    required UserData myUserData,
    required TextEditingController userNameController,
    required TextEditingController profileController,
    required ValueNotifier<File?> imageState,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    if (formKey.currentState!.validate() == false) {
      //失敗したときに処理をストップ
      return;
    }

    late UserData updateUser;

    try {
      print(imageState.value == null);
      if ((imageState.value != null)) {
        //もし投稿に写真があればストレージにあげる処理を行い、そのURLを取得
        String downloadImageUrl =
            await ref.read(storageRepoProvider.notifier).uploadImageAndGetUrl(
                  folderName: ImageFolder.postsIcon.name,
                  photoId: ref.read(authRepoProvider)!.uid,
                  image: imageState.value!,
                );
        // print(downloadImageUrl);
        updateUser = myUserData.copyWith(
          userName: userNameController.text,
          profile: profileController.text,
          imageUrl: downloadImageUrl,
          updatedAt: Timestamp.now(),
        );
      } else {
        updateUser = myUserData.copyWith(
          userName: userNameController.text,
          profile: profileController.text,
          updatedAt: Timestamp.now(),
        );
      }

      await ref.read(userRepoProvider.notifier).updateUser(updateUser);
      // await FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(user!.uid)
      //     .update({
      //   "userName": userNameController.text,
      //   "profile": profileController.text,
      //   "updatedAt": Timestamp.now()
      // });
      // }
      showToast('変更成功しました');
      //ボタン押したらフォーカス外れてキーボード消える＆その後TextFormをタップするとフォーカスできる！
      FocusManager.instance.primaryFocus?.unfocus();

      // context.goNamed(AppRoute.mypage.name);
    } catch (e) {
      if (context.mounted) {
        showCloseOnlyDialog(
          context: context,
          titleText: '変更失敗',
          text: '予期せぬエラーです',
        );
      }

      // showCloseOnlyDialog(context, '変更失敗', '予期せぬエラーです');
      // print(e.toString());
    }
    return;
  }

  // Future<void> _changeImage(
  //     // Future<dynamic> Function() getImageFromGallery,
  //     {required WidgetRef ref,
  //     required UserData myUserData,
  //     required ValueNotifier<File?> imageState,
  //     required BuildContext context}) async {
  //   await _getImageFromGallery(imageState: imageState);
  //   // if (imageState.value != null) {
  //   //   print("image選択はできてる");
  //   // }
  //   try {
  //     //ストレージにあげる処理を行い、そのURLを取得
  //     String downloadImageUrl =
  //         await ref.read(storageRepoProvider.notifier).uploadImageAndGetUrl(
  //               folderName: ImageFolder.usersIcon.name,
  //               photoId: myUserData.userId,
  //               image: imageState.value!,
  //             );

  //     //インスタンス作成
  //     UserData updateAccount = myUserData.copyWith(
  //       imageUrl: downloadImageUrl,
  //       updatedAt: Timestamp.now(),
  //     );
  //     await ref.read(userRepoProvider.notifier).updateUser(updateAccount);

  //     showToast('画像を変更しました！');
  //     imageState.value = null;
  //     // widget.imageUrl = chooseImageUrl;
  //     // setState(() {});
  //   } catch (e) {
  //     // ignore: use_build_context_synchronously
  //     // print(e);
  //     if (context.mounted) {
  //       showCloseOnlyDialog(
  //           context: context, titleText: '失敗', text: '画像変更に失敗しました');
  //       // showCloseOnlyDialog(context, '失敗', '画像変更に失敗しました');
  //     }
  //   }
  // }
}
