import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  String? chatRoomId;
  Map<String, dynamic>? participants;
  String? lastMessage;
  String? lastMesgUserId;
  bool? isReadSender;
  bool? isReadReceiver;
   DateTime? lastMessageTime;
  List<dynamic>? typing;

  ChatRoomModel(
      {this.chatRoomId,
      this.participants,
      this.lastMessage,
      this.lastMessageTime,
      this.lastMesgUserId,
      this.typing,
      this.isReadReceiver,
      this.isReadSender});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    lastMessage = map['lastMessage'];
    chatRoomId = map['chatroomId'];
    isReadSender = map['isReadSender'];
    isReadReceiver = map['isReadReceiver'];
    lastMesgUserId = map['lastMesgUserId'];
    lastMessageTime = map['lastMessageTime'] ==null ? null : (map['lastMessageTime'] as Timestamp).toDate();
    participants = map['participants'];
    typing = map['typing'];
  }

  Map<String, dynamic> toMap() {
    return {
      'chatroomId': chatRoomId,
      'isReadReceiver': isReadReceiver,
      'isReadSender': isReadSender,
      'lastMessageTime': lastMessageTime,
      'participants': participants,
      'lastMesgUserId': lastMesgUserId,
      'lastMessage': lastMessage,
      'typing': typing
    };
  }
}
