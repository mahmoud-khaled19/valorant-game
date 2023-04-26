import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  LoginCubit get(context) => BlocProvider.of(context);
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginInWithEmailLoadingState());
    await auth.signInWithEmailAndPassword(email: email, password: password);
    emit(LoginInWithEmailSuccessState());
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(RegisterWithEmailLoadingState());
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    emit(RegisterWithEmailSuccessState());
  }
}
