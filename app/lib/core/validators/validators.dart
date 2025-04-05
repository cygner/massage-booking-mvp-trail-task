class Validators {


  static String? isEmail(String? value) {
    bool isEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(value ?? "");
    return (isEmail ? null : "Please Enter Valid Email");
  }

  static String? isPassword(String? value) {
    if (value == null) {
      return "Please enter password";
    } else if (value.isEmpty) {
      return "Please enter password";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters long";
    } else {
      return null;
    }
  }

  static String? minimum(String? value) {
    return  ((value ?? "").length < 2 ? "Please Enter Minimum 2 Characters" : null);
  }




  static String? isOTP(String? value) {
    return
        ((value ?? "").length < 4 ? "Please Enter Valid OTP" : null);
  }

  static String? isSelect(String? value,String what) {
    return
        ((value ?? "").isEmpty? "Please select $what" : null);
  }


}
