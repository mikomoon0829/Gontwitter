// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:twitter/config/utils/margin/margin_box.dart';
// import 'package:twitter/data_models/posts/posts.dart';
// import 'package:twitter/functions/global_functions.dart';
// import 'package:twitter/views/my_page/components/edit_button.dart';
// import 'package:uuid/uuid.dart';

// class AddPostPage extends StatefulWidget {
//   const AddPostPage({super.key});
//   // final String userName;
//   // String imageUrl;

//   @override
//   State<AddPostPage> createState() => _AddPostPageState();
// }

// class _AddPostPageState extends State<AddPostPage> {
//   final formKey = GlobalKey<FormState>();

//   final TextEditingController postController = TextEditingController();
//   // final TextEditingController profileController = TextEditingController();

//   final user = FirebaseAuth.instance.currentUser;
//   File? image;

//   @override
//   Widget build(BuildContext context) {
//     // userNameController.text = widget.userName;

//     Widget previewWidget;
//     if (image != null) {
//       previewWidget = Image.file(
//         image!,
//         height: 150,
//         width: 150,
//       );
//     } else {
//       previewWidget = Image.asset(
//         'assets/images/image_photo.png',
//         height: 150,
//         width: 150,
//       );
//     }

//     return Scaffold(
//         appBar: AppBar(title: const Text('投稿追加')),
//         body: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Stack(
//                       // alignment: Alignment(x, y),
//                       children: [
//                         previewWidget,
//                         if (image != null)
//                           Positioned(
//                             top: -20,
//                             right: -20,
//                             child: IconButton(
//                                 onPressed: () async {
//                                   image = null;
//                                   setState(() {});
//                                 },
//                                 icon: Icon(Icons.close,
//                                     size: 50, color: Colors.red)),
//                           )
//                       ]),
//                   MarginBox.mediumHeightMargin,
//                   EditButton(
//                       buttonText: '画像を選択する',
//                       onEditButtonPressed: () {
//                         // File? image;
//                         // final picker =ImagePicker();
//                         getImageFromGallery();
//                       }),
//                   MarginBox.bigWidthMargin,
//                   TextFormField(
//                       controller: postController,
//                       maxLines: 13,
//                       maxLength: 100,
//                       decoration: const InputDecoration(label: Text('投稿文')),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'テキストを入力してください';
//                         }
//                         return null;
//                       }),
//                   EditButton(
//                     buttonText: '投稿!',
//                     onEditButtonPressed: () async {
//                       if (formKey.currentState!.validate() == false) {
//                         //失敗したときに処理をストップ
//                         return;
//                       }

//                       FocusScope.of(context).unfocus();

//                       final String uuid = const Uuid().v4();

//                       //画像があるとき↓
//                       if (image != null) {
//                         // try {
//                         //   final storedImage = await FirebaseStorage.instance
//                         //       .ref('PostsIcon/${user!.uid}')
//                         //       .putFile(image!);
//                         // } catch (e) {
//                         //   print(e);
//                         // }
//                         final storedImage = await FirebaseStorage.instance
//                             .ref('PostsIcon/$uuid')
//                             .putFile(image!);
//                         final String imageUrl =
//                             await storedImage.ref.getDownloadURL();

//                         //この一行追加　①ドキュメントリファレンス作る
//                         final newDocumentReference = postsReference.doc(uuid);
//                         //
//                         //②Postのデータモデルのインスタンスをつくる
//                         Post newPost = Post(
//                             imageUrl: imageUrl,
//                             postText: postController.text,
//                             userId: FirebaseAuth.instance.currentUser!.uid,
//                             postId: uuid,
//                             createdAt: Timestamp.now(),
//                             updatedAt: Timestamp.now());
//                         // await FirebaseFirestore.instance
//                         //     .collection('posts')
//                         //     .doc(uuid)
//                         //     .set(newPost.toJson());
//                         //次の一行で追加できる！ ③Post型でsetできる！
//                         newDocumentReference.set(newPost);

//                         showToast('投稿されました！');
//                         postController.clear();
//                         image = null;
//                         setState(() {});
//                       } else {
//                         //この一行追加　①ドキュメントリファレンス作る
//                         final newDocumentReference = postsReference.doc(uuid);
//                         //
//                         //②Postのデータモデルのインスタンスをつくる
//                         Post newPost = Post(
//                             imageUrl: '',
//                             postText: postController.text,
//                             userId: FirebaseAuth.instance.currentUser!.uid,
//                             postId: uuid,
//                             createdAt: Timestamp.now(),
//                             updatedAt: Timestamp.now());

//                         // await FirebaseFirestore.instance
//                         //     .collection('posts')
//                         //     .doc(uuid)
//                         //     .set(newPost.toJson());
//                         //次の一行で追加できる！ ③Post型でsetできる！
//                         newDocumentReference.set(newPost);
//                         showToast('投稿されました！');
//                         postController.clear();
//                       }
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

//   Future getImageFromGallery() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         image = File(pickedFile.path);
//         // print(image);
//         // print(user!.uid);
//       }
//     });
//   }
// }

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
import 'package:twitter/config/utils/style/color/color_style.dart';
import 'package:twitter/config/utils/style/margin/margin_box.dart';
import 'package:twitter/data_models/post/post.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/repo/auth/auth_repo.dart';
import 'package:twitter/repo/post/post_repo.dart';
import 'package:twitter/repo/storage/storage_repo.dart';
import 'package:twitter/config/utils/enum/folder_enum.dart';
import 'package:twitter/views/my_page/components/edit_button.dart';
import 'package:uuid/uuid.dart';

class AddPostPage extends HookConsumerWidget {
  const AddPostPage({
    super.key,
    // required this.userName,
    // required this.imageUrl,
    // required this.profile
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TextEditingController postController = useTextEditingController();

    // File? image;
    // useState を使って `image` を管理
    final imageState = useState<File?>(null);

    Future getImageFromGallery() async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageState.value = File(pickedFile.path);
        // print(image);
        // print(user!.uid);
      }
    }

    return GestureDetector(
      //他のとこタップでunfocusのためにすること二点！
      //①ScaffoldをGestureDetectorで囲む
      //②このふたつのプロパティ入れる
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('投稿作成')),
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
                      (imageState.value != null)
                          ? CircleAvatar(
                              backgroundImage: FileImage(imageState.value!),
                              radius: 50,
                            )
                          : Image.asset(
                              'assets/images/image_photo.png',
                              height: 150,
                              width: 150,
                            ),
                      if (imageState.value != null)
                        Positioned(
                          top: -20,
                          right: -20,
                          child: IconButton(
                            onPressed: () {
                              //バツボタン押すと写真の選択を外す処理,imageの状態を変えたい

                              imageState.value = null;
                            },
                            icon: const Icon(Icons.close,
                                size: 50, color: ColorStyle.red),
                          ),
                        )
                    ],
                  ),
                  MarginBox.mediumHeightMargin,
                  EditButton(
                    buttonText: '画像を選択する',
                    onEditButtonPressed: () async {
                      // File? image;
                      // final picker =ImagePicker();
                      await getImageFromGallery();
                      // if (imageState.value != null) {
                      //   print('image選択はできてる');
                      // }
                    },
                  ),
                  MarginBox.bigWidthMargin,
                  TextFormField(
                    controller: postController,
                    maxLines: 3,
                    decoration: InputDecoration(label: Text('投稿文')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'テキストを入力してください';
                      }
                      return null;
                    },
                  ),
                  EditButton(
                    buttonText: '投稿！',
                    //ストレージにあげる処理もこっちのボタンにかく
                    onEditButtonPressed: () async {
                      await _submitPost(
                        formKey,
                        context,
                        imageState,
                        ref,
                        postController,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitPost(
      GlobalKey<FormState> formKey,
      BuildContext context,
      ValueNotifier<File?> imageState,
      WidgetRef ref,
      TextEditingController postController) async {
    if (formKey.currentState!.validate() == false) {
      //失敗したときに処理をストップ
      return;
    }

    final String uuid = const Uuid().v4();
    String downloadImageUrl = '';

    try {
      if ((imageState.value != null)) {
        //もし投稿に写真があればストレージにあげる処理を行い、そのURLを取得
        downloadImageUrl = await ref
            .read(storageRepoProvider.notifier)
            .uploadImageAndGetUrl(
                ImageFolder.postsIcon.name, uuid, imageState.value!);
        // print(downloadImageUrl);
      }
      //インスタンス作成
      Post addPost = Post(
        imageUrl: imageState.value != null ? downloadImageUrl : '',
        postText: postController.text,
        userId: ref.read(authRepoProvider)!.uid,
        postId: uuid,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );
      //投稿処理
      await ref.read(postRepoProvider.notifier).addPost(addPost);

      showToast('投稿完了しました！');
      imageState.value = null;
      postController.text = '';
      //ボタン押したらフォーカス外れてキーボード消える＆その後TextFormをタップするとフォーカスできる！
      FocusManager.instance.primaryFocus?.unfocus();
    } catch (e) {
      // ignore: use_build_context_synchronously
      // print(e);
      if (context.mounted) {
        showCloseOnlyDialog(context, '失敗', '投稿に失敗しました');
      }
    }
    return;
  }
}
