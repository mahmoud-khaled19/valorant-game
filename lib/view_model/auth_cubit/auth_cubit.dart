import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(LoginInitial());

  bool isVisible = false;

  void changePasswordVisibility() {
    isVisible = !isVisible;
    emit(ChangePasswordVisibility());
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(RegisterWithEmailLoadingState());
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    emit(RegisterWithEmailSuccessState());
  }

  AuthCubit get(context) => BlocProvider.of(context);
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginInWithEmailLoadingState());
    await auth.signInWithEmailAndPassword(email: email, password: password);
    emit(LoginInWithEmailSuccessState());
  }
}
