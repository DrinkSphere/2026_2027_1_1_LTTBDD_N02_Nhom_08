import 'package:flutter/widgets.dart';
import '../../l10n/app_localizations.dart';

class Validators {
  static AppLocalizations _l10n(BuildContext context) =>
      AppLocalizations.of(context)!;

  static String? validateEmail(
    String? value, {
    BuildContext? context,
    String? requiredMessage,
    String? invalidMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return requiredMessage ??
          (context == null ? 'Vui lòng nhập địa chỉ email' : _l10n(context).valRequired);
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return invalidMessage ??
          (context == null ? 'Email không hợp lệ (ví dụ: name@example.com)' : _l10n(context).valInvalidEmail);
    }
    return null;
  }

  static String? validatePassword(
    String? value, {
    BuildContext? context,
    String? requiredMessage,
    String? lengthMessage,
  }) {
    if (value == null || value.isEmpty) {
      return requiredMessage ??
          (context == null ? 'Vui lòng nhập mật khẩu' : _l10n(context).valRequired);
    }
    if (value.length < 6) {
      return lengthMessage ??
          (context == null ? 'Mật khẩu phải có ít nhất 6 ký tự' : _l10n(context).valPasswordLength);
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String password, {
    BuildContext? context,
    String? requiredMessage,
    String? mismatchMessage,
  }) {
    if (value == null || value.isEmpty) {
      return requiredMessage ??
          (context == null ? 'Vui lòng nhập lại mật khẩu xác nhận' : _l10n(context).valRequired);
    }
    if (value != password) {
      return mismatchMessage ??
          (context == null ? 'Mật khẩu xác nhận không khớp' : _l10n(context).valPasswordMismatch);
    }
    return null;
  }

  static String? validateRequired(
    String? value,
    String fieldName, {
    BuildContext? context,
    String? requiredMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return requiredMessage ??
          (context == null ? 'Vui lòng nhập $fieldName' : _l10n(context).valRequired);
    }
    return null;
  }

  static String? validatePhone(
    String? value, {
    BuildContext? context,
    String? invalidMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return null; // Phone is optional in some places
    }
    final phoneRegex = RegExp(r'^(0[3|5|7|8|9])+([0-9]{8})$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return invalidMessage ??
          (context == null
              ? 'Số điện thoại không hợp lệ (10 số, bắt đầu 03, 05, 07, 08, 09)'
              : _l10n(context).valPhoneInvalid);
    }
    return null;
  }
}
