class Validator {
  static String? phoneNumberValidator(String val){
    if (val.isEmpty) return 'phone number cannot be empty';
    else if (!(val.contains(RegExp(r'^([1-9])(\d{9})$')))) return 'phone number contains ten digits';
    return null;
  }
  static String? usernameValidator(String val) {
    val = val.toLowerCase();
    if (val.isEmpty)
      return 'user name cannot be empty';
    else if (!(val.contains(RegExp(r'^[a-z]+$'))))
      return 'username contains only alphabets';
    return null;
  }
  static String? upiValidator(String val) {
    val = val.toLowerCase();
    if (val.isEmpty)
      return 'upi id cannot be empty';
    else if (!(val.contains(RegExp(r'^([a-z\d]+)@[a-z]+$'))))
      return 'upi format : XXX@BANK';
    return null;
  }
}