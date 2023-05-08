import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workers/view/screens/auth/user_login_states_screen.dart';
import '../../app_constance/global_methods.dart';
import '../../view/screens/auth/login_screen.dart';
import '../../view/screens/home/home_screen/home_screen.dart';
import 'auth_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(LoginInitial());

  AuthCubit get(context) => BlocProvider.of(context);
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore authStore = FirebaseFirestore.instance;
  final FirebaseStorage authStorage = FirebaseStorage.instance;

  bool isVisible = true;
  File? imageFile;
  XFile? pickedFile;

  void changePasswordVisibility() {
    isVisible = !isVisible;
    emit(ChangePasswordVisibility());
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String phone,
    required String name,
    required String image,
    required String position,
    required Timestamp time,
    required BuildContext context,
  }) async {
    try {
      emit(RegisterWithEmailLoadingState());

      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        final userId = auth.currentUser?.uid;
        GlobalMethods.showSnackBar(
            context, 'Email Created Successfully', Colors.green);
        final ref =
            authStorage.ref().child('user Images').child('$userId+ .jpg');
        await ref.putFile(imageFile!);
        image = await ref.getDownloadURL();
        await authStore.collection('users').doc(userId).set({
          'id': userId,
          'name': name,
          'phone': phone,
          'image': image,
          'password': password,
          'position': position,
          // 'joined At': '$time',
          'email': email,
        }).then((value) {
          GlobalMethods.navigateAndFinish(context, const LoginScreen());
        }).catchError((error) {
          print('Error in upload user data  ${error.toString()}');
          GlobalMethods.showSnackBar(context, error.toString(), Colors.red);
        });
        emit(RegisterWithEmailSuccessState());
      });
    } catch (e) {
      print(e.toString());
      GlobalMethods.showSnackBar(
          context, 'Error in Register ${e.toString()}', Colors.red);
      emit(RegisterWithEmailErrorState());
    }
  }

  String? name;
  String? phone;
  String? email;
  String? imageUrl;
  String? position;
  String? id;

  Future getUserData(
    BuildContext context,
  ) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    emit(GetUserDataLoadingState());
    try {
      final DocumentSnapshot userDoc =
          await authStore.collection('users').doc(userId).get();
      if (userDoc == null) {
        print('UserDoc Is Null');
        return;
      } else {
        email = userDoc.get('email');
        name = userDoc.get('name');
        phone = userDoc.get('phone');
        imageUrl = userDoc.get('image');
        position = userDoc.get('position');
        id = userDoc.get('id');
      }
      emit(GetUserDataSuccessState());
    } catch (e) {
      print(e.toString());
      GlobalMethods.showSnackBar(context, e.toString(), Colors.red);
    }
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginInWithEmailLoadingState());
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      GlobalMethods.showSnackBar(context, 'Logged  Successfully', Colors.green);
      GlobalMethods.navigateAndFinish(context, const HomeScreen());
      emit(LoginInWithEmailSuccessState());
    }).catchError((error) {
      GlobalMethods.showSnackBar(
          context, 'Error ${error.toString()}', Colors.red);
      emit(LoginInWithEmailErrorState());
    });
  }

  void signOutMethod(context) async {
    await auth.signOut().then((value) {
      GlobalMethods.navigateAndFinish(context, const UserLoginStates());
    });
  }

  Future pickImageWithCamera(context) async {
    try {
      pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera, maxWidth: 1080, maxHeight: 1080);

      imageFile = File(pickedFile!.path);
      emit(ChangeImage());
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
      GlobalMethods.showSnackBar(context, e.toString(), Colors.blue);
    }
  }
  pickImageWithGallery(context) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1080);
      imageFile = File(pickedFile!.path);
      Navigator.pop(context);
      emit(ChangeImage());
    } catch (e) {
      print(e.toString());
      GlobalMethods.showSnackBar(context, e.toString(), Colors.blue);
    }
  }

  bool isDark = true;
  changeAppMode(){
    isDark = !isDark;
    emit(ChangeAppMode());
  }
}
