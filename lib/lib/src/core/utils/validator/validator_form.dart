abstract class ValidatorForm {
  ///Validate Name
  static String? validatorName(String? value) {
    if (value == null) {
      return 'Ingresa tu nombre completo';
    }

    if (value.length < 3) {
      return 'Este campo debe ser superior a 3 caracteres';
    } else {
      return null;
    }
  }

  ///Validate email
  static String? validatorEmail(String? value) {
    if (value == null) {
      return 'Campo obligatorio';
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (emailValid) {
      return null;
    } else {
      return 'Dirección de correo inválida';
    }
  }

  ///Validate Cellphone
  static String? validatorPhone(String? value) {
    if (value == null) {
      return 'Ingresa tu número de celular';
    }
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Campo obligatorio';
    } else if (!regExp.hasMatch(value)) {
      return 'Campo obligatorio';
    }
    return null;
  }

  ///Validate password
  static String? validatorPassword(String? value) {
    if (value == null) {
      return 'Campo obligatorio';
    }
    if (value.length < 6) {
      return 'Este campo debe ser superior a 6 caracteres';
    }
    return null;
  }

  ///Confirm Password
  static String? validatorPasswordConfirm(String? value, String? value2) {
    if (value == null || value == '') return 'Campo obligatorio';
    if (value2 == null || value2 == '') return 'Campo obligatorio';
    if (value != value2) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  ///Validate Email Confirm
  static String? validatorEmailConfirm(String? value, String? value2) {
    if (value == null || value == '') return 'Campo obligatorio';
    if (value2 == null || value2 == '') return 'Campo obligatorio';
    if (value != value2) {
      return 'Los correos no coinciden';
    }
    return null;
  }
}
