import 'dart:developer';

import 'package:encrypt/encrypt.dart';

class EncryptData {
  static String encryptData({required final password}) {
    final key = Key.fromUtf8("12345678912345678912345678912345");
    final iv = IV.fromLength(16);
    final encryptor = Encrypter(AES(key));
    final encryptedPassword = encryptor.encrypt(password, iv: iv);
    log("Encrypted Password Is with base 64 : ${encryptedPassword.base64}");
    log("Encrypted Password Is without base 64: ${encryptedPassword.toString()}");
    return encryptedPassword.base64;
  }

  static dynamic decryptData({required final encryptedPassword}) {
    log("<--------Encrypted Password----------->");
    log(encryptedPassword.toString());
    final key = Key.fromUtf8("12345678912345678912345678912345");
    final iv = IV.fromLength(16);
    final encryptor = Encrypter(AES(key));
    final decryptedPassword =
        encryptor.decrypt(Encrypted.from64(encryptedPassword), iv: iv);
    log("descrypted Password Is : ${decryptedPassword}");
    return decryptedPassword;
  }
}
