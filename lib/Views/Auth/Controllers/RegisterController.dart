import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Utils/enums.dart';
import 'package:jabwemeet/Utils/locations.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Auth/Controllers/Password_encyption.dart';
import 'package:jabwemeet/Views/Auth/Screens/Complete_profile/completeProfile/view/completeprofilescreen.dart';

import 'package:jabwemeet/Views/Auth/Screens/Forgot_password_screen/Forgot_pass_Otp.dart';
import 'package:jabwemeet/Views/Auth/Screens/Forgot_password_screen/create_new_pass.dart';
import 'package:jabwemeet/Views/Auth/Screens/LoginScreen.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/Bismillah_Screen.dart';
import 'package:jabwemeet/Views/Auth/Screens/Register_screns/register_screen.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/home_swap.dart';
import 'package:jabwemeet/Views/Home/Screens/Home/new_home_swapable.dart';

class RegisterController extends GetxController {
  final resetFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();
  final createPasswordKey = GlobalKey<FormState>();
  final signupKey = GlobalKey<FormState>();

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
  var isChild = false;
  bool isPasswordVisible = true;
  String? selectedValue = "Select Caste";
  String? selectedLanguage = "Select Language";
  String? selectedCity = "Select City";
  String? selectedStar = "Select Star";
  String? selectedHeight = "Select height";
  String? selectedIncome = "Select income";
  String? selectedwork = "Select Occupation Sector";
  String? selectedSports = "Select Sports";
  String? selectedChild = "0";
  String? selectedSmoke = "Do you smoke?";
  String? selectedCreativity = "Select Creativity";
//loading
  bool loading = false;
  var address = "".obs;
  bool isEmailVerified = false;
  bool canResendEmail = false;

  selectedCasteFunction(String? value) {
    selectedValue = value;
    update();
  }

  selectedLanguageFunction(String? value) {
    selectedLanguage = value;
    update();
  }

  selectedChildFunction(String? value) {
    selectedChild = value;
    update();
  }

  selectedCityFunction(String? value) {
    selectedCity = value;
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

  Future signup(BuildContext context) async {
    try {
      loading = true;
      update();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.value.text.trim(),
          password: passController.value.text.trim());
      try {
        Get.find<GetSTorageController>()
            .box
            .write(kPassword, passController.text);
        final user = FirebaseAuth.instance.currentUser!;
        await user.sendEmailVerification();
        Get.to(() => Bismillah_Screen());
        await Future.delayed(Duration(seconds: 5));
      } catch (e) {
        loading=false;
        update();
        print(e);
        // snackBar(context, e.toString(), Colors.pink);
      }
      // await helpers.getName();
    } on FirebaseAuthException catch (e) {
      loading=false;
      update();
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
              shape: Border.all(
                color: Colors.red,
              ),
              title: const Text('Registeration failed!'),
              content: Text(errorMessage ?? ''),
              icon: Image.asset(
                "assets/appicon.png",
                height: 40,
                width: 40,
              ),
            );
          });
    } finally {
      loading = false;
      update();
    }
  }

  List userNamesList = [];
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
        emailOfUsers.add(userModel.email.toString());
        userNamesList.add(userModel.name.toString());
        update();
        print(emailOfUsers);
        print(userNamesList);
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
  Future addsignupdetails() async {
    isUpdatePassLoad = true;
    update();
    FirebaseAuth fireAuth = FirebaseAuth.instance;
    User? user = fireAuth.currentUser;
    UserModel userModel = UserModel(
      height: storage.box.read(kHeight),
      name: storage.box.read(kFull_name),
      latitude: storage.box.read(P_LATITUDE),
      longitude: storage.box.read(P_LONGITUDE),
      imagesList: [],
      subscribe: false,
      blur: false,
      about: storage.box.read(kAbout),
      address: storage.box.read(kAddress),
      age: age,
      birthday: storage.box.read(kAge),
      caste: storage.box.read(kCaste),
      industry: storage.box.read(kIndustry),
      education: storage.box.read(kEducation),
      email: user!.email.toString(),
      fcm_token: await FirebaseMessaging.instance.getToken(),
      gender: storage.box.read(kGender),
      childerns: storage.box.read(kchildern),
      languages: [],
      religion: storage.box.read(kReligion),
      hobbies: [],
      religious_practice: storage.box.read(kReligiousPractice),
      work: storage.box.read(kWork),
      job_title: storage.box.read(kJobTitle),
      martial_status: storage.box.read(kMartial_Statius),
      imageUrl: storage.box.read(kImageUrl),
      phone_number: storage.box.read(kPhone),
      income: storage.box.read(kIncome),
      uid: FirebaseAuth.instance.currentUser!.uid,
      password: EncryptData.encryptData(
              password: Get.find<GetSTorageController>().box.read(kPassword))
          .toString(),
    );
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(userModel.toMap())
          .then((value) {
        isUpdatePassLoad = false;
        update();
      });
    } catch (e) {
      isUpdatePassLoad = false;
      update();
    }
  }

  int age = 0;
  RxString birthdayDate = 'Select date'.obs;
  datePicker(BuildContext context) async{

    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1970),
        initialDatePickerMode:DatePickerMode.year ,
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              shadow: textcolor,
              primary: textcolor, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: textcolor, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: textcolor, // button text color
              ),
            ),
          ),
    child: child!,);});
    DateTime currentDate = DateTime.now();
    age = currentDate.year - date!.year;
    update();
    int month1 = currentDate.month;
    int month2 = date.month;
    if (month2 > month1) {
      age--;
      update();
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = date.day;
      if (day2 > day1) {
        age--;
        update();
      }
    }
    update();
    print("age" + age.toString());
  birthdayDate.value = DateFormat.yMMMd().format(date);
  update();
/*
    DatePicker.showDatePicker(context,
        showTitleActions: true, maxTime: DateTime.now(), onChanged: (date) {
      DateTime currentDate = DateTime.now();
      age = currentDate.year - date.year;
      update();
      int month1 = currentDate.month;
      int month2 = date.month;
      if (month2 > month1) {
        age--;
        update();
      } else if (month1 == month2) {
        int day1 = currentDate.day;
        int day2 = date.day;
        if (day2 > day1) {
          age--;
          update();
        }
      }
      update();
      print("age" + age.toString());
    }, onConfirm: (date) {
      birthdayDate.value = DateFormat.yMMMd().format(date);
      update();
    }, currentTime: DateTime.now(), locale: LocaleType.en);*/
  }

//add the user details while signup
  bool loader=false;
  Future addUserdetails() async {
    loader = true;
    update();
    FirebaseAuth _fireAuth = FirebaseAuth.instance;
    User? user = _fireAuth.currentUser;
    UserModel userModel = UserModel(
      height: storage.box.read(kHeight).toString(),
      name: storage.box.read(kFull_name).toString(),
      imagesList: [],
      latitude: storage.box.read("latitude").toString(),
      longitude: storage.box.read("longitude").toString(),
      about: storage.box.read(kAbout),
      address: storage.box.read(kAddress),
      age: age,
      subscribe: false,
      blur: false,
      birthday: storage.box.read(kAge),
      caste: storage.box.read(kCaste),
      job_title: storage.box.read(kJobTitle),
      education: storage.box.read(kEducation),
      email: user!.email.toString(),
      fcm_token: await FirebaseMessaging.instance.getToken(),
      gender: storage.box.read(kGender),
      religious_practice: storage.box.read(kReligiousPractice),
      languages: [],
      religion: storage.box.read(kReligion),
      hobbies: [],
      childerns: storage.box.read(kchildern),
      industry: storage.box.read(kIndustry),
      work: storage.box.read(kWork),
      martial_status: storage.box.read(kMartial_Statius),
      imageUrl: storage.box.read(kImageUrl),
      phone_number: storage.box.read(kPhone),
      income: storage.box.read(kIncome),
      uid: FirebaseAuth.instance.currentUser!.uid,
      password: EncryptData.encryptData(
          password: storage.box.read(kPassword).toString()),
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update(userModel.toMap())
        .then((value) {
      loader = false;
      update();
      Get.offAll(() => Complete_Profile1());
    });
  }

  Future addUserdetailsSend() async {
    FirebaseAuth _fireAuth = FirebaseAuth.instance;
    User? user = _fireAuth.currentUser;
    UserModel userModel = UserModel(
      height: storage.box.read(kHeight).toString(),
      name: storage.box.read(kFull_name).toString(),
      imagesList: [],
      latitude: storage.box.read("latitude").toString(),
      longitude: storage.box.read("longitude").toString(),
      about: storage.box.read(kAbout),
      address: storage.box.read(kAddress),
      age: age,
      subscribe: false,
      blur: false,
      birthday: storage.box.read(kAge),
      caste: storage.box.read(kCaste),
      job_title: storage.box.read(kJobTitle),
      education: storage.box.read(kEducation),
      email: user!.email.toString(),
      fcm_token: await FirebaseMessaging.instance.getToken(),
      gender: storage.box.read(kGender),
      religious_practice: storage.box.read(kReligiousPractice),
      languages: [],
      religion: storage.box.read(kReligion),
      hobbies: [],
      childerns: storage.box.read(kchildern),
      industry: storage.box.read(kIndustry),
      work: storage.box.read(kWork),
      martial_status: storage.box.read(kMartial_Statius),
      imageUrl: storage.box.read(kImageUrl),
      phone_number: storage.box.read(kPhone),
      income: storage.box.read(kIncome),
      uid: FirebaseAuth.instance.currentUser!.uid,
      password: EncryptData.encryptData(
          password: storage.box.read(kPassword).toString()),
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap())
        .then((value) => Get.to(() => Register_screen()));
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
          update();
        }
      }
      else {
        isResetLoad = false;
        update();
        snackBar(context, "Your Profile not found", Colors.deepOrange);
      }
    });
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
    update();
    try {
      log("Inside try Otp statement. ");
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (credentials) {},
          verificationFailed: (ex) {
            snackBar(context, ex.message.toString(), textcolor);
            isResetLoad = false;
            update();
            log(ex.code.toString());
          },
          codeSent: (verificationId, resendToken) {
            log("Resend Token is $resendToken");
            log("VerificationId is $verificationId");
            resend_Token = resendToken;
            update();
            verification_Id = verificationId;
            update();
            isResetLoad = false;
            update();
            Get.to(() => ForgetPassword_OTP_view());
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
  var otp;
  getotpPassword(value){
    otp=value;
    update();
    verifyOtp();
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
        verificationId: verification_Id, smsCode: otp);
    isVerifyLoad = true;
    update();
    try {
      log("Inside try statement.");
          await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
            if (value.user != null) {
              log("Firebase Verification Successful");
              verificationStatus = true;
              log("Verification Status inside if statement is: $verificationStatus");
              await FirebaseAuth.instance.signOut();
              Get.off(()=> CreateNewPasswordView());
            } else {
              isVerifyLoad = false;
              update();
              verificationStatus = false;
              log("Verification Status inside else statement is: $verificationStatus");
            }
            log("Verification Status outside if else statement: $verificationStatus");
            return verificationStatus;
          });
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
  Future updatePassword(BuildContext context) async {
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
              if (value.get("age") == 0 || value.get("age") == null) {
                 Get.to(() => Register_screen());
              } else {
                if (value.get("imageUrl") == null) {
                  Get.to(() => Complete_Profile1());
                } else {
                  Get.offAll(() => HomeSwapNew());
                }
              }
            } else {
              print("agaya");
              await addUserdetailsSend();
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getlocation();
  }
}
