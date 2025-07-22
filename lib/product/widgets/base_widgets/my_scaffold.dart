import 'package:etkinlik_takip/product/extensions/context_extension.dart';
import 'package:etkinlik_takip/product/widgets/base_widgets/page_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class MyScaffold extends StatefulWidget {
  const MyScaffold({
    required this.child,
    super.key,
    this.appBar,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset = false,
    this.backgroundColor,
    this.extendBodyBehindAppBar = false,
    this.isLoading = false,
    this.bgImage,
  });
  final Widget child;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool extendBodyBehindAppBar;
  final bool isLoading;
  final ImageProvider<Object>? bgImage;

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> with StateMixin {
  @override
  Widget build(BuildContext context) => LoaderOverlay(
    disableBackButton: false,
    //todo renk temadan alınacak
    overlayColor: Colors.grey.withValues(alpha: 0.5),
    overlayWidgetBuilder: (value) => const PageLoadingWidget(),
    child: widget.isLoading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
            resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
            appBar: widget.appBar,
            backgroundColor: widget.backgroundColor ?? context.colorScheme.onPrimary,
            body: _body,
            bottomSheet: widget.bottomSheet,
            floatingActionButton: widget.floatingActionButton,
            floatingActionButtonLocation: widget.floatingActionButtonLocation,
            bottomNavigationBar: widget.bottomNavigationBar,
          ),
  );

  Widget get _body {
    if (widget.bgImage != null) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: widget.bgImage!, // PNG resmi
            fit: BoxFit.cover, // Tüm ekranı kaplasın
          ),
        ),
        child: widget.child,
      );
    }
    return widget.child;
  }
}

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void waitForScreen(VoidCallback onComplete) {
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      onComplete.call();
    });
  }
}
