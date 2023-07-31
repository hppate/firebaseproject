import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseproject/phone.dart';
import 'package:flutter/material.dart';

import 'googlelogin.dart';
import 'login.dart';
import 'otp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(
      MaterialApp(

        home: googlelogin(), debugShowCheckedModeBanner: false,)
  );
}
class emailpass extends StatefulWidget {
  const emailpass({Key? key}) : super(key: key);

  @override
  State<emailpass> createState() => _emailpassState();
}

class _emailpassState extends State<emailpass> {

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: email,
            ),
            TextField(
              controller: password,
            ),
            TextButton(onPressed: () async {

              try {
                final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email.text,
                  password: password.text,
                ).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("successfully account created")));

                  Future.delayed(Duration(seconds: 2)).then((value) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return login();
                    },));
                  });
                });
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The password provided is too weak.")));
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The account already exists for that email")));

                }
              } catch (e) {
                print(e);
              }
            }, child: Text("signup"))
          ],
        ),

      ),
    );
  }
}
