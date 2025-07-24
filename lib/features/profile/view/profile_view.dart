import 'package:auto_route/auto_route.dart';
import 'package:etkinlik_takip/features/profile/viewmodel/profile_cubit.dart';
import 'package:etkinlik_takip/product/extensions/widget_extension.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:etkinlik_takip/product/widgets/base_widgets/my_scaffold.dart';
import 'package:etkinlik_takip/product/widgets/common/text/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final cubit = ProductStateItems.profileCubit;
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) return CircularProgressIndicator();
          final user = cubit.userModel;
          final nameSurname = '${user?.name ?? ''}  ${user?.surname ?? ''}';
          final email = user?.email ?? '';
          final phone = (user?.phoneCountryCode ?? '') + (user?.phone ?? '');
          final notfcId = user?.notificationToken;
          return MyScaffold(
            appBar: AppBar(title: MyText('Profil')),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      title: MyText(nameSurname),
                      subtitle: Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [MyText(email), MyText(phone), if (notfcId != null) MyText(notfcId).toCopyWidgetWithIcon(context, notfcId)],
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(child: MyText('Cıkıs Yap'), onPressed: () => FirebaseAuth.instance.signOut()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
