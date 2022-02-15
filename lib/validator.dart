class Validator {
  static String validateEmail({String email}) {
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return "Email can't be empty";
    } else if (!emailRegExp.hasMatch(email)) {
      return "Enter a correct email";
    }
    return null;
  }

  static String validatePassword({String password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return "Password can't be empty";
    } else if (password.length < 6) {
      return "Password has to be at least 6 characters long";
    }
    return null;
  }
}
