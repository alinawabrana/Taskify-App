/// ------------------------------- NOTE ---------------------------------
// ^: Asserts the start of a string.

// [\w-\.]+:
//
// [\w-\.] matches any word character (alphanumeric or underscore), hyphen (-), or dot (.).
//
// + means that the preceding character set should appear one or more times.
//
// This part matches the local part of the email address (the part before the @ symbol).

// @: Matches the @ symbol, which separates the local part of the email from the domain part.

// ([\w-]+\.)+:
//
// [\w-]+ matches one or more word characters or hyphens.
// \. matches a literal dot.
// The parentheses around ([\w-]+\.) create a capturing group, and the + after the group means that this pattern should repeat one or more times.
// This part matches the domain name, like example. in example.com.

// [\w-]{2,4}:
//
// [\w-] matches any word character or hyphen.
// {2,4} means that the preceding character set should appear between 2 and 4 times.
// This part matches the top-level domain (TLD), such as com, org, or net.

// $: Asserts the end of a string.

/// ------------------------------- END NOTE ----------------------------

class TValidator {
  TValidator._();

  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is Empty';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid Email Address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be 6 characters long.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number is Required';
    }

    // Regular expression for phone number validation (assuming a 10-digits US phone number format)
    final phoneRegExp = RegExp(r'^\d{11}$|^\+\d{1,3}\d{10}$');

    // For International Phone Number Format
    // final phoneRegExp = RegExp(r'');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).';
    }

    return null;
  }

//Add more custom validators as needed for your specific requirements.
}
