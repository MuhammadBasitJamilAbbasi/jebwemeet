import 'dart:core';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Services/Services.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Auth/Controllers/RegisterController.dart';
import 'package:jabwemeet/Views/Auth/Screens/LoginScreen.dart';
import 'package:jabwemeet/Views/Auth/Screens/sign_up_screen.dart';
import 'package:jabwemeet/Views/Home/Controllers/Edit_profile_controller.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class AppComponents {
  Row backIcon(
    void Function()? ontap,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: ontap,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: textcolor,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }

  Row backIconWithSkip(void Function()? ontap, void Function()? ontapSkip) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: ontap,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: textcolor,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
        TextButton(
            onPressed: ontapSkip,
            child: Text(
              "Skip",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ))
      ],
    );
  }
  SizedBox sizedBox5= SizedBox(
    height: 5,
  );
  SizedBox sizedBox10 = SizedBox(
    height: 10,
  );
  SizedBox sizedBox15 = SizedBox(
    height: 15,
  );
  SizedBox sizedBox20 = SizedBox(
    height: 20,
  );
  SizedBox sizedBox30 = SizedBox(
    height: 30,
  );
  SizedBox sizedBox40 = SizedBox(
    height: 40,
  );
  SizedBox sizedBox50 = SizedBox(
    height: 50,
  );
}

// class kLoader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: LoadingAnimationWidget.staggeredDotsWave(
//             size: 50,
//             color: primarycolor,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class kImageLoader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         LoadingAnimationWidget.hexagonDots(
//           size: 30,
//           color: primarycolor,
//         ),
//       ],
//     );
//   }
// }

class kCustomTextField extends StatelessWidget {
  final hinttext;
  final controller;
  final validator;
  final labeltext;
  final maxlines;
  bool isLength;
  bool isValidator;

  kCustomTextField(
      {required this.hinttext,
      required this.controller,
      required this.labeltext,
      this.isLength = false,
      this.maxlines = 1,
      this.isValidator = false,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: isValidator ? validator : null,
      maxLength: isLength ? 2 : null,
      maxLines: maxlines,
      style: TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      keyboardType: isLength ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        hintText: hinttext,
        labelText: labeltext,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textcolor, width: 1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(
            16,
          )),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}

class kPasswordTextField extends StatelessWidget {
  final validator;
  final labeltext;
  bool isObsecure;
  var onpress;
  final TextEditingController controller;
  final String hintText;
  final label;
  final TextInputType textInputType;

  kPasswordTextField(
      {required this.validator,
      required this.controller,
      required this.labeltext,
      required this.hintText,
      this.label,
      this.isObsecure = false,
      required this.onpress,
      this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: isObsecure,
      keyboardType: TextInputType.text,
      controller: controller,
      style: TextStyle(color: Colors.black, fontSize: 14),
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        suffixIcon: IconButton(
            icon: isObsecure
                ? Icon(
                    Icons.visibility_off,
                    color: primarycolor,
                    size: 20,
                    semanticLabel: 'Show password',
                  )
                : Icon(
                    Icons.visibility,
                    color: primarycolor,
                    size: 20,
                    semanticLabel: 'Show password',
                  ),
            onPressed: onpress),
        contentPadding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        labelText: labeltext,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textcolor, width: 1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(
            16,
          )),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}

class kCustomButton extends StatelessWidget {
  final label;
  final ontap;
  bool isRegister;

  kCustomButton(
      {required this.label, required this.ontap, this.isRegister = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: 257,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFEA7C4A),
              Color(0xFFF1565A),
            ]),
        // color: butoncolor,
      ),
      child: InkWell(
        highlightColor: Colors.deepOrange.withOpacity(0.3),
        splashColor: Colors.deepOrange.withOpacity(0.5),
        focusColor: Colors.deepOrange.withOpacity(0.0),
        hoverColor: Colors.deepOrange.withOpacity(0.5),
        onTap: ontap,
        child: Center(child: Text(label, style: k14styleWhite)),
      ),
    );
  }
}

progressIndicator({
  required Color color,
  VoidCallback? ontap,
  required BuildContext context,
}) =>
    Expanded(
      flex: 1,
      child: InkWell(
        onTap: ontap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          height: 8,
          width: MediaQuery.of(context).size.width / 9,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );

snackBar(
  BuildContext context,
  String mainText,
  Color backgroundColor,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 1),
    content: Text(mainText),
    backgroundColor: backgroundColor,
  ));
}

class Essential_Widget extends StatelessWidget {
  final title;
  final leadingImage;
  final onTap;
  final iconfil;

  Essential_Widget(
      {required this.title,
      required this.leadingImage,
      required this.onTap,
      required this.iconfil});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            AppComponents().sizedBox15,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Image.asset(
                      leadingImage,
                      height: 25,
                      width: 25,
                      color: textcolor,
                    )),
                Expanded(
                    flex: 16,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Icon(
                      iconfil,
                      color: textcolor,
                      size: 18,
                    )),
              ],
            ),
            AppComponents().sizedBox15,
          ],
        ),
      ),
    );
  }
}

class outlined_button extends StatelessWidget {
  final String txt;
  final ontap;
  final Widget? icon;
  final Color color;

  outlined_button(
      {required this.txt,
      required this.ontap,
      this.icon,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        icon: icon ?? Container(),
        label: Text(
          txt,
          style: k14styleWhite,
          textAlign: TextAlign.center,
        ),
        style: ButtonStyle(
            side:
                MaterialStateProperty.all<BorderSide>(BorderSide(color: color)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ))),
        onPressed: () {
          ontap();
        });
  }
}

textField({
  int? maxlength,
  required bool isPassword,
  required TextInputType inputType,
  Widget? suffixIcon,
  required String hintText,
  required TextEditingController controller,
  required String? validation(String),
  Widget? suffixWidget,
  Function(String)? onChanged,
  Widget? prefixIcon,
  Color? fillColor,
  required Color borderColor,
  bool? isFilled,
  final VoidCallback? onTap,
  final int? maxlines,
  Widget? counter,
}) =>
    TextFormField(
      maxLength: maxlength,
      maxLines: maxlines,
      onTap: onTap,
      onChanged: onChanged,
      obscureText: isPassword,
      keyboardType: inputType,
      validator: validation,
      controller: controller,
      cursorColor: butoncolor,
      decoration: InputDecoration(
          counter: counter,
          filled: isFilled,
          contentPadding: EdgeInsets.only(left: 20, top: 16, bottom: 16),
          hintText: hintText,
          hintStyle: TextStyle(color: borderColor, fontSize: 13),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          fillColor: fillColor,
          suffix: suffixWidget,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: textcolor,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade300),
          )),
    );

kCustomButton2({
  Color? primaryColor,
  required String title,
  VoidCallback? onPressed,
  double? height,
  double? width,
  TextStyle? textStyle,
  bool islogout = false,
  Color? borderColor,
}) =>
    InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            islogout
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  )
                : Text(""),
            Text(
              title,
              style: textStyle,
            ),
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor!),
// color: primaryColor,
          gradient: RadialGradient(colors: [
            Color(0xFFEA7C4A),
            Color(0xFFF1565A),
          ]),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );

class UserProfile extends StatefulWidget {
  UserProfile({
    required this.imageUrl,
    required this.name,
    required this.designation,
    required this.email,
    required this.height,
    required this.age,
    required this.martial_status,
    required this.hobbies,
    required this.gender,
    required this.address,
    required this.education,
    required this.imagesList,
    required this.phone_number,
  });
  final String imageUrl;
  final String name;
  final String designation;
  final String email;
  final String age;
  final String address;
  final String education;
  final String height;
  final String martial_status;
  final String gender;
  final String hobbies;
  final List<dynamic> imagesList;
  final String phone_number;

  @override
  State<UserProfile> createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final Uri imagelUrl = Uri.parse(widget.imageUrl);
    final Uri nameUrl = Uri.parse(widget.name);
    final Uri designationUrl = Uri.parse(widget.designation);
    final Uri emailUrl = Uri.parse("mailto:" + widget.email);
    final Uri phoneUrl = Uri.parse("tel:" + widget.phone_number);
    final Uri smsUrl = Uri.parse("sms:" + widget.phone_number);
    void getUrlLauncher(Uri url) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        children: [
          Container(
            height: 250,
            child: Stack(
              children: [
                Container(
                    height: 200,
                    child: kSliderImages(imagesList: widget.imagesList)),
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: 160,
                    height: 160,
                    child: AvatarGlow(
                      glowColor: Color.fromARGB(255, 15, 233, 106),
                      endRadius: 90.0,
                      duration: Duration(milliseconds: 2000),
                      repeat: true,
                      showTwoGlows: true,
                      repeatPauseDuration: Duration(milliseconds: 100),
                      child: Center(
                        child: SizedBox(
                          width: 130,
                          height: 130,
                          child: CircleAvatar(
                            foregroundImage: NetworkImage(widget.imageUrl),
                            radius: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () async {
                getUrlLauncher(phoneUrl);
              },
              child: Text(
                widget.phone_number,
                style:
                    TextStyle(color: butoncolor, fontWeight: FontWeight.bold),
              )),
          TextButton(
              onPressed: () async {
                getUrlLauncher(emailUrl);
              },
              child: Text(
                widget.email,
                style:
                    TextStyle(color: butoncolor, fontWeight: FontWeight.bold),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Detail_Profile_Tile(
                  value: widget.name,
                  ontap: () {},
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Occupation",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Detail_Profile_Tile(
                  value: widget.designation,
                  ontap: () {},
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Gendar",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Detail_Profile_Tile(
                  value: widget.gender,
                  ontap: () {},
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Age",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Detail_Profile_Tile(
                  value: widget.age,
                  ontap: () {},
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Martial Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Detail_Profile_Tile(
                  value: widget.martial_status,
                  ontap: () {},
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Address",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Detail_Profile_Tile(
                  value: widget.address,
                  ontap: () {},
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Height",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Detail_Profile_Tile(
                  value: widget.height,
                  ontap: () {},
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Education",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Detail_Profile_Tile(
                  value: widget.education,
                  ontap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Linear_Profile_Tile extends StatelessWidget {
  const Linear_Profile_Tile({
    required this.value,
    required this.ontap,
  });

  final value;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}

class Detail_Profile_Tile extends StatelessWidget {
  const Detail_Profile_Tile({
    required this.value,
    required this.ontap,
  });

  final value;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              value,
              style: k14styleblack,
            ),
          ],
        ),
      ),
    );
  }
}

class kChatTextField extends StatelessWidget {
  final isPassword;
  final inputType;
  final suffixIcon;
  final hintText;
  final controller;
  final suffixWidget;
  final onChanged;
  final prefixIcon;
  final fillColor;
  final borderColor;
  final isFilled;
  final maxlines;
  kChatTextField(
      {required this.isPassword,
      required this.inputType,
      this.suffixIcon,
      required this.hintText,
      required this.controller,
      this.suffixWidget,
      this.onChanged,
      this.prefixIcon,
      this.fillColor,
      required this.borderColor,
      this.isFilled,
      this.maxlines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines,
      onChanged: onChanged,
      obscureText: isPassword,
      keyboardType: inputType,
      controller: controller,
      cursorColor: butoncolor,
      decoration: InputDecoration(
          filled: isFilled,
          contentPadding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          fillColor: fillColor,
          suffix: suffixWidget,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30))),
    );
  }
}

class buildFilterDropDown extends StatelessWidget {
  Home_page_controller controller;
  List<String> list;
  final onchange;
  final text;
  final value;
  final dropDownHeight;
  buildFilterDropDown(
      {required this.text,
      required this.list,
      required this.value,
      this.dropDownHeight = 250.0,
      required this.onchange,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isDense: true,
            isExpanded: true,
            hint: Row(
              children: [
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: k14styleblack,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: list
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: k14styleblack,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: value,
            onChanged: onchange,
            icon: Icon(
              Icons.arrow_drop_down_outlined,
            ),
            dropdownMaxHeight: dropDownHeight,
// dropdownWidth: 247,
            iconSize: 24,
            iconEnabledColor: textcolor,
            iconDisabledColor: Colors.black,
            buttonHeight: 55,
            buttonPadding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            offset: Offset(0, -20),
            buttonDecoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300,width: 0.8),
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ]),
            ),
            itemHeight: 55,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
border: Border.all(color: Colors.grey.shade300,width: 0.8),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                   Colors.white,
                   Colors.white,
                  ]),
            ),
            scrollbarRadius: const Radius.circular(16),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
          ),
        ),
      ),
    );
  }
}

class buildProfileDropDown extends StatelessWidget {
  EditProfileController controller;
  List<String> list;
  final onchange;
  final text;
  final value;
  final dropDownHeight;
  buildProfileDropDown(
      {required this.text,
      required this.list,
      required this.value,
      this.dropDownHeight = 250.0,
      required this.onchange,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 54,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isDense: true,
            isExpanded: true,
            hint: Row(
              children: [
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: k14styleblack,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: list
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: k14styleblack,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: value,
            onChanged: onchange,
            icon: Icon(
              Icons.arrow_drop_down_outlined,
            ),
            dropdownMaxHeight: dropDownHeight,
// dropdownWidth: 247,
            iconSize: 24,
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.grey.shade200,
            buttonHeight: 47,
            buttonPadding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            offset: Offset(0, -20),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.white,
// gradient: LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [
//       Color(0xFFEA7C4A),
//       Color(0xFFF1565A),
//     ]),
            ),
            itemHeight: 47,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownDecoration: BoxDecoration(
border: Border.all(color: Colors.grey.shade200,width: 0.3),
color: Colors.white,
// gradient: LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [
//       Color(0xFFEA7C4A),
//       Color(0xFFF1565A),
//     ]),
                ),
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
          ),
        ),
      ),
    );
  }
}

class buildRegisterDropDown extends StatelessWidget {
  RegisterController controller;
  List<String> list;
  final onchange;
  final text;
  final value;
  final dropDownHeight;
  buildRegisterDropDown(
      {required this.text,
      required this.list,
      required this.value,
      this.dropDownHeight = 350.0,
      required this.onchange,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isDense: true,
            isExpanded: true,
            hint: Row(
              children: [
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: k14styleblack,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: list
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: k14styleblack,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: value,
            onChanged: onchange,
            icon: Icon(
              Icons.arrow_drop_down_outlined,
            ),
            dropdownMaxHeight: dropDownHeight,
// dropdownWidth: 247,
            iconSize: 24,
            iconEnabledColor: Colors.grey,
            iconDisabledColor: Colors.grey,
            buttonHeight: 47,
            buttonPadding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            offset: Offset(0, -20),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
border: Border.all(color: Colors.grey.shade200)
            ),
            itemHeight: 47,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
color: Colors.white
),
            scrollbarRadius: const Radius.circular(16),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
          ),
        ),
      ),
    );
  }
}

class OtherNotificationWidget extends StatelessWidget {
  final String text;
  final String? postedTime;
  final Widget pic;
  final Color color;
  final String? profileImg;
  final String? message;
  final String? receiverUserId;
  final String? notificationId;

  const OtherNotificationWidget(
      {Key? key,
      this.profileImg,
      required this.text,
      this.postedTime,
      required this.pic,
      required this.color,
      required this.message,
      required this.receiverUserId,
      required this.notificationId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Services().readNotification(
            receiverUserID: receiverUserId!, notificationId: notificationId!);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 80,
        width: MediaQuery.of(context).size.width * 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarWidget(
              backgroundColor: color,
              imageWidget: pic,
              profileImg: profileImg!,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text(
                    text,
                    style: k14styleblack,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                      child: Text(
                    message!,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
            ),
            Text(
// postedTime.toString(),
              postedTime ?? '',
              style: k10stylePrimary,
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarWidget extends StatelessWidget {
  final Widget imageWidget;
  final Color backgroundColor;
  final String profileImg;
  const AvatarWidget({
    Key? key,
    required this.imageWidget,
    required this.backgroundColor,
    required this.profileImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 55,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: CachedNetworkImageProvider(profileImg),
                backgroundColor: kBaseGrey,
              ),
              Positioned(
                bottom: -1,
                right: 3,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: backgroundColor,
                    child: imageWidget,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

LinearGradient kLinearGradient() {
  return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFEA7C4A),
        Color(0xFFF1565A),
      ]);
}

class kSliderImages extends StatefulWidget {
  List<dynamic>? imagesList;
  bool islandscape;
  kSliderImages({required this.imagesList, this.islandscape = false});
  @override
  State<kSliderImages> createState() => _kSliderImagesState();
}

class _kSliderImagesState extends State<kSliderImages> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        pauseAutoPlayOnManualNavigate: true,
        viewportFraction: 1,
        initialPage: _currentIndex,
        scrollPhysics: BouncingScrollPhysics(),
        aspectRatio: 1.5,
        pauseAutoPlayOnTouch: true,
// aspectRatio: 2.3,
        enableInfiniteScroll: true,
        scrollDirection: Axis.horizontal,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeIn,
        onPageChanged: (index, reason) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
      ),
      items: widget.imagesList!
          .map(
            (item) => Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: primarycolor,
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                      image: NetworkImage(item), fit: BoxFit.fill)),
            ),
          )
          .toList(),
    );
  }
}

class kAppButton extends StatelessWidget {
  String buttonText;
  final onButtonPressed;
  bool buttonstyleSmall;
  bool roundedRight;
  bool buttonCheck;
  Color color;
  Color textColor;
  kAppButton(
      {Key? key,
      required this.buttonText,
      this.buttonstyleSmall = false,
      this.buttonCheck = false,
      this.color = Colors.deepOrange,
      this.textColor = Colors.deepOrange,
      required this.onButtonPressed,
      this.roundedRight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
// color = Color(0xfFE94057);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: buttonCheck
            ? color
            : buttonstyleSmall
                ? Colors.white
                : textcolor,
        elevation: 0,
        textStyle: buttonCheck
            ? TextStyle(
                color: textColor, fontWeight: FontWeight.w600, fontSize: 16)
            : buttonstyleSmall
                ? TextStyle(
                    color: textColor, fontWeight: FontWeight.w600, fontSize: 16)
                : TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: buttonCheck
                  ? Colors.grey.shade300
                  : buttonstyleSmall
                      ? Colors.grey.shade300
                      : textcolor),
          borderRadius: roundedRight
              ? BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16))
              : BorderRadius.all(Radius.circular(16)),
        ),
      ),
      onPressed: onButtonPressed,
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: buttonCheck
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(buttonText,
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                ],
              )
            : Text(
                buttonText,
                style: buttonstyleSmall
                    ? TextStyle(
                        color: textcolor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)
                    : TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
              ),
      ),
    );
  }
}

Align alreadyHaveAnAccount(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => LoginScreen2());
          },
          child: Text(
            "Sign in",
            style: TextStyle(
                fontWeight: FontWeight.w700, color: primarycolor, fontSize: 14),
          ),
        ),
      ],
    ),
  );
}

Align kdontHaveAnAccount(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account ",
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => SignUpScreen());
          },
          child: Text(
            "Sign up",
            style: TextStyle(
                fontWeight: FontWeight.w700, color: textcolor, fontSize: 14),
          ),
        ),
      ],
    ),
  );
}

class kFullScreenImageViewer extends StatelessWidget {
  const kFullScreenImageViewer(this.url, {Key? key}) : super(key: key);
  final url;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: AppComponents().backIcon(() {
                Get.back();
              }),
            ),
            preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
            tag: 'image',
            child: Image.network(url.toString(),width: MediaQuery.of(context).size.width,),
          ),
        ),
      ),
    );
  }
}

class kFullScreenImageViewerList extends StatelessWidget {
  const kFullScreenImageViewerList(this.url, {Key? key}) : super(key: key);
  final List<dynamic> url;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: AppComponents().backIcon(() {
                Get.back();
              }),
            ),
            preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
            itemCount: url.length,
            itemBuilder: (BuildContext context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          (index + 1).toString() + "/" + url.length.toString(),
                          style: k14styleblack,
                        )
                      ],
                    ),
                  ),
                  AppComponents().sizedBox10,
                  Expanded(
                    child: Center(
                      child: Hero(
                        tag: 'image',
                        child: Image.network(url[index].toString()),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
