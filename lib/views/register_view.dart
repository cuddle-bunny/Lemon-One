import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterView();
}

class _RegisterView extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _email,
          enableSuggestions: true,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'Enter your email'),
        ),
        TextField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          controller: _password,
          decoration: const InputDecoration(hintText: 'Enter your password'),
        ),
        ElevatedButton(
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;
            try {
              final userCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: email, password: password);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('An account already exists for this email.');
              } else if (e.code == 'invalid-email') {
                print('Use a valid email');
              }
            } catch (e) {
              print(e);
            }
          },
          child: const Text(
            'Register',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}