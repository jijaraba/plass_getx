import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    this.eye = false,
    this.viewPassword = false,
    this.callback,
    this.type = TextInputType.text,
    required this.text,
    required this.validator,
    this.help,
  }) : super(key: key);

  final String hintText;
  final bool eye, viewPassword;
  final VoidCallback? callback;
  final TextInputType type;
  final String? help;
  final TextEditingController text;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          style: const TextStyle(color: Colors.black87),
          validator: validator,
          controller: text,
          obscureText: viewPassword,
          keyboardType: type,
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.black54),
            errorStyle: const TextStyle(color: Colors.white),
            helperStyle: const TextStyle(color: Colors.white),
            helperText: help,
            hintText: hintText,
            suffixIcon: eye
                ? IconButton(
                    onPressed: callback,
                    icon: Icon(
                      viewPassword
                          ? Ionicons.eye_outline
                          : Ionicons.eye_off_outline,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}

class CustomTextFieldLogin extends StatelessWidget {
  const CustomTextFieldLogin({
    Key? key,
    required this.hintText,
    this.eye = false,
    this.viewPassword = false,
    this.callback,
    this.type = TextInputType.text,
    required this.text,
    required this.validator,
    this.help,
  }) : super(key: key);

  final String hintText;
  final bool eye, viewPassword;
  final VoidCallback? callback;
  final TextInputType type;
  final String? help;
  final String? Function(String?) text;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onChanged: text,
          obscureText: viewPassword,
          keyboardType: type,
          decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            errorStyle: const TextStyle(color: Colors.white),
            fillColor: Colors.transparent,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: .5),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: .5),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: .5),
              borderRadius: BorderRadius.circular(10),
            ),
            focusColor: Colors.white,
            helperText: help,
            hintStyle: const TextStyle(color: Colors.white60),
            hintText: hintText,
            suffixIcon: eye
                ? IconButton(
                    onPressed: callback,
                    icon: Icon(
                        viewPassword
                            ? Ionicons.eye_outline
                            : Ionicons.eye_off_outline,
                        color: Colors.white),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
