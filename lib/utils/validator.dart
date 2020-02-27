class Validator {
  static String validateSetName(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }

    if (value.length > 50) {
      return 'Max 50 characters';
    }

    if (value.contains('"')) {
      return 'You can not use " sign (use \' instead)';
    }

    return null;
  }

  static String validatePairTitle(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }

    if (value.length > 50) {
      return 'Max 50 characters';
    }

    if (value.contains('"')) {
      return 'You can not use " sign (use \' instead)';
    }

    return null;
  }

  static String validatePairDescription(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }

    if (value.length > 1000) {
      return 'Max 1000 characters';
    }

    if (value.contains('"')) {
      return 'You can not use " sign (use \' instead)';
    }

    return null;
  }
}
