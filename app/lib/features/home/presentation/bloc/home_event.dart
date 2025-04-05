part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeBookEvent extends HomeEvent {
  final int massage_id;
  final String booking_time;
  final String email;

  const HomeBookEvent({required this.massage_id, required this.booking_time, required this.email});
}


class HomeGetAllMassageTypeEvent extends HomeEvent{

}

class HomeGetHistoryEvent extends HomeEvent{
  final String id;

  const HomeGetHistoryEvent(this.id);
}