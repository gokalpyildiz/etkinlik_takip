part of '../register_view.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({required this.formKey, required this.changeAutoValidateMode, required this.cubit, super.key});
  final GlobalKey<FormState> formKey;
  final RegisterCubit cubit;
  final void Function(AutovalidateMode) changeAutoValidateMode;

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<RegisterCubit>();
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
                child: MyText('Kayıt Ol', color: context.colorScheme.onPrimary, fontWeight: FontWeight.w600),
              ),
      ),
      onPressed: () async {
        if (!(formKey.currentState?.validate() ?? false)) {
          changeAutoValidateMode(AutovalidateMode.always);
        } else {
          await cubit.register();
        }
      },
    );
  }
}
