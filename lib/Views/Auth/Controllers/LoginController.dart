import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Password_encyption.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/1.Complete_profile_screen.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/register_screen.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/Home.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController otpController = TextEditingController();
  RxBool hidePassword = true.obs;

  // SignInService service = new SignInService();
  var isLoadingGoogle = false.obs;
  var isLoadingFacebook = false.obs;
  var isAccept = false.obs;
  var isTerm = false.obs;
  var isPolicy = false.obs;

  String? validateEmail(String value) {
    if (value == null || value == '') {
      return "*Required";
    } else if (!value.isEmail) {
      return 'Invalid Email';
    }
    return null;
  }

  String? validateOTP(String value) {
    if (value == null || value == '') {
      return "*Required";
    } else if (value.length < 6) {
      return 'Invalid OTP';
    }
    return null;
  }

  bool isCodeEntered = false;

  codeentered(value) {
    if (value.length == 6) {
      isCodeEntered = true;
      update();
    } else
      isCodeEntered = false;
    update();
  }

  String? validatePassword(String value) {
    if (value == null || value == '') {
      return "*Required";
    } else if (value.length < 6) {
      return "Password should be more than 6 character";
    }
    return null;
  }

  void showpassword() {
    if (hidePassword.value) {
      hidePassword.value = false;
    } else if (hidePassword.value == false) {
      hidePassword.value = true;
    }
  }

  final loginFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  void loginbutton(BuildContext context) {
    final isValid = loginFormKey.currentState!.validate();
    if (isValid) {
      login(context);
    } else
      print("Not Valid");
  }

  Future login(BuildContext context) async {
    try {
      isLoading = true;
      update();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.uid)
            .update({
          'fcm_token': await FirebaseMessaging.instance.getToken()
        }).whenComplete(() {
          log("User Firebase Messaging Token Updated: ");
        });
      });
      showDialog(
          context: context,
          builder: (builder) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      User? user = FirebaseAuth.instance.currentUser;
      try {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .get()
            .then((value) async {
          Get.find<GetSTorageController>().box.write("loggedin", "loggedin");
          if (value.get("imageUrl") == null) {
            Get.offAll(() => Complete_Profile1());
          } else {
            Get.offAll(() => Home());
          }
        });
      } catch (e) {
        log(e.toString());
      }
      ;

      email.clear();
      password.clear();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      update();
      String? message;
      switch (e.code) {
        case 'invalid-email':
          message = 'Invalid Email';
          break;

        case 'user-disabled':
          message = "Your account is diasbled";
          break;

        case 'user-not-found':
          message = 'User not found';
          break;

        case 'wrong-password':
          message = "Wrong password";
      }

      showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
              title: const Text('Login failed'),
              content: Text(message ?? 'No internet'),
            );
          });
    } finally {
      isLoading = false;
      update();
      //   email.clear();
      //   password.clear();
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoaderGoogle = false;

  Future<String?> signInwithGoogle() async {
    try {
      isLoaderGoogle = true;
      update();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential).then((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        try {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user!.uid)
              .get()
              .then((value) async {
            if (value.exists) {
              Get.find<GetSTorageController>()
                  .box
                  .write(kFull_name, user.displayName.toString());
              Get.find<GetSTorageController>()
                  .box
                  .write(kPhone, user.phoneNumber.toString());
              if (value.get("age") == null) {
                Get.offAll(() => Register_screen());
              } else {
                if (value.get("imageUrl") == null) {
                  Get.offAll(() => Complete_Profile1());
                } else {
                  Get.offAll(() => Home());
                }
              }
            } else {
              await addUserdetails();
            }
            Get.find<GetSTorageController>().box.write("loggedin", "loggedin");
          });
        } catch (e) {
          log(e.toString());
        }
      });
    } on FirebaseAuthException catch (e) {
      isLoaderGoogle = false;
      update();
      print(e.message);
      throw e;
    }
  }

//add the user details while signup
  final storage = Get.find<GetSTorageController>();

  Future addUserdetails() async {
    FirebaseAuth _fireAuth = FirebaseAuth.instance;
    User? user = _fireAuth.currentUser;
    UserModel userModel = UserModel(
        height: null,
        name: user!.displayName,
        about: null,
        address: storage.box.read(kAddress),
        age: null,
        caste: "",
        creativity: "",
        education: "",
        email: user.email,
        fcm_token: await FirebaseMessaging.instance.getToken(),
        gender: "",
        smoking: null,
        star_sign: null,
        religion: null,
        hobbies: [],
        sports: null,
        work: null,
        martial_status: null,
        imageUrl: null,
        phone_number: null,
        income: null,
        uid: FirebaseAuth.instance.currentUser!.uid,
        password: null);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
  }

  var resend_Token;
  var verification_Id;
  bool isSendOtpLoad = false;
  bool isSent = false;

  //by sajawal
  sendOTP({required String phoneNumber, required BuildContext context}) async {
    log("<=============================================>");
    log("Inside Phone Authentication sendOTP Service");
    log("Phone no is $phoneNumber");
    log("<=============================================>");

    try {
      isSendOtpLoad = true;
      update();
      log("Inside try Otp statement. ");
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (credentials) {},
          verificationFailed: (ex) {
            snackBar(context, ex.code.toString(), Colors.deepOrange);
            log(ex.code.toString());
          },
          codeSent: (verificationId, resendToken) {
            log("Resend Token is $resendToken");
            log("VerificationId is $verificationId");
            snackBar(context, "OTP Sending...", Colors.pink);
            resend_Token = resendToken;
            update();
            verification_Id = verificationId;
            update();
            isSendOtpLoad = false;
            update();
            isSent = true;
            update();
            /*  Get.to(() => ForgetPassword_OTP_view(
                phoneNumber: number.toString(),
                verificationId: verification_Id.toString()));*/
          },
          codeAutoRetrievalTimeout: (verificationId) {},
          timeout: Duration(seconds: 60));
    } on FirebaseException catch (e) {
      isSendOtpLoad = false;
      isSent = true;
      update();
      log("Inside Catch statement ${e.code}");
      snackBar(context, e.code.toString(), Colors.deepOrange);
    }
  }

  bool isVerifyLoad = false;

  Future<bool> verifyOtp() async {
    log("<=============================================>");
    log("Inside Phone Authentication verifyOtp Service");
    log("VerificationId is $verification_Id");
    log("<=============================================>");
    bool verificationStatus = false;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verification_Id, smsCode: otpController.value.text);
    isSent = false;
    update();
    isVerifyLoad = true;
    update();
    try {
      log("Inside try statement.");
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        log("Firebase Verification Successful");
        verificationStatus = true;
        log("Verification Status inside if statement is: $verificationStatus");
        // isVerifyLoad = false;
        // update();
        /* await FirebaseAuth.instance.signOut();*/
      } else {
        // isVerifyLoad = false;
        // update();
        verificationStatus = false;
        log("Verification Status inside else statement is: $verificationStatus");
      }
      log("Verification Status outside if else statement: $verificationStatus");
      if (verificationStatus == true) {
        await addUserdetailsPhone();
      }
      return verificationStatus;
    } on FirebaseAuthException catch (e) {
      isVerifyLoad = false;
      update();
      log("Inside Catch statement ${e.code}");
      verificationStatus = false;
      return verificationStatus;
    }
  }

  bool isResendLoad = false;

  resendOtp() async {
    log("<=============================================>");
    log("Inside Phone Authentication resendOtp Service");
    log("Phone Number is $Get.find<GetSTorageController>().box.read(kPhone)");
    log("Resend Token is $resend_Token");
    log("<=============================================>");
    isResendLoad = true;
    update();
    try {
      log("Inside try statement. ");
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber:
              Get.find<GetSTorageController>().box.read(kPhone).toString(),
          verificationCompleted: (credentials) {},
          verificationFailed: (ex) {
            log(ex.code.toString());
          },
          codeSent: (verificationId, resendToken) {
            log("Resend Token is $resendToken");
          },
          forceResendingToken: resend_Token,
          codeAutoRetrievalTimeout: (verificationId) {},
          timeout: Duration(seconds: 60));
      isResendLoad = false;
      update();
    } on FirebaseException catch (e) {
      isResendLoad = false;
      update();
      log("Inside Catch statement ${e.code}");
      // Get.snackbar("Otp Re-Send Error", e.code);
    }
  }

  //add the user details while signup
  addUserdetailsPhone() async {
    User? user = FirebaseAuth.instance.currentUser;
    log(user!.uid);
    UserModel userModel = UserModel(
      height: storage.box.read(kHeight),
      name: storage.box.read(kFull_name),
      about: storage.box.read(kAbout),
      address: storage.box.read(kAddress),
      age: storage.box.read(kAge),
      caste: storage.box.read(kCaste),
      creativity: storage.box.read(kCreativity),
      education: storage.box.read(kEducation),
      email: storage.box.read(kEmail),
      fcm_token: await FirebaseMessaging.instance.getToken(),
      gender: storage.box.read(kGender),
      smoking: storage.box.read(kSmoke),
      star_sign: storage.box.read(kStar_sign),
      religion: storage.box.read(kReligion),
      hobbies: [],
      sports: storage.box.read(kSports),
      work: storage.box.read(kWork),
      martial_status: storage.box.read(kMartial_Statius),
      imageUrl: storage.box.read(kImageUrl),
      phone_number: storage.box.read(kPhone),
      income: storage.box.read(kIncome),
      uid: user.uid,
      password: storage.box.read(kPassword),
    );
    Get.find<GetSTorageController>().box.write("isPhone", "isPhone");
    Get.find<GetSTorageController>().box.write("loggedin", "loggedin");
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get()
          .then((value) async {
        Get.find<GetSTorageController>().box.write("loggedin", "loggedin");
        if (!value.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(userModel.toMap())
              .then((value) => Get.offAll(() => Register_screen()));
        } else {
          if (value.get("age") == null) {
            Get.offAll(() => Register_screen());
          } else if (value.get("imageUrl") == null) {
            Get.offAll(() => Complete_Profile1());
          } else {
            Get.offAll(() => Home());
          }
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  addUserdetailsPhoneUpdate() async {
    User? user = FirebaseAuth.instance.currentUser;
    log(user!.uid);
    UserModel userModel = UserModel(
      height: storage.box.read(kHeight),
      name: storage.box.read(kPhone),
      about: storage.box.read(kAbout),
      address: storage.box.read(kAddress),
      age: storage.box.read(kAge),
      caste: storage.box.read(kCaste),
      creativity: storage.box.read(kCreativity),
      education: storage.box.read(kEducation),
      email: storage.box.read(kEmail),
      fcm_token: await FirebaseMessaging.instance.getToken(),
      gender: storage.box.read(kGender),
      smoking: storage.box.read(kSmoke),
      star_sign: storage.box.read(kStar_sign),
      religion: storage.box.read(kReligion),
      hobbies: [],
      sports: storage.box.read(kSports),
      work: storage.box.read(kWork),
      martial_status: storage.box.read(kMartial_Statius),
      imageUrl: storage.box.read(kImageUrl),
      phone_number: storage.box.read(kPhone),
      income: storage.box.read(kIncome),
      uid: user.uid,
      password: EncryptData.encryptData(password: storage.box.read(kPassword)),
    );
    Get.find<GetSTorageController>().box.write("isPhone", "isPhone");
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update(userModel.toMap())
        .then((value) => Get.offAll(() => Register_screen()));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // GetLocation.getGeoLocationPosition();
  }
}
