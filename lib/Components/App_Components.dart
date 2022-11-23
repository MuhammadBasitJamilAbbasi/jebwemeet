import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jabwemeet/Utils/constants.dart';

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
        fillColor: Colors.white,
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
                    semanticLabel: 'Show password',
                  )
                : Icon(
                    Icons.visibility,
                    color: primarycolor,
                    semanticLabel: 'Show password',
                  ),
            onPressed: onpress),
        contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
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
      height: 50,
      width: MediaQuery.of(context).size.width * 0.70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        color: butoncolor,
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
          color: primaryColor,
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
