import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/data/models/auth_models/user_model.dart';
import 'package:etkinlik_takip/data/services/network/auth_service/IAuthService.dart';
import 'package:etkinlik_takip/data/services/network/auth_service/auth_service.dart';
import 'package:etkinlik_takip/product/functions/auth_operation.dart';
import 'package:etkinlik_takip/product/state/base/base_cubit.dart';
import 'package:etkinlik_takip/product/utility/firebase/firebase_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  ProfileCubit() : super(ProfileState()) {
    _service = AuthService.init();
  }
  User? user;
  UserModel? userModel;
  late IAuthService _service;
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

  Future<bool> signOut() async {
    var response = await _service.signOut();
    if (response?.success ?? false) {
      AuthOperation.instance.clear();
      return true;
    } else {
      return false;
    }
  }
}
