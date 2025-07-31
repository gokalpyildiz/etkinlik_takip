import 'package:etkinlik_takip/product/constants/app/language_constants.dart';
import 'package:etkinlik_takip/product/constants/ui/ui_constants.dart';
import 'package:etkinlik_takip/product/functions/auth_operation.dart';
import 'package:etkinlik_takip/product/initialize/application_start.dart';
import 'package:etkinlik_takip/product/initialize/bloc_initialize.dart';
import 'package:etkinlik_takip/product/initialize/theme/custom_dark_theme.dart';
import 'package:etkinlik_takip/product/initialize/theme/custom_light_theme.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:etkinlik_takip/product/state/viewmodel/product_cubit.dart';
import 'package:etkinlik_takip/product/utility/project_manager.dart';
import 'package:etkinlik_takip/product/widgets/base_widgets/error_handling/app_error_boundary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(const BlocInitialize(child: MyApp()));
}

final class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _onAuthChanged();
    });
  }

  void _onAuthChanged() {
    FirebaseAuth.instance.idTokenChanges().listen((User? user) async {
      if (user == null) {
        AuthOperation.instance.routeLogin();
      } else {
        var idTokenResult = await user.getIdTokenResult();
        var date = idTokenResult.expirationTime;
        var isExpired = date!.isBefore(DateTime.now());
        if (isExpired) {
          AuthOperation.instance.routeLogin();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppErrorBoundary(
      child: ScreenUtilInit(
        designSize: UiConstants.defaultSize,
        child: MaterialApp.router(
          routerConfig: ProductStateItems.appRouterHandler.config(),
          theme: CustomLightTheme().themeData,
          scaffoldMessengerKey: ProjectManager.scaffoldMessengerKey,
          darkTheme: CustomDarkTheme().themeData,
          themeMode: context.watch<ProductCubit>().state.themeMode,
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLanguages.supportedCountryPhoneItems,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
        ),
      ),
    );
  }
}
