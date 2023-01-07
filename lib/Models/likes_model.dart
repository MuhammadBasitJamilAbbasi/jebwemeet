class LikesModel {
  String? likeId;
  Map<String, dynamic>? participants;
  String? isSender;
  String? isReceiver;
  String? isSenderImage;
  String? isReceiverImage;
  String? isReceiverName;
  String? isSenderName;

  LikesModel({
    this.likeId,
    this.participants,
    this.isReceiver,
    this.isSender,
    this.isReceiverImage,
    this.isReceiverName,
    this.isSenderName,
    this.isSenderImage,
  });

  LikesModel.fromMap(Map<String, dynamic> map) {
    likeId = map['likeId'];
    participants = map['participants'];
    isReceiver = map['isReceiver'];
    isSender = map['isSender'];
    isReceiverImage = map['isReceiverImage'];
    isReceiverName = map['isReceiverName'];
    isSenderName = map['isSenderName'];
    isSenderImage = map['isSenderImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'likeId': likeId,
      'participants': participants,
      'isReceiver': isReceiver,
      'isSender': isSender,
      'isReceiverImage': isReceiverImage,
      'isReceiverName': isReceiverName,
      'isSenderName': isSenderName,
      'isSenderImage': isSenderImage,
    };
  }
}
