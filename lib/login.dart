import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(children: [
            TextField(
              controller: email,
            ),
            TextField(
              controller: password,
            ),
            TextButton(onPressed: () async {
              try {
                final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email.text,
                    password: password.text
                ).then((value) {

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("login sucessfully")));

                });
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No user found for that email.")));

                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong password provided for that user.")));


                print('Wrong password provided for that user.');
                }
              }

            }, child: Text("login", ))
          ]),
        ),

      ),
    );
  }
}
