part of '../login_view.dart';

class _SignInButton extends StatelessWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Hesabınız yok mu?', style: context.textTheme.titleSmall?.copyWith(color: context.appTheme.colorScheme.onSurfaceVariant)),
        const SizedBox(width: 8),
        InkWell(
          onTap: () {
            context.router.push(const RegisterRoute());
          },
          child: Text('Hemen Üye Ol', style: context.textTheme.titleSmall?.copyWith(color: context.appTheme.colorScheme.secondary)),
        ),
      ],
    );
  }
}
