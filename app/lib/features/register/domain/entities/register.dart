import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final String id,name, email, firebaseToken;

  const Register(this.id,this.name, this.email, this.firebaseToken);

  @override
  List<Object> get props => [id,name,email,firebaseToken]; // Add all properties here
}
