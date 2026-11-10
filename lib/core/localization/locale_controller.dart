import 'package:flutter/material.dart';

class LocaleController extends ValueNotifier<Locale> {
  LocaleController() : super(const Locale('vi'));

  void toggle() {
    value = value.languageCode == 'vi'
        ? const Locale('en')
        : const Locale('vi');
  }
}

final localeController = LocaleController();
