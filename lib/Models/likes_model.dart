import 'package:cloud_firestore/cloud_firestore.dart';

class LikesModel {
  String? likeId;
  Map<String, dynamic>? participants;
  String? isSender;
  String? isReceiver;

  LikesModel({
    this.likeId,
    this.participants,
    this.isReceiver,
    this.isSender,
  });

  LikesModel.fromMap(Map<String, dynamic> map) {
    likeId = map['likeId'];
    participants = map['participants'];
    isReceiver = map['isReceiver'];
    isSender = map['isSender'];
  }

  Map<String, dynamic> toMap() {
    return {
      'likeId': likeId,
      'participants': participants,
      'isReceiver': isReceiver,
      'isSender': isSender,
    };
  }
}
