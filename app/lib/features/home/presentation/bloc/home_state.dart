part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}
class HomeBooked extends HomeState {
  final int id;

  const HomeBooked(this.id);
}

class HomeAllMassageTypeLoaded extends HomeState {
  final List<Massage> massages;

  const HomeAllMassageTypeLoaded(this.massages);
}

class HomeLoaded extends HomeState {
  final Home home;

  const HomeLoaded(this.home);

  @override
  List<Object> get props => [home];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
