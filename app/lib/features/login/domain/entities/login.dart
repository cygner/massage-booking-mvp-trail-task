import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String id,name, email, firebaseToken;

  const Login(this.id,this.name, this.email, this.firebaseToken);

  @override
  List<Object> get props => [id,name,email,firebaseToken]; // Add all properties here
}
