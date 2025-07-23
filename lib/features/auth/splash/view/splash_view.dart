import 'package:auto_route/auto_route.dart';
import 'package:etkinlik_takip/product/navigation/app_router.dart';
import 'package:etkinlik_takip/product/navigation/auto_route_handler.gr.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        final isAllowForGuest =
            ProductStateItems.appRouterHandler.currentUrl == AppRoute.splash ||
            ProductStateItems.appRouterHandler.currentUrl == AppRoute.login ||
            ProductStateItems.appRouterHandler.currentUrl == AppRoute.register;
        if (!isAllowForGuest) {
          ProductStateItems.appRouterHandler.replaceAll([LoginRoute()]);
        }
      }
    });
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
