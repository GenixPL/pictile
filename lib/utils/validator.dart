class Validator {
  static String validateSetName(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }

    if (value.length > 50) {
      return 'Max 50 characters';
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

    return null;
  }

  static String validatePairDescription(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }

    if (value.length > 500) {
      return 'Max 500 characters';
    }

    return null;
  }
}
