part of '../login_view.dart';

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.formKey, required this.changeAutoValidateMode, required this.emailController, required this.passwordController});
  final GlobalKey<FormState> formKey;
  final void Function(AutovalidateMode) changeAutoValidateMode;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();
    var watch = context.watch<LoginCubit>();
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(context.appTheme.colorScheme.primary)),
      child: SizedBox(
        width: 100,
        child: watch.state.formStatus == FormStatusEnum.loading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SpinKitFadingCircle(color: context.colorScheme.onPrimary, size: 25)],
              )
            : Center(
                child: MyText('Giriş Yap', color: context.colorScheme.onPrimary, fontWeight: FontWeight.w600),
              ),
      ),
      onPressed: () async {
        if (!(formKey.currentState?.validate() ?? false)) {
          changeAutoValidateMode(AutovalidateMode.always);
        } else {
          var response = await cubit.login(email: emailController.text, password: passwordController.text);
          if (response) {
            TextInput.finishAutofillContext();
            ProductStateItems.productCubit.refreshBottomVies();
            if (context.mounted) {
              await context.router.maybePop(true);
            }
          }
        }
      },
    );
  }
}
