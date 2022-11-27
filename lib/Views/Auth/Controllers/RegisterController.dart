import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Utils/locations.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Password_encyption.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/1.Complete_profile_screen.dart';
import 'package:jabwemeet/Views/Auth/Screens/Forgot_password_screen/Forgot_pass_Otp.dart';
import 'package:jabwemeet/Views/Auth/Screens/LoginScreen2.dart';

class RegisterController extends GetxController {
  final resetFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();
  final createPasswordKey = GlobalKey<FormState>();

  final TextEditingController ageController = TextEditingController();
  final TextEditingController casteController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController resetemailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController ConfirmPassController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  RxBool hidePassword = true.obs;
  var isAccept = false.obs;
  var isTerm = false.obs;
  var isPolicy = false.obs;
  bool isPasswordVisible = true;
  String? selectedValue = "Select Caste";
  String? selectedStar = "Select Star";
  String? selectedHeight = "Select height";
  String? selectedIncome = "Select income";
  String? selectedwork = "Select Occupation Sector";
  String? selectedSports = "Select Sports";
  String? selectedSmoke = "Do you smoke?";
  String? selectedCreativity = "Select Creativity";
//loading
  bool loading = false;
  var address = "".obs;

  selectedCasteFunction(String? value) {
    selectedValue = value;
    update();
  }

  selectedCreativityFunction(String? value) {
    selectedCreativity = value;
    update();
  }

  selectedStarFunction(value) {
    selectedStar = value;
    update();
  }

  selectedIncomeFunction(value) {
    selectedIncome = value;
    update();
  }

  selectedSPortsFunction(value) {
    selectedSports = value;
    update();
  }

  selectedWorkFunction(value) {
    selectedwork = value;
    update();
  }

  selectedHeightFunction(value) {
    selectedHeight = value;
    update();
  }

  selectedSmokeFunction(value) {
    selectedSmoke = value;
    update();
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

  //is password visible
  bool passwordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
    return isPasswordVisible;
  }

  gender gendr = gender.Man;
  get getGender => gendr;
  gender setGender(gender setType) {
    gendr = setType;
    update();
    return gendr;
  }

  String? validatePassword(String value) {
    if (value == null || value == '') {
      return "*Required";
    } else if (value.length < 6) {
      return "Password should be more than 6 character";
    }
    return null;
  }

  String? validateConfPassword(String value) {
    if (value == null || value == '') {
      return "*Required";
    } else if (value.length < 6) {
      return "Password should be more than 6 character";
    } else if (passController.value.text != ConfirmPassController.value.text) {
      return "Password doesn't match";
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

  String? validateName(String value) {
    if (value == null || value == '') {
      return "*Required";
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value == null || value == '') {
      return "*Required";
    } else if (!value.isEmail) {
      return 'Invalid Email';
    }
    return null;
  }

  getlocation() async {
    Position position = await GetLocation.getPermission().whenComplete(() {});
    Get.find<GetSTorageController>()
        .box
        .write(P_LATITUDE, position.latitude.toString());
    Get.find<GetSTorageController>()
        .box
        .write(P_LONGITUDE, position.longitude.toString());
  }

  RegisterViewEnum RegisterViewPage = RegisterViewEnum.RegisterView1;
  get getRegisterViewPage => RegisterViewPage;
  RegisterViewEnum setRegisterViewPage(RegisterViewEnum setPage) {
    RegisterViewPage = setPage;
    update();
    return setPage;
  }

  Future register(BuildContext context) async {
    try {
      loading = true;
      update();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.value.text.trim(),
          password: passwordController.value.text.trim());
      await addUserdetails();
      Get.offAll(() => LoginScreen2());

      showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
              title: Text('Account created Successfully'),
            );
          });

      // await helpers.getName();
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      String? errorMessage;

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Email already registered';
          break;

        case 'invalid-email':
          errorMessage = "Invalid Email address";
          break;

        case 'operation-not-allowed':
          errorMessage = "Operation not allowed";
          break;

        case 'weak-password':
          errorMessage =
              'Weak password, please enter a strong password minimum 8 characters and combination of special characters,alphabets and numbers make it more strong';
      }

      showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: const Text('Registeration failed!'),
            content: Text(errorMessage ?? ''),
          );
        },
      );
    } finally {
      loading = false;
      update();
    }
  }

  //get all the users username
  Future<QuerySnapshot?> getAllEmails(BuildContext context) async {
    List emailOfUsers = [];
    QuerySnapshot username = await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) {
      emailOfUsers.clear();
      for (var i in snapshot.docs) {
        UserModel userModel = UserModel.fromMap(i.data());

        emailOfUsers.add(userModel.email);
      }

      if (emailOfUsers.contains(emailController.text)) {
        showDialog(
            context: context,
            builder: (builder) {
              return AlertDialog(
                title: const Text('Registeration failed!'),
                content: Text('Email already exist'),
              );
            });
      } else {
        // Navigator.of(context).pushNamed(route.register);
        print("Email not exist");
      }
      return snapshot;
    });
    return username;
  }

//add the user details while signup
  final storage = Get.find<GetSTorageController>();
  Future addUserdetails() async {
    FirebaseAuth _fireAuth = FirebaseAuth.instance;
    User? user = _fireAuth.currentUser;
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
      hobbies: storage.box.read(kHobbies),
      sports: storage.box.read(kSports),
      work: storage.box.read(kWork),
      martial_status: storage.box.read(kMartial_Statius),
      imageUrl: "",
      phone_number: storage.box.read(kPhone),
      income: storage.box.read(kIncome),
      uid: FirebaseAuth.instance.currentUser!.uid,
      password: EncryptData.encryptData(password: storage.box.read(kPassword)),
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .set(userModel.toMap())
        .then((value) => Get.offAll(() => Complete_Profile1()));
  }

  //sajawal
  var number;
  var oldPassword;
  var uiddd;
  bool isResetLoad = false;
  getNumberAndPassword(BuildContext context) async {
    isResetLoad = true;
    update();
    await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: resetemailController.value.text)
        .get()
        .then((snapshot) {
      if (snapshot.size > 0) {
        log("Profile already Filled");
        for (var element in snapshot.docs) {
          log("Phone Number is : ${element.get("phone_number")}");
          number = element.get("phone_number");
          uiddd = element.get("uid");
          oldPassword = element.get("password");
          isResetLoad = false;
          update();
        }
      } else {
        isResetLoad = false;
        update();
        snackBar(context, "Your Account not found", Colors.deepOrange);
      }
    });
    isResetLoad = false;
    update();
  }

  var resend_Token;
  var verification_Id;
  //by sajawal
  sendOTP({required String phoneNumber, required BuildContext context}) async {
    log("<=============================================>");
    log("Inside Phone Authentication sendOTP Service");
    log("Phone no is $phoneNumber");
    log("<=============================================>");
    isResetLoad = true;
    update();
    try {
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
            isResetLoad = false;
            update();
            Get.to(() => ForgetPassword_OTP_view(
                phoneNumber: number.toString(),
                verificationId: verification_Id.toString()));
          },
          codeAutoRetrievalTimeout: (verificationId) {},
          timeout: Duration(seconds: 60));
      isResetLoad = false;
      update();
    } on FirebaseException catch (e) {
      isResetLoad = false;
      update();
      log("Inside Catch statement ${e.code}");
      snackBar(context, e.code.toString(), Colors.deepOrange);
    }
  }

  bool isVerifyLoad = false;
  Future<bool> verifyOtp() async {
    log("<=============================================>");
    log("Inside Phone Authentication verifyOtp Service");
    log("Otp is" + otpController.value.text.toString());
    log("VerificationId is $verification_Id");
    log("<=============================================>");
    bool verificationStatus = false;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verification_Id, smsCode: otpController.value.text);

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
        await FirebaseAuth.instance.signOut();
      } else {
        isVerifyLoad = false;
        update();
        verificationStatus = false;
        log("Verification Status inside else statement is: $verificationStatus");
      }
      log("Verification Status outside if else statement: $verificationStatus");
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
    log("Phone Number is $number");
    log("Resend Token is $resend_Token");
    log("<=============================================>");
    isResendLoad = true;
    update();
    try {
      log("Inside try statement. ");
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: number,
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

  User? user = FirebaseAuth.instance.currentUser;
  bool isUpdatePassLoad = false;
  updatePassword(BuildContext context) async {
    var token = await FirebaseMessaging.instance.getToken();
    try {
      isUpdatePassLoad = true;
      update();
      log("<------------------earlier true----------------->");
      var pass = EncryptData.decryptData(encryptedPassword: oldPassword);
      log("<Decrypt from login>");
      log(pass);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: resetemailController.value.text, password: pass);
      await FirebaseAuth.instance.currentUser!
          .updatePassword(ConfirmPassController.value.text.toString());
      log("<------------------second earlier true----------------->");
      await FirebaseFirestore.instance.collection('users').doc(uiddd).update({
        'fcm_token': token,
        'password':
            EncryptData.encryptData(password: ConfirmPassController.value.text)
                .toString()
      });
      log("<------------------Final earlier true----------------->");
      ConfirmPassController.clear();
      passController.clear();
      isUpdatePassLoad = false;
      update();
      showDialog(
          context: context,
          builder: (builder) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      Get.offAll(() => LoginScreen2());
    } catch (e) {
      isUpdatePassLoad = false;
      update();
      log(e.toString());
      snackBar(context, 'Something went wrong!', Colors.pink);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getlocation();
  }
}
