import 'package:etkinlik_takip/product/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.validator,
    this.minLine,
    this.onChanged,
    this.multiLine = false,
    this.filled,
    this.passwordInput = false,
    this.initialValue,
    this.inputFormatters,
    this.hintStyle,
    this.contentPadding,
    this.autovalidateMode,
    this.prefix,
    this.prefixIcon,
    this.keyboardType,
    this.icon,
    this.autofillHints,
    this.autocorrect = true,
  });
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? minLine;
  final bool multiLine;
  final bool? filled;
  final bool passwordInput;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode? autovalidateMode;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? icon;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final bool autocorrect;

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  late bool _isObscure;
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    _isObscure = widget.passwordInput ? true : false;
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialValue != null) {
      widget.controller?.text = widget.controller?.text ?? '';
    }
    return TextFormField(
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      keyboardType: widget.keyboardType,
      initialValue: widget.initialValue,
      enabled: widget.filled,
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      minLines: widget.multiLine ? widget.minLine ?? 1 : 1,
      maxLines: widget.multiLine ? widget.minLine ?? 4 : 1,
      onChanged: (value) {
        widget.onChanged?.call(value);
        setState(() {});
      },
      inputFormatters: widget.inputFormatters,
      obscureText: _isObscure,
      autofillHints: widget.autofillHints,
      autocorrect: widget.autocorrect,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        filled: widget.filled,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: context.appTheme.colorScheme.error),
        ),
        contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        isCollapsed: false,
        isDense: true,
        icon: widget.icon,
        suffixIcon: widget.passwordInput
            ? (_isObscure
                  ? IconButton(
                      onPressed: () {
                        _isObscure = !_isObscure;
                        setState(() {});
                      },
                      icon: Icon(Icons.visibility_off),
                    )
                  : IconButton(
                      onPressed: () {
                        _isObscure = !_isObscure;
                        setState(() {});
                      },
                      icon: Icon(Icons.visibility),
                    ))
            : null,
        prefix: widget.prefix,
        prefixIcon: widget.prefixIcon,
      ),
    );
  }
}
