import '../../domain/entities/register.dart';

class RegisterModel extends Register {
  const RegisterModel(super.id, super.name, super.email, super.firebaseToken);

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      json['id'],
      json['name'],
      json['email'],
      json['firebase_token'] ?? "",
    );
  }

  factory RegisterModel.empty() {
    return RegisterModel("", "", "", "");
  }

  Map<String, dynamic> toJson() {
    return {
      "id": name,
      "name": name,
      "email": email,
      "firebase_token": firebaseToken,
    };
  }
}
