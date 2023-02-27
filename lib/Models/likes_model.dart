class LikesModel {
  String? likeId;
  Map<String, dynamic>? participants;
  String? isSender;
  int? isSenderAge;
  String? isSenderAddress;
  String? isReceiver;
  int? isReceiverAge;
  String? isReceiverAddress;
  String? isSenderImage;
  String? isReceiverImage;
  String? isReceiverName;
  String? isSenderName;

  LikesModel({
    this.likeId,
    this.participants,
    this.isReceiver,
    this.isSender,
    this.isReceiverAge,
    this.isSenderAge,
    this.isReceiverAddress,
    this.isSenderAddress,
    this.isReceiverImage,
    this.isReceiverName,
    this.isSenderName,
    this.isSenderImage,
  });

  LikesModel.fromMap(Map<String, dynamic> map) {
    isSenderAddress = map['isSenderAddress'];
    isReceiverAddress = map['isReceiverAddress'];
    isReceiverAge = map['isReceiverAge'];
    isSenderAge = map['isSenderAge'];
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
      'isSenderAge': isSenderAge,
      'isReceiverAge': isReceiverAge,
      'isReceiverAddress': isReceiverAddress,
      'isSenderAddress': isSenderAddress,
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
