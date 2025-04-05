
part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
    const SplashState();

    @override
    List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {
final Splash splash;

const SplashLoaded(this.splash);

@override
List<Object> get props => [splash];
}

class SplashError extends SplashState {
final String message;

const SplashError({required this.message});

@override
List<Object> get props => [message];
}
