import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../view/widgets/default_custom_text.dart';
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

  void choosePhotoDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: DefaultCustomText(
              text: 'Options',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: const Divider(),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        pickImageWithCamera(context);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.camera),
                          SizedBox(
                            width: 15,
                          ),
                          Text('Camera')
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageWithGallery(context);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.picture_in_picture),
                          SizedBox(
                            width: 15,
                          ),
                          Text('Gallery')
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  File? imageFile;

  pickImageWithCamera(context) async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 1080, maxHeight: 1080);

    imageFile = File(pickedFile!.path);
    // cropImage(context, pickedFile!.path);

    emit(ChangeImage());
    Navigator.pop(context);
  }

  pickImageWithGallery(context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1080);
    imageFile = File(pickedFile!.path);
    // cropImage(context, pickedFile!.path);
    Navigator.pop(context);
    emit(ChangeImage());
  }

  CroppedFile? croppedFile;

  Future cropImage(context, imagePath) async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
    );
    if (croppedFile != null) {
      imageFile = croppedFile as File;
      emit(ChangeImage());
    }
  }
}
