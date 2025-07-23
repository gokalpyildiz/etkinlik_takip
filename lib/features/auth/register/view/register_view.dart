import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:etkinlik_takip/features/auth/register/view/mixin/register_mixin.dart';
import 'package:etkinlik_takip/features/auth/register/viewmodel/register_cubit.dart';
import 'package:etkinlik_takip/product/enums/form_status_enum.dart';
import 'package:etkinlik_takip/product/extensions/context_extension.dart';
import 'package:etkinlik_takip/product/navigation/auto_route_handler.gr.dart';
import 'package:etkinlik_takip/product/state/base/base_state.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:etkinlik_takip/product/utility/input_formatter/input_formatter_fuctions.dart';
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

part 'widgets/register_button.dart';
part 'widgets/register_phone.dart';

@RoutePage()
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends BaseState<RegisterView> with RegisterViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<RegisterCubit, RegisterState>(
        listenWhen: (previous, current) => previous.formStatus != current.formStatus,
        listener: (context, state) {
          if (state.formStatus == FormStatusEnum.failure) {
            FlutterToast.showError(context, title: 'Giriş Yapılamadı', subTitle: cubit.errorMessage);
          } else if (state.formStatus == FormStatusEnum.success) {
            FlutterToast.showSuccessful(context, title: 'Kayıt Başarılı');
            ProductStateItems.productCubit.refreshBottomVies();
            context.router.replaceAll([DashBoardRoute()]);
            ProductStateItems.productCubit.refreshBottomVies();
          }
        },
        child: MyScaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  context.router.maybePop();
                },
                child: Text('Giriş Yap', style: context.textTheme.titleMedium?.copyWith(color: context.colorScheme.secondary)),
              ),
            ],
          ),
          child: Form(
            key: formKey,
            autovalidateMode: autoValidateMode,
            child: Padding(
              padding: const ProjectPadding.pageContentPadding(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kayıt Ol', style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  _name(),
                  const SizedBox(height: 8),
                  _surname(),
                  const SizedBox(height: 8),
                  _password(),
                  const SizedBox(height: 8),
                  _email(),
                  const SizedBox(height: 8),
                  _RegisterPhone(),
                  const Spacer(),
                  Center(
                    child: RegisterButton(formKey: formKey, changeAutoValidateMode: changeAutoValidateMode, cubit: cubit),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _email() {
    return MyTextFormField(
      labelText: 'Email',
      autofillHints: const [AutofillHints.email],
      keyboardType: TextInputType.emailAddress,
      validator: ValidationsFunctions.validateEmail,
      onChanged: (p0) => cubit.email = p0,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r' '))],
    );
  }

  Widget _password() {
    return MyTextFormField(
      labelText: 'Parola',
      validator: ValidationsFunctions.validatePassword,
      autofillHints: const [AutofillHints.newPassword],
      onChanged: (p0) => cubit.password = p0,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r' '))],
      passwordInput: true,
    );
  }

  Widget _surname() {
    return MyTextFormField(
      labelText: 'Soyad',
      autofillHints: const [AutofillHints.familyName],
      validator: ValidationsFunctions.validateEmty,
      onChanged: (p0) => cubit.surname = p0,
    );
  }

  Widget _name() {
    return MyTextFormField(
      labelText: 'İsim',
      validator: ValidationsFunctions.validateEmty,
      autofillHints: const [AutofillHints.name],
      onChanged: (p0) => cubit.name = p0,
    );
  }
}
