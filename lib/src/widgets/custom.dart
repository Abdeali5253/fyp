import 'package:flutter/material.dart';
import 'package:fyp/src/views/home_screen.dart';
import '../services/auth_service.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.onTap,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      onTap: onTap,
    );
  }
}

class Custom {
  static final AuthService _authService = AuthService();

  static showErrorDialog(BuildContext context , String? message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occurred'),
        content: Text(message ?? 'Unknown error'),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  static Widget buildSocialSignUpButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.login),
      label: Text('Sign up with Google'),
      onPressed: () async {
        try {
          await _authService.signInWithGoogle();
          // Handle successful Google sign-in
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } catch (error) {
          // Handle sign-in error
          // TODO: Show an error message
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

}
