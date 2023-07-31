import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class googlelogin extends StatefulWidget {
  const googlelogin({Key? key}) : super(key: key);

  @override
  State<googlelogin> createState() => _googleloginState();
}

class _googleloginState extends State<googlelogin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: InkWell(
            onTap: () {
              signInWithGoogle();
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("image/download (2).jpeg"), fit: BoxFit.fill)),
            ),
          ),
        ),
      ),
    );
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
