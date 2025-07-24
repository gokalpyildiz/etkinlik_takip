import 'package:auto_route/auto_route.dart';
import 'package:etkinlik_takip/product/functions/token_operation.dart';
import 'package:etkinlik_takip/product/navigation/auto_route_handler.gr.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _loginControl();
    WidgetsBinding.instance.endOfFrame.then((_) {
      TokenOperation.instance.startControlToken();
    });
  }

  Future<void> _loginControl() async {
    final tokenIsExpire = await TokenOperation.instance.tokenIsExpire();
    if (!mounted) return;
    if (tokenIsExpire) {
      context.router.replace(LoginRoute());
    } else {
      ProductStateItems.productCubit.refreshBottomVies();
      context.router.replace(DashBoardRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.router.replace(LoginRoute());
          },
          child: Text('Start App'),
        ),
      ),
    );
  }
}
