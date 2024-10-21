import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/auth_controller.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthController _authController;

  AuthBloc(this._authController) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    // Basic form validation
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(const AuthFailure('Email and password cannot be empty'));
      return;
    }

    // Email format validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(event.email)) {
      emit(const AuthFailure('Invalid email format'));
      return;
    }

    try {
      final user = await _authController.login(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
