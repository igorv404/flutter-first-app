class Validation {
  String? validateEmail(String value) {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Wrong email';
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(value)) {
      return 'Password must contain at least one uppercase letter,'
          ' one lowercase letter, one digit, and one special character';
    } else {
      return null;
    }
  }
}
