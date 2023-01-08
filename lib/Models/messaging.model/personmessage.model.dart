
class personMessages {
  final bool isMe;
  final String message;
  final bool   isContinue;

  personMessages({ required this.isContinue,  required this.message, required this.isMe});
}

List<personMessages> messagingList = [
  personMessages(
    isContinue: true,
    isMe: true,
    message: 'Hello, How are you',
  ),
  personMessages(
    isContinue: false,
    isMe: false,
    message: 'I am fine',
  ),
  personMessages(
    isContinue: true,
    isMe: false,
    message: 'What about you',
  
  ),
  personMessages(
    isContinue: false,
    isMe: true,
    message: 'I am also fine',
  ),
  personMessages(
    isContinue: false,
    isMe: true,
    message: 'What are you doing',
  ),
  personMessages(
    isContinue: false,
    isMe: true,
    message: 'I am driving the car and going to Karachi ',
  ),
  personMessages(
    isContinue: true,
    isMe: true,
    message: 'Ok see you later , bye!',
  ),
  personMessages(
    isContinue: false,
    isMe: false,
    message: 'Bye! See you',
  ),
  personMessages(
    isContinue: true,
    isMe: false,
    message: 'Have a safe journey',
  ),
   
];
