import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/data/models/auth_models/user_model.dart';
import 'package:etkinlik_takip/product/state/base/base_cubit.dart';
import 'package:etkinlik_takip/product/utility/firebase/firebase_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  ProfileCubit() : super(ProfileState());
  User? user;
  UserModel? userModel;
  Future<void> refreshBottomVies() async {
    emit(state.copyWith(isLoading: true));
    try {
      user = FirebaseAuth.instance.currentUser;
      var docSnapshot = await FirebaseCollections.users.reference.doc(user?.uid).get();
      if (docSnapshot.exists) {
        userModel = UserModel.fromFirestore(docSnapshot);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    emit(state.copyWith(isLoading: false));
  }
}
