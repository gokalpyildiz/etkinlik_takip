import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:etkinlik_takip/product/state/viewmodel/product_cubit.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ProductCubit get productCubit => ProductStateItems.productCubit;
  Size get screenSize => MediaQuery.sizeOf(context);
}
