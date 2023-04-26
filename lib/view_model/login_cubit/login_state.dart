abstract class LoginState {}

class LoginInitial extends LoginState {}

class RegisterWithEmailLoadingState extends LoginState {}

class RegisterWithEmailSuccessState extends LoginState {}

class RegisterWithEmailErrorState extends LoginState {}

class LoginInWithEmailLoadingState extends LoginState {}

class LoginInWithEmailSuccessState extends LoginState {}

class LoginInWithEmailErrorState extends LoginState {}

class LoginInWithGmailLoadingState extends LoginState {}

class LoginInWithGmailSuccessState extends LoginState {}

class LoginInWithGmailErrorState extends LoginState {}
