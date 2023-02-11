// StreamBuilder<DocumentSnapshot>(
// stream: FirebaseFirestore.instance
//     .collection("users")
//     .doc(widget.uid)
//     .snapshots(),
// builder: (context, snapshot) {
// if (!snapshot.hasData) {
// return Center(
// child: CircularProgressIndicator(),
// );
// } else if (!snapshot.hasData ||
// snapshot.hasError ||
// snapshot.data == null) {
// return Center(
// child: Padding(
// padding: const EdgeInsets.only(top: 68.0),
// child: Text(
// "No data Yet...",
// style: TextStyle(
// fontSize: 20, color: Colors.black),
// ),
// ),
// );
// }
// userModel = UserModel.fromMap(
// snapshot.data!.data() as Map<String, dynamic>);
// return Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20),
// child: SingleChildScrollView(
// physics: BouncingScrollPhysics(),
// child: Column(
// children: [
// AppComponents().sizedBox30,
// Center(
// child: SizedBox(
// width: 130,
// height: 130,
// child: CircleAvatar(
// foregroundImage: NetworkImage(
// userModel!.imageUrl.toString()),
// radius: 10,
// ),
// ),
// )
// // Container(
// //   height: 300,
// //   child: Stack(children: [
// //     CarouselSlider(
// //       options: CarouselOptions(
// //         autoPlay: true,
// //         viewportFraction: 1,
// //         aspectRatio: 1.5,
// //         enlargeCenterPage: true,
// //         onPageChanged: (index, reason) {},
// //       ),
// //       items: userModel!.imagesList!
// //           .map(
// //             (item) => Padding(
// //               padding:
// //                   const EdgeInsets.only(top: 8),
// //               child: ClipRRect(
// //                 borderRadius: BorderRadius.all(
// //                   Radius.circular(10.0),
// //                 ),
// //                 child: GestureDetector(
// //                   onTap: () {},
// //                   child: Container(
// //                     height: 300,
// //                     width:
// //                         MediaQuery.of(context)
// //                             .size
// //                             .width,
// //                     decoration: BoxDecoration(
// //                         borderRadius:
// //                             BorderRadius
// //                                 .circular(15.0),
// //                         gradient:
// //                             LinearGradient(
// //                           begin:
// //                               Alignment.topLeft,
// //                           end: Alignment
// //                               .bottomRight,
// //                           colors: [
// //                             butoncolor
// //                                 .withOpacity(
// //                                     0.3),
// //                             butoncolor
// //                                 .withOpacity(
// //                                     0.1),
// //                           ],
// //                         )),
// //                     child: Image.network(
// //                       item,
// //                       fit: BoxFit.fill,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           )
// //           .toList(),
// //     ),
// //     Positioned(
// //       top: 120,
// //       left: 20,
// //       right: 20,
// //       child: Center(
// //         child: AvatarGlow(
// //           glowColor:
// //               Color.fromARGB(255, 15, 233, 106),
// //           endRadius: 90.0,
// //           duration:
// //               Duration(milliseconds: 2000),
// //           repeat: true,
// //           showTwoGlows: true,
// //           repeatPauseDuration:
// //               Duration(milliseconds: 100),
// //           child: Center(
// //             child: SizedBox(
// //               width: 130,
// //               height: 130,
// //               child: CircleAvatar(
// //                 foregroundImage: NetworkImage(
// //                     userModel!.imageUrl
// //                         .toString()),
// //                 radius: 10,
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     )
// //   ]),
// // ),
// ,
// userModel!.about.toString() == "null"
// ? SizedBox.shrink()
//     : Align(
// alignment: Alignment.topLeft,
// child: Text(
// "About",
// style: k18styleblack,
// ),
// ),
// userModel!.about.toString() != "null"
// ? Detail_Profile_Tile(
// value: userModel!.about.toString(),
// ontap: () {},
// )
//     : SizedBox.shrink(),
// Align(
// alignment: Alignment.topLeft,
// child: Text(
// "Name",
// style: k18styleblack,
// ),
// ),
// Detail_Profile_Tile(
// value: userModel!.name.toString(),
// ontap: () {},
// ),
// Align(
// alignment: Alignment.topLeft,
// child: Text(
// "Occupation",
// style: k18styleblack,
// ),
// ),
// Detail_Profile_Tile(
// value: userModel!.work.toString(),
// ontap: () {},
// ),
// Align(
// alignment: Alignment.topLeft,
// child: Text(
// "Job Title",
// style: k18styleblack,
// ),
// ),
// Detail_Profile_Tile(
// value: userModel!.job_title.toString(),
// ontap: () {},
// ),
// Align(
// alignment: Alignment.topLeft,
// child: Text(
// "Age",
// style: k18styleblack,
// ),
// ),
// Detail_Profile_Tile(
// value: userModel!.age.toString(),
// ontap: () {},
// ),
// Align(
// alignment: Alignment.topLeft,
// child: Text(
// "Martial Status",
// style: k18styleblack,
// ),
// ),
// Detail_Profile_Tile(
// value: userModel!.martial_status.toString(),
// ontap: () {},
// ),
// Align(
// alignment: Alignment.topLeft,
// child: Text(
// "Address",
// style: k18styleblack,
// ),
// ),
// Detail_Profile_Tile(
// value: userModel!.address.toString(),
// ontap: () {},
// ),
// Align(
// alignment: Alignment.topLeft,
// child: Text(
// "Height",
// style: k18styleblack,
// ),
// ),
// Detail_Profile_Tile(
// value: userModel!.height.toString(),
// ontap: () {},
// ),
// Align(
// alignment: Alignment.topLeft,
// child: Text(
// "Education",
// style: k18styleblack,
// ),
// ),
// Detail_Profile_Tile(
// value: userModel!.education.toString(),
// ontap: () {},
// ),
// ],
// ),
// ),
// );
// },
// ),