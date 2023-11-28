import 'package:app1flutter/firebase/email_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final conNameUser = TextEditingController();
  final conEmailUser = TextEditingController();
  final conPwdUser = TextEditingController();
  final emailAuth = EmailAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Usuario"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: conNameUser,
          ),
          TextFormField(
            controller: conEmailUser,
          ),
          TextFormField(
            controller: conPwdUser,
          ),
          ElevatedButton(
              onPressed: () {
                var email = conEmailUser.text;
                var pwd = conPwdUser.text;
                emailAuth.createUser(emailUser: email, pwdUser: pwd);
              },
              child: const Text('Save'))
        ],
      ),
    );
  }
}
