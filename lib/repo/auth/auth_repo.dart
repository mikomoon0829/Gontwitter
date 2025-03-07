import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter/config/firebase/firebase_auth_error_text.dart';
import 'package:twitter/config/firebase/firebase_provider.dart';

part 'auth_repo.g.dart';

@riverpod
class AuthRepo extends _$AuthRepo {
  @override
  User? build() {
    return ref.read(firebaseAuthProvider).currentUser;
  }

  //ログイン処理
  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      //FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      await ref
          .read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      //currentUserが変わったらstateに代入する！！はこのauthプロバイダの原則なので、代入する！
      state = ref.read(firebaseAuthProvider).currentUser;
      return 'success';
    } on FirebaseAuthException catch (e) {
      //この一行追加
      return FirebaseAuthErrorExt.fromCode(e.code).message;
    } catch (e) {
      return 'error';
    }
  }

  //ログアウト処理
  Future<void> signOut() async {
    await ref.read(firebaseAuthProvider).signOut();
    //currentUserが変わったらstateに代入する！！はこのauthプロバイダの原則なので、代入する！
    state = ref.read(firebaseAuthProvider).currentUser;
  }

  //新規登録処理
  Future<String> createUser(
      {required String email, required String password}) async {
    try {
      //FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      await ref
          .read(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
      //currentUserが変わったらstateに代入する！！はこのauthプロバイダの原則なので、代入する！
      state = ref.read(firebaseAuthProvider).currentUser;
      return 'success';
    } on FirebaseAuthException catch (e) {
      //この一行追加
      return FirebaseAuthErrorExt.fromCode(e.code).message;
    } catch (e) {
      return 'error';
    }
  }

  //パスワードリマインダーメールの送信（ログイン前のパスワード忘れの時もこの関数使うのでemailは引数で受け取る）
  Future<String> sendPasswordResetEmail({required String email}) async {
    try {
      //FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      await ref.read(firebaseAuthProvider).sendPasswordResetEmail(email: email);
      //currentUserが変わったらstateに代入する！！はこのauthプロバイダの原則なので、代入する！
      //パスワードの方は自動的に変えてくれるので大丈夫！
      // state = ref.read(firebaseAuthProvider).currentUser;
      return 'success';
    } on FirebaseAuthException catch (e) {
      //この一行追加
      return FirebaseAuthErrorExt.fromCode(e.code).message;
    } catch (e) {
      return 'error';
    }
  }

  //メールアドレスの変更
  Future<String> verifyBeforeUpdateEmail({required String newEmail}) async {
    //FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    //1.サインインさせる

    //authRepoのサインインメソッドならサインインしたらresult返すから、そっち使いたい
    //同じrepo内の他のメソッド呼ぶには、普通に前に何もなくメソッド名でいける！
    // final String signInResult= await signIn(email: email, password: password)

    try {
      //2.メルアドを更新させる
      // await FirebaseAuth.instance
      await ref
          .watch(firebaseAuthProvider)
          .currentUser!
          .verifyBeforeUpdateEmail(newEmail);
      return 'success';

      // await ref
      //     .watch(firebaseAuthProvider)
      //     .signInWithEmailAndPassword(email: state!.email!, password: password);

//3.サインアウトさせる
      // await ref.watch(firebaseAuthProvider).signOut();
      // // ignore: use_build_context_synchronously
      // // Navigator.of(context).pop();

      // // showToast("新しいメールアドレスのメールボックスを確認してください"); これview側でやること！
      // return "success";
    } on FirebaseAuthException catch (e) {
      //この一行追加
      return FirebaseAuthErrorExt.fromCode(e.code).message;
    } catch (e) {
      return 'error';
    }
  }

  //authStateChangeを監視する(自動ログイン、ログアウト)
  Stream<User?> authStateChange() {
    //FirebaseAuth.instance.authStateChanges()というものが存在してる
    //これの返す値はUserが変わったらそのUserを返してくれる(Stream<User?>)
    return ref
        .read(firebaseAuthProvider)
        .authStateChanges()
        //streamにmap処理が使える！変わった後のcurrentUserを状態に代入してあげる
        //別にこのメソッド、currentUserを変えるものじゃなくて変化を監視する用やん！って感じやけど、
        //上のログインログアウト会員登録処理をやってなくてもcurrentUserが変わってしまうこともある！（勝手にログアウトとか）
        //currentUserが変わったらstateに代入する！！はこのauthプロバイダの原則なので、代入する！
        .map(
      (User? currentUser) {
        state = currentUser;
        return state;
      },
    );
  }
}
