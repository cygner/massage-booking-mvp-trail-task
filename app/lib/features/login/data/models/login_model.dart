import '../../domain/entities/login.dart';

class LoginModel extends Login {
  const LoginModel(super.id,super.name, super.email, super.firebaseToken);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(json['id'],json['name'], json['email'], json['firebase_token']??"");
  }
  factory LoginModel.empty() {
    return LoginModel("","", "", "");
  }

  Map<String, dynamic> toJson() {
    return {"id": id,"name": name, "email": email, "firebase_token": firebaseToken};
  }
}
