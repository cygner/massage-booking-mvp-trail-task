
part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
    const RegisterEvent();

    @override
    List<Object> get props => [];
    
}

class RegisterWithEmailEvent extends RegisterEvent{
    final RegisterParams params;

  const RegisterWithEmailEvent(this.params);
}