import 'package:equatable/equatable.dart';

class Massage extends Equatable {
  // Add your entity properties here
  final int id;
  final String name;
  final int price;

  const Massage({required this.id, required this.name, required this.price});

  @override
  List<Object> get props => [id]; // Add all properties here
}
