import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jabwemeet/Models/chatroom.model.dart';
import 'package:jabwemeet/Models/messaging.model/messages.model.dart';
import 'package:jabwemeet/Models/messaging.model/personmessage.model.dart';
import 'package:uuid/uuid.dart';

class MessageController extends GetxController {
  ScrollController newMessageScroll = ScrollController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? message;
  TextEditingController messagetextfieldController = TextEditingController();
  String writtenMessage = '';
  bool isTyping = false;
  File? messageImage;
  String? downloadUrl = "";
  double? percentage;
  var snapshot;

  var getMesssages;
  var getpostsIds;

  List<Map<String, dynamic>> postsId = [];

  List<Map<String, dynamic>> communityId = [];

  List<String> postsIds = [];
  List<String> communityIds = [];

//  StreamController<int> messagesStream = StreamController();
//  Stream<QuerySnapshot> get Messages => messagesStream.stream<QuerySnapshot>;

  @override
  void dispose() {
    newMessageScroll.dispose();
    messagetextfieldController.dispose();
    // messagesStream.close();
    super.dispose();
  }

  Future<void> seeMsg(var docid, var sender) async {
    log("<============= Inside SeeMsg Function =============>");
    try {
      log("Inside Try");
      await FirebaseFirestore.instance
          .collection('chatrooms')
          .where('participants.${FirebaseAuth.instance.currentUser!.uid}',
              isEqualTo: true)
          .get()
          .then((snapshot) {
        update();
        log("Snapshot size is ${snapshot.size.toString()}");
        snapshot.docs.forEach((element) {
          if (element.id == docid) {
            if (element.get("lastMesgUserId") !=
                FirebaseAuth.instance.currentUser!.uid) {
              element.reference.update({"isReadReceiver": true});
            } else {
              element.reference.update({"isReadSender": true});
            }
          }
          ;
        });
      });
    } on FirebaseException catch (e) {
      log("Inside Catch");
      log(e.code);
    }
  }

  onChanged(value) {
    writtenMessage = value;
    update();
  }

  uploadMessage(String message, bool isMe) {
    messagetextfieldController.clear();
    final newMessage =
        personMessages(message: writtenMessage, isMe: true, isContinue: false);
    messagingList.add(newMessage);
    update();
  }

  //send the message
  sendMessage(BuildContext context, ChatRoomModel chatroomId) {
    message = messagetextfieldController.text.trim();
    messagetextfieldController.clear();

    if (message == '') {
    } else {
      User? user = _firebaseAuth.currentUser;
      MessageModel messagesModel = MessageModel(
        sender: user!.uid,
        message: message,
        // isread: false,
        createTime: DateTime.now(),
        messageId: Uuid().v1(),
      );

      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(chatroomId.toString())
          .collection('messages')
          .doc(messagesModel.messageId)
          .set(messagesModel.toMap());

      log('Message sent by me');
    }
  }

  Future messagingImage(ChatRoomModel chatroom) async {
    try {
      XFile? imagePick =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imagePick != null) {
        File convertedFile = File(imagePick.path);
        messageImage = convertedFile;
        update();
        uploadMessageImage(chatroom);
      } else {
        return;
      }
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  //upload image in message
  uploadMessageImage(ChatRoomModel chatRoomModel) async {
    User user = FirebaseAuth.instance.currentUser!;
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('images')
        .child(Uuid().v1())
        .putFile(messageImage!);

    StreamSubscription listenEvent = uploadTask.snapshotEvents.listen((data) {
      percentage = (data.bytesTransferred / data.totalBytes);
      update();
      if (data.state == TaskState.success) {
        percentage = null;

        log('Our image uploading done');
      }

      log('This is our uploading image task : ${percentage.toString()}');
    });

    ;

    TaskSnapshot taskSnapshot = await uploadTask;
    downloadUrl = await taskSnapshot.ref.getDownloadURL();
    listenEvent.cancel();

    log(downloadUrl!);

    //upload the data

    MessageModel messagesModel = MessageModel(
      sender: user.uid,
      message: downloadUrl,
      createTime: DateTime.now(),
      messageId: Uuid().v1(),
    );
    await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomModel.chatRoomId)
        .collection('messages')
        .doc(messagesModel.messageId)
        .set(messagesModel.toMap());
    chatRoomModel.lastMessage != downloadUrl;

    await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomModel.chatRoomId)
        .set(chatRoomModel.toMap());
  }

  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('chatrooms');

  Stream<QuerySnapshot> messages(ChatRoomModel chatRoomModel) =>
      _collectionReference
          .doc(chatRoomModel.chatRoomId)
          .collection('messages')
          .orderBy('createtime', descending: false)
          .snapshots();

  listeningForMessages(ChatRoomModel chatRoomModel) {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomModel.chatRoomId)
        .collection('messages')
        .orderBy('createtime', descending: false)
        .snapshots();
  }

  Future<QuerySnapshot?> getAllChats() async {
    User? user = _firebaseAuth.currentUser;
    QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where('participants.${user!.uid}', isEqualTo: true)
        .get();

    return snapShot;
  }

  //get the current user uid
  Future<DocumentSnapshot?> getUserUid(List<String> participantKeys) async {
    DocumentSnapshot getCurrentUserIdFromList = await FirebaseFirestore.instance
        .collection('users')
        .doc(participantKeys[0])
        .get();
    return getCurrentUserIdFromList;
  }

  //show the post if the current message contains id from the posts id
  Stream<QuerySnapshot?> getPostsIds() async* {
    FirebaseFirestore.instance
        .collection("communityposts")
        .snapshots()
        .listen((event) {
      for (var index in event.docs) {}
    });
  }

  //get the messages
  Stream<DocumentSnapshot> getMessages(String chatroomId) async* {
    yield* FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatroomId)
        .snapshots();
  }

  bool unreadMessagesAvailable = false;

  int numberOfUnreadMessages = 0;
  CollectionReference _chatRoomCollection =
      FirebaseFirestore.instance.collection("chatrooms");
  newMessages() {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    _chatRoomCollection
        .where("isReadReceiver", isEqualTo: false)
        .where("participants.${userUid}", isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.size > 0) {
        // log("Unread Messages Found");
        snapshot.docs.forEach((documentSnapshot) {
          if (documentSnapshot.get("lastMesgUserId") !=
              FirebaseAuth.instance.currentUser!.uid) {
            numberOfUnreadMessages = numberOfUnreadMessages + 1;
            update();
            // log("Count of unread messages: $numberOfUnreadMessages");
          }
        });
        if (numberOfUnreadMessages > 0) {
          unreadMessagesAvailable = true;
          numberOfUnreadMessages = 0;
          update();
          // log("Count of unread messages set to Zero: $numberOfUnreadMessages");

        } else {
          unreadMessagesAvailable = false;
          update();
          // log("Count of unread messages set to Zero: $numberOfUnreadMessages");

        }
      } else {
        // log("No Unread Messages Found");
        unreadMessagesAvailable = false;
        update();
      }
    });
  }
}
