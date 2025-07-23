import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputFormatterFunctions {
  InputFormatterFunctions._init();
  static final InputFormatterFunctions _instance = InputFormatterFunctions._init();
  static InputFormatterFunctions get instance => _instance;

  String get _phoneMask => '0(###) ###-##-##';
  String get _phoneMask2 => '### ### ## ##';

  TextInputFormatter get priceFormatter => FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));

  MaskTextInputFormatter get phoneFormatter => MaskTextInputFormatter(mask: _phoneMask, filter: {'#': RegExp('[0-9]')});
  MaskTextInputFormatter get phoneFormatter2 => MaskTextInputFormatter(mask: _phoneMask2, filter: {'#': RegExp('[0-9]')});
  MaskTextInputFormatter get phoneFormatter3 => MaskTextInputFormatter(filter: {'#': RegExp('[0-9]')});
}
