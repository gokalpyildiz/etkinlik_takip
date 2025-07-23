import 'package:etkinlik_takip/features/auth/register/view/register_view.dart';
import 'package:etkinlik_takip/features/auth/register/viewmodel/register_cubit.dart';
import 'package:etkinlik_takip/product/state/base/base_state.dart';
import 'package:flutter/material.dart';

mixin RegisterViewMixin on BaseState<RegisterView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late bool isEmailTrue;
  late bool isPasswordTrue;
  late RegisterCubit cubit;

  @override
  void initState() {
    super.initState();
    isEmailTrue = false;
    isPasswordTrue = false;
    cubit = RegisterCubit()..init();
  }

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  void changeAutoValidateMode(final AutovalidateMode mode) {
    autoValidateMode = mode;
    setState(() {});
  }
}
