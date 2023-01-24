import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Components/App_Components.dart';
import 'package:jabwemeet/Models/UserModel.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/GetStorag_Controller.dart';
import 'package:jabwemeet/Views/Home/Screens/Profile/Edit_Profile.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    UserModel? userModel;
    return Scaffold(
      bottomNavigationBar: kCustomBottomNavBar(
        index: 3,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppComponents().sizedBox30,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Get.find<GetSTorageController>().removeStorage();
                    },
                    icon: Icon(
                      Icons.logout,
                      color: butoncolor,
                    ))
              ],
            ),
            Center(
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(user!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData ||
                      snapshot.hasError ||
                      snapshot.data == null) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 68.0),
                        child: Text(
                          "No data Yet...",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    );
                  }
                  userModel = UserModel.fromMap(
                      snapshot.data!.data() as Map<String, dynamic>);
                  return UserProfile(
                    height: userModel!.height.toString() == "null"
                        ? ""
                        : userModel!.height.toString(),
                    address: userModel!.address.toString() == "null"
                        ? ""
                        : userModel!.address.toString(),
                    age: userModel!.age.toString(),
                    imagesList: userModel!.imagesList!,
                    education: userModel!.education.toString(),
                    gender: userModel!.gender.toString(),
                    martial_status: userModel!.martial_status.toString(),
                    hobbies: userModel!.hobbies.toString(),
                    imageUrl: userModel!.imageUrl.toString(),
                    name: userModel!.name.toString(),
                    designation: userModel!.work.toString(),
                    email: userModel!.email.toString() == "null"
                        ? ""
                        : userModel!.email.toString(),
                    phone_number: userModel!.phone_number.toString() == "null"
                        ? ""
                        : userModel!.phone_number.toString(),
                  );
                },
              ),
            ),
            AppComponents().sizedBox20,
            Center(
              child: kCustomButton(
                  label: "Edit Profile",
                  ontap: () {
                    Get.to(() => Edit_Profile(
                          userModel: userModel!,
                        ));
                  }),
            ),
            AppComponents().sizedBox20,
          ],
        ),
      ),
    );
  }
}
