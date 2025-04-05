import 'package:equatable/equatable.dart';

import 'book.dart';

class Home extends Equatable {
  // Add your entity properties here
  final List<Book> orders;
  const Home(this.orders);

  @override
  List<Object> get props => [orders]; // Add all properties here
}
