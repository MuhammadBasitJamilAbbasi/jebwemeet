import 'dart:core';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Utils/constants.dart';
import 'package:jabwemeet/Views/Home/Controllers/home_page_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class AppComponents {
  Row backIcon() {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xfFf1565A),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 3),
            child: GestureDetector(
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }

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
  final maxlines;
  bool isLength;
  bool isValidator;
  kCustomTextField(
      {required this.hinttext,
      required this.controller,
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
      style: TextStyle(color: Colors.black, fontSize: 14),
      keyboardType: isLength ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: Color(0xFFF4F0EE),
        hintText: hinttext,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(
            25,
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
  bool isObsecure;
  var onpress;
  final TextEditingController controller;
  final String hintText;
  final label;
  final TextInputType textInputType;

  kPasswordTextField(
      {required this.validator,
      required this.controller,
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
        contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
        filled: true,
        fillColor: Color(0xFFF4F0EE),
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(
            25,
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
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        height: 8,
        width: MediaQuery.of(context).size.width / 9,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(25)),
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
  Essential_Widget(
      {required this.title, required this.leadingImage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Image.asset(
                  leadingImage,
                  height: 20,
                  width: 20,
                  color: butoncolor,
                )),
            Expanded(
                flex: 16,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    title,
                    style: k12styleblack,
                  ),
                )),
            Expanded(
                flex: 1,
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: butoncolor,
                  size: 18,
                )),
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
          style: TextStyle(color: color, fontSize: 20),
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
          contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
          hintText: hintText,
          hintStyle: TextStyle(color: borderColor, fontSize: 13),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          fillColor: fillColor,
          suffix: suffixWidget,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
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
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: AvatarGlow(
              glowColor: Color.fromARGB(255, 15, 233, 106),
              endRadius: 90.0,
              duration: Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              child: DottedBorder(
                radius: Radius.circular(10),
                color: Colors.blue,
                strokeWidth: 8,
                borderType: BorderType.Circle,
                dashPattern: [1, 12],
                strokeCap: StrokeCap.butt,
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
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Name",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Linear_Profile_Tile(
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
          Linear_Profile_Tile(
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
          Linear_Profile_Tile(
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
          Linear_Profile_Tile(
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
          Linear_Profile_Tile(
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
          Linear_Profile_Tile(
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
          Linear_Profile_Tile(
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
          Linear_Profile_Tile(
            value: widget.education,
            ontap: () {},
          ),
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
  buildFilterDropDown(
      {required this.text,
      required this.list,
      required this.value,
      required this.onchange,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 47,
        margin: EdgeInsets.symmetric(horizontal: 30),
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
                    style: k14styleWhite,
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
                        style: k14styleWhite,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: value,
            onChanged: onchange,
            icon: Icon(
              Icons.arrow_drop_down_outlined,
            ),
            // dropdownMaxHeight: 50,
            // dropdownWidth: 247,
            iconSize: 24,
            iconEnabledColor: Colors.white,
            iconDisabledColor: Colors.grey,
            buttonHeight: 47,
            buttonPadding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            offset: Offset(0, -20),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFEA7C4A),
                    Color(0xFFF1565A),
                  ]),
            ),
            itemHeight: 47,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFEA7C4A),
                    Color(0xFFF1565A),
                  ]),
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

LinearGradient kLinearGradient() {
  return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFEA7C4A),
        Color(0xFFF1565A),
      ]);
}
