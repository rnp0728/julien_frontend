import 'package:julien/core/utils/validation/regex_pattern.dart';

class Validator {
  static String? Function(dynamic) none() {
    return (dynamic value) {
      return null;
    };
  }

  static String? Function(dynamic) check(
      bool Function(dynamic value) customCheck,
      {String? message}) {
    return (dynamic value) {
      return customCheck(value) ? null : message ?? 'Invalid value';
    };
  }

  static String? Function(dynamic) empty({String? message}) {
    return (dynamic value) {
      return value == null || value.toString().trim().isEmpty
          ? message ?? 'Required Field'
          : null;
    };
  }

  static String? Function(dynamic) emailOrPhoneNumber({String? message}) {
    return (dynamic value) {
      RegExp emailRegex = RegExp(RegExPattern.emailPattern);
      RegExp phoneRegex = RegExp(RegExPattern.phonePattern);

      if (value == null ||
          (!emailRegex.hasMatch(value.toString()) &&
              !phoneRegex.hasMatch(value.toString()))) {
        return message ?? 'Enter a valid email address or phone number';
      }

      return null;
    };
  }

  static String? Function(dynamic) minLength(int minLength, {String? message}) {
    return (dynamic value) {
      return value == null || value.toString().length < minLength
          ? message ?? 'Must be at least $minLength characters long'
          : null;
    };
  }

  static String? Function(dynamic) maxLength(int maxLength, {String? message}) {
    return (dynamic value) {
      return value != null && value.toString().length > maxLength
          ? message ?? 'Must not exceed $maxLength characters'
          : null;
    };
  }

  static String? Function(dynamic) email({String? message}) {
    return (dynamic value) {
      RegExp emailRegex = RegExp(RegExPattern.emailPattern);
      return value == null || !emailRegex.hasMatch(value.toString())
          ? message ?? 'Enter a valid email address'
          : null;
    };
  }

  static String? Function(dynamic) numeric({String? message}) {
    return (dynamic value) {
      return value == null || int.tryParse(value.toString()) == null
          ? message ?? 'Enter a valid numeric value'
          : null;
    };
  }

  static String? Function(dynamic) phoneNumber({String? message}) {
    return (dynamic value) {
      RegExp phoneRegex = RegExp(RegExPattern.phonePattern);
      return value == null || !phoneRegex.hasMatch(value.toString())
          ? message ?? 'Enter a valid phone number'
          : null;
    };
  }

  static String? Function(dynamic) password({String? message}) {
    return (dynamic value) {
      return value == null || value.toString().length < 6
          ? message ?? 'Password must be at least 6 characters long'
          : null;
    };
  }

  static String? Function(dynamic) url({String? message}) {
    return (dynamic value) {
      RegExp urlRegex = RegExp(r'^(http(s)?:\/\/)?[^\s]+');
      return value == null || !urlRegex.hasMatch(value.toString())
          ? message ?? 'Enter a valid URL'
          : null;
    };
  }

  static String? Function(dynamic) date({String? message}) {
    return (dynamic value) {
      RegExp dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
      return value == null || !dateRegex.hasMatch(value.toString())
          ? message ?? 'Enter a valid date (YYYY-MM-DD)'
          : null;
    };
  }

  static String? Function(dynamic) creditCard({String? message}) {
    return (dynamic value) {
      RegExp creditCardRegex = RegExp(r'^\d{4}-\d{4}-\d{4}-\d{4}$');
      return value == null || !creditCardRegex.hasMatch(value.toString())
          ? message ?? 'Enter a valid credit card number (XXXX-XXXX-XXXX-XXXX)'
          : null;
    };
  }

  static String? Function(dynamic) alphanumeric({String? message}) {
    return (dynamic value) {
      return value == null ||
              !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value.toString())
          ? message ?? 'Enter an alphanumeric value'
          : null;
    };
  }

  static String? Function(dynamic) ipAddress({String? message}) {
    return (dynamic value) {
      return value == null ||
              !RegExp(r'^(\d{1,3}\.){3}\d{1,3}$').hasMatch(value.toString())
          ? message ?? 'Enter a valid IP address'
          : null;
    };
  }
}

bool validPhoneNumber(String? phone) {
  RegExp phoneRegex = RegExp(RegExPattern.phonePattern);
  return phone == null || phoneRegex.hasMatch(phone.toString()) ? true : false;
}

bool validEmailAddress(String? email) {
  RegExp emailRegex = RegExp(RegExPattern.emailPattern);
  return email == null || emailRegex.hasMatch(email.toString()) ? true : false;
}
