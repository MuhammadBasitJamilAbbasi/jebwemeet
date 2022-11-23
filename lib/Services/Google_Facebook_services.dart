//
// import 'package:get/get.dart';
//
// class SignInService {
//   var userEmail = '';
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final FacebookAuth _facebookAuth = FacebookAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   Future<String?> signInwithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount =
//           await _googleSignIn.signIn();
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount!.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//       await auth.signInWithCredential(credential).then((value) => {
//             Get.find<GetSTorageController>()
//                 .box
//                 .write("email", value.user!.email.toString()),
//             Get.find<GetSTorageController>()
//                 .box
//                 .write("name", value.user!.displayName.toString()),
//             Get.find<GetSTorageController>().box.write("password", "123456"),
//           });
//     } on FirebaseAuthException catch (e) {
//       print(e.message);
//       throw e;
//     }
//   }
//
//   Future signInWithFacebook() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     try {
//       final LoginResult loginResult =
//           await _facebookAuth.login(permissions: ['email', 'public_profile']);
//       final OAuthCredential facebookAuthCredential =
//           FacebookAuthProvider.credential(loginResult.accessToken!.token);
//       final userData = await FacebookAuth.instance.getUserData();
//       await auth.signInWithCredential(facebookAuthCredential).then((value) {
//         Get.find<GetSTorageController>()
//             .box
//             .write("email", value.user!.email.toString());
//         Get.find<GetSTorageController>().box.write("password", "123456");
//
//         print(userData.toString());
//         // _services.faceBookSigninDetailsToFirestore(userData['picture']['data']['url'], userData['name'])
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   static Future<void> signOutFromGoogle() async {
//     final GoogleSignIn _googleSignIn = GoogleSignIn();
//     FirebaseAuth auth = FirebaseAuth.instance;
//     await _googleSignIn.signOut();
//     await auth.signOut();
//   }
//
//   static Future<void> signOutFromFacebook() async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     await FacebookAuth.instance.logOut();
//     await auth.signOut();
//   }
// }
