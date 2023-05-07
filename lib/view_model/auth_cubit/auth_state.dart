abstract class AuthState {}

class LoginInitial extends AuthState {}

class ChangePasswordVisibility extends AuthState {}

class ChangeImage extends AuthState {}

class ChangeAppMode extends AuthState {}

class CropImage extends AuthState {}

class CurveAnimationState extends AuthState {}

class RegisterWithEmailLoadingState extends AuthState {}

class RegisterWithEmailSuccessState extends AuthState {}

class RegisterWithEmailErrorState extends AuthState {}

class LoginInWithEmailLoadingState extends AuthState {}

class LoginInWithEmailSuccessState extends AuthState {}

class LoginInWithEmailErrorState extends AuthState {}

class GetUserDataLoadingState extends AuthState {}

class GetUserDataSuccessState extends AuthState {}

class GetUserDataErrorState extends AuthState {}
