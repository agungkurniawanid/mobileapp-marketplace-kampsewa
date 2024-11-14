import 'package:flutter/material.dart';
import 'package:project_camp_sewa/layouts/layout_register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LayoutRegister(),
    );
  }
}