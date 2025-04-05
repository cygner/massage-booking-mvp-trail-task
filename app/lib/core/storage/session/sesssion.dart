import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SessionKey { isLoggedIn, userName, userEmail, userID, fcmToken }

class SessionManager {
  static final storage = FlutterSecureStorage();

  static Future<void> setLoggedIn(bool b) async {
    return await storage.write(
      key: SessionKey.isLoggedIn.name,
      value: b ? "true" : "false",
    );
  }

  static Future<void> setUserName(String name) async {
    return await storage.write(
      key: SessionKey.userName.name,
      value: name,
    );
  }

  static Future<void> setUserEmail(String email) async {
    return await storage.write(
      key: SessionKey.userEmail.name,
      value: email,
    );
  }

  static Future<void> setUserID(String id) async {
    return await storage.write(
      key: SessionKey.userID.name,
      value: id,
    );
  }


  static Future<void> setFCMToken(String key) async {
    return await storage.write(
      key: SessionKey.fcmToken.name,
      value: key,
    );
  }


  static Future<bool> isLoggedIn() async {
    var isLoggedIn = await storage.read(key: SessionKey.isLoggedIn.name);
    return isLoggedIn == "true";
  }

  static Future<Map> getUserData() async {
    var name = await storage.read(key: SessionKey.userName.name);
    var email = await storage.read(key: SessionKey.userEmail.name);
    return {
      "name": name ?? "",
      "email": email ?? "",
    };
  }

  static Future<String> getUserName() async {
    var name = await storage.read(key: SessionKey.userName.name);
    return name ?? "";
  }

  static Future<String> getUserEmail() async {
    var email = await storage.read(key: SessionKey.userEmail.name);
    return email ?? "";
  }


  static Future<String> getUserID() async {
    var id = await storage.read(key: SessionKey.userID.name);
    return id ?? "";
  }


  static Future<String> getFCMToken() async {
    var key = await storage.read(key: SessionKey.fcmToken.name);
    return key ?? "";
  }

  static Future<void> clear() async {
    await storage.deleteAll();
  }


}
