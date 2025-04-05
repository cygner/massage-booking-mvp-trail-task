import 'package:booking_app_mvp_test/features/home/domain/entities/massage.dart';
import 'package:equatable/equatable.dart';

class Book extends Equatable{
  final int id;
  final String booking_time;
  final Massage massage_id;

  const Book({required this.id, required this.booking_time, required this.massage_id});

  @override
  List<Object> get props => [id]; // Add all properties here
}