class MessageModel {
  String? sender, message, messageId;
  DateTime? createTime;
  bool? isread;
  MessageModel(
      {this.sender,
      this.message,
      this.isread,
      this.createTime,
      this.messageId});

  //From map function to get the data from the firebase
  MessageModel.fromMap(Map<String, dynamic> map) {
    sender = map['sender'];
    message = map['message'];
    isread = map['isread'];
    createTime = map['createtime'].toDate();
    messageId = map['messageId'];
  }

//to map function to send the send to firebase
  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'message': message,
      'isread': isread,
      'createtime': createTime,
      'messageId': messageId,
    };
  }
}
