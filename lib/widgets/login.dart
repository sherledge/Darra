import 'package:flutter/material.dart';

class Login extends StatefulWidget {
    final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
 const Login(
      {super.key,
      required this.controllerEmail,
      required this.controllerPassword});


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(50, 50, 50, 10),
      child: Column(
        children: [
          TextField(
            style: const TextStyle(color: Colors.black),
            controller: widget.controllerEmail,
            decoration: const InputDecoration(labelText: 'Email address'),
          ),
          TextField(
            controller: widget.controllerPassword,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
