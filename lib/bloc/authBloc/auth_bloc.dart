import 'package:fit_fusion/data/models/user_model.dart';
import 'package:fit_fusion/data/repository/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _repository;
  AuthBloc(this._repository) : super(AuthInitial()) {
    on<RegisterEvent>(_signUp);
    on<LoginEvent>(_logIn);
    on<LoginStatus>(_checkLoginStatus);
  }

  _checkLoginStatus(LoginStatus event, Emitter<AuthState> emit) async {
    emit(Loading());
    final res = await _repository.getLogin();
    if (res) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }

  _signUp(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(Loading());
    final res = await _repository.saveUser(event.user);

    if (res) {
      emit(Registered());
      emit(Authenticated());
    } else {
      emit(const AuthError(message: 'No data is saved'));
    }
  }

  _logIn(LoginEvent event, Emitter<AuthState> emit) async {
    emit(Loading());
    final res = await _repository.getUser();
    if (res!.email == event.email) {
      emit(Authenticated());
    } else {
      emit(const AuthError(message: 'Invalid Email entered'));
    }
  }
}
