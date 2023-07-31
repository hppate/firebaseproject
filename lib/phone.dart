import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/otp.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class phonee extends StatefulWidget {
  const phonee({Key? key}) : super(key: key);
    static String verifications="";
  @override
  State<phonee> createState() => _phoneeState();
}

class _phoneeState extends State<phonee> {
  TextEditingController phone = TextEditingController();

  TextEditingController countrycodetext= TextEditingController();
  String vid = "";
  String countrycode = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countrycodetext.text="+91";
  }
  Widget build(BuildContext context) {

    double heightt=MediaQuery.of(context).size.height;
    double keboardheight=MediaQuery.of(context).viewInsets.bottom;
    double height=heightt-keboardheight;

    return SafeArea(
      child: Scaffold(
        body:
        Container(
          margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

            Container(
                height: 200,
                width: 200,
                child: Image.asset("image/images.png")
            ),
            Text(
              "Phone Verification",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                "We need to register your phone before getting started!",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Container(
              height: 60,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey, width: 1)),
              child: Row(
                children: [
                  SizedBox(
                    width: 14,
                  ),
                  SizedBox(
                    width: 40,

                    child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      controller: countrycodetext,
                    ),
                  ),

                  Text("|", style: TextStyle(fontSize: 30, color: Colors.grey),),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: TextField(
                       showCursor: false,
                        decoration: InputDecoration(border: InputBorder.none, hintText: "Enter number", ),
                      controller: phone,

                      )),

                ],
              ),
            ),
           SizedBox(height: 20,),
           SizedBox(
             height: 55,
             width: double.infinity,
             child:  ElevatedButton(
                 style: ElevatedButton.styleFrom(
                     primary: Color(0xffAED8CC),
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(20))),
                 onPressed: () async {
                   await FirebaseAuth.instance.verifyPhoneNumber(
                     phoneNumber: "+91${phone.text}",
                     verificationCompleted: (PhoneAuthCredential credential) {},
                     verificationFailed: (FirebaseAuthException e) {},
                     codeSent: (String verificationId, int? resendToken) {
                       setState(() {
                         phonee.verifications=verificationId;
                       });
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                         return otp();
                       },));
                     },
                     codeAutoRetrievalTimeout: (String verificationId) {},
                   );

                 },
                 child: Text("Send the code", style: TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w400),)),
           )
          ]),
        ),
      ),
    );
  }
}
