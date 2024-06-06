class FormValidator {
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) return "Enter your Name.";
    return null;
  }

  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) return "Enter your email.";
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) {
      return "Not valid email.";
    }
    return null;
  }

  static String? birthDateValidator(String? date) {
    if (date == null || date.isEmpty) return "Enter your Birthday.";
    return null;
  }
}
