import 'package:booking_app_mvp_test/core/usecases/usecase.dart';
import 'package:booking_app_mvp_test/features/home/domain/entities/massage.dart';
import 'package:booking_app_mvp_test/features/home/domain/usecases/home_book_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/home.dart';
import '../../domain/usecases/home_massage_type_usecase.dart';
import '../../domain/usecases/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase usecase;
  final HomeBookUsecase bookingUsecase;
  final HomeMassageTypeUsecase homeMassageTypeUsecase;

  HomeBloc({
    required this.usecase,
    required this.bookingUsecase,
    required this.homeMassageTypeUsecase,
  }) : super(HomeInitial()) {
    on<HomeBookEvent>((event, emit) async {
      emit(HomeLoading());
      var failOrBook = await bookingUsecase(
        BookParams(
          massage_id: event.massage_id,
          booking_time: event.booking_time,
          email: event.email,
        ),
      );
      failOrBook.fold(
        (fail) => emit(HomeError(message: fail.message)),
        (book) => emit(HomeBooked(book)),
      );
    });

    on<HomeGetAllMassageTypeEvent>((event, emit) async {
      emit(HomeLoading());
      var failOrMassages = await homeMassageTypeUsecase(NoParams());
      failOrMassages.fold(
        (fail) => emit(HomeError(message: fail.message)),
        (massages) => emit(HomeAllMassageTypeLoaded(massages)),
      );
    });

    on<HomeGetHistoryEvent>((event, emit) async {
      emit(HomeLoading());
      var failOrHome = await usecase(event.id);
      failOrHome.fold(
        (fail) => emit(HomeError(message: fail.message)),
        (home) => emit(HomeLoaded(home)),
      );
    });
  }
}
