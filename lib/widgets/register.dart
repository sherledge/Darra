import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  final TextEditingController controllerFullName;
  final TextEditingController controllerConfirmPassword;
  final TextEditingController controllerAddress;
  final TextEditingController controllerPhoneNumber;

  const Register({
    super.key,
    required this.controllerEmail,
    required this.controllerPassword,
    required this.controllerFullName,
    required this.controllerConfirmPassword,
    required this.controllerAddress,
    required this.controllerPhoneNumber,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(50, 15, 50, 10),
      child: Column(
        children: [
          TextField(
            style: const TextStyle(fontSize: 15),
            controller: widget.controllerFullName,
            decoration: const InputDecoration(
                labelText: 'Full Name', labelStyle: TextStyle(fontSize: 14)),
          ),
          TextField(
            style: const TextStyle(fontSize: 15),
            controller: widget.controllerPhoneNumber,
            decoration: const InputDecoration(
                labelText: 'Phone Number', labelStyle: TextStyle(fontSize: 14)),
          ),
          TextField(
            style: const TextStyle(fontSize: 15),
            controller: widget.controllerAddress,
            decoration: const InputDecoration(
                labelText: 'Address', labelStyle: TextStyle(fontSize: 14)),
          ),
          TextField(
            controller: widget.controllerEmail,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextField(
            controller: widget.controllerPassword,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          TextField(
            controller: widget.controllerConfirmPassword,
            decoration: const InputDecoration(labelText: 'Confirm Password'),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
