import 'package:auto_route/auto_route.dart';
import 'package:etkinlik_takip/features/auth/login/view/mixin/login_view_mixin.dart';
import 'package:etkinlik_takip/features/auth/login/viewmodel/login_cubit.dart';
import 'package:etkinlik_takip/product/enums/form_status_enum.dart';
import 'package:etkinlik_takip/product/extensions/context_extension.dart';
import 'package:etkinlik_takip/product/navigation/auto_route_handler.gr.dart';
import 'package:etkinlik_takip/product/state/base/base_state.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:etkinlik_takip/product/utility/validator/validations_functions.dart';
import 'package:etkinlik_takip/product/widgets/base_widgets/my_scaffold.dart';
import 'package:etkinlik_takip/product/widgets/common/padding/project_padding.dart';
import 'package:etkinlik_takip/product/widgets/common/snackbars/ftoast_snackbar.dart';
import 'package:etkinlik_takip/product/widgets/common/text/my_text.dart';
import 'package:etkinlik_takip/product/widgets/common/textformfields/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

part 'widgets/login_button.dart';
part 'widgets/sign_in_button.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key, this.showContinueWithoutSigningButton = false});
  final bool showContinueWithoutSigningButton;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView> with LoginViewMixin {
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => cubit,
    child: BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.formStatus != current.formStatus,
      listener: (context, state) {
        if (state.formStatus == FormStatusEnum.failure) {
          FlutterToast.showError(context, title: 'Giriş Yapılamadı', subTitle: cubit.errorMessage);
        } else if (state.formStatus == FormStatusEnum.success) {
          FlutterToast.showSuccessful(context, title: 'Giriş Başarılı');
          context.router.replaceAll([HomeRoute()]);
        }
      },
      child: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: MyScaffold(
          appBar: AppBar(),
          child: Container(
            padding: ProjectPadding.pageContentPadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Giriş Yap', style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(
                  'E-posta ve şifrenizi girerek giriş yapabilirsiniz',
                  style: context.textTheme.titleMedium?.copyWith(color: context.appTheme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 24),
                MyTextFormField(
                  labelText: 'Email',
                  validator: ValidationsFunctions.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  controller: emailController,
                  autocorrect: false,
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r' '))],
                ),
                const SizedBox(height: 14),
                MyTextFormField(
                  labelText: 'Parola',
                  passwordInput: true,
                  autocorrect: false,
                  controller: passwordController,
                  autofillHints: const [AutofillHints.password],
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r' '))],
                  validator: (value) {
                    return (value?.length ?? 0) >= 6 ? null : 'Parolanız en az 6 karakter olmalıdır';
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    //todo parolamı unuttum sayfası açılacak
                  },
                  child: Text('Parolamı Unuttum', style: context.textTheme.titleMedium?.copyWith(color: context.appTheme.colorScheme.secondary)),
                ),
                const SizedBox(height: 32),
                Center(
                  child: _LoginButton(
                    formKey: formKey,
                    changeAutoValidateMode: changeAutoValidateMode,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                ),
                const SizedBox(height: 30),
                const Spacer(),
                const _SignInButton(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
