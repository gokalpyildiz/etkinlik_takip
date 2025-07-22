import 'package:flutter/material.dart';
import '../../viewmodel/login_cubit.dart';

import '../../../../../product/state/base/base_state.dart';
import '../login_view.dart';

mixin LoginViewMixin on BaseState<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();
  late LoginCubit cubit;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    cubit = LoginCubit(
      context: context,
      emailController: emailController,
      passwordController: passwordController,
    )..init();
  }

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  void changeAutoValidateMode(final AutovalidateMode mode) {
    autoValidateMode = mode;
    setState(() {});
  }
}
