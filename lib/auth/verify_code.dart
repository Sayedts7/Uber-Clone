import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:uber_clone/components/constants.dart';
import 'package:uber_clone/user/home.dart';

import '../utils/utils.dart';


class VerifyCodeScreen extends StatefulWidget {

  final String VerificationId, phonenumber;
  const VerifyCodeScreen({Key? key, required this.VerificationId, required this.phonenumber}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;

  TextEditingController verificationcodecontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance ;
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color(0xff241e20),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Column(
              children: [



                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                  child: RichText(
                    text: TextSpan(
                        text: "Enter the code sent to ",
                        children: [
                          TextSpan(
                              text: "${widget.phonenumber}",
                              style: fontSizebold),
                        ],
                        style:
                        const TextStyle()),
                    textAlign: TextAlign.center,
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Form(

                              child: Column(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Form(
                                      key: formKey,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0,),
                                          child: PinCodeTextField(
                                            appContext: context,
                                            pastedTextStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            length: 6,
                                            obscureText: true,
                                            obscuringCharacter: '*',
                                            obscuringWidget: const Icon(Icons.star_purple500,
                                              size: 24,
                                            ),
                                            blinkWhenObscuring: true,
                                            animationType: AnimationType.fade,
                                            validator: (v) {
                                              if (v!.length < 6) {
                                                return "Enter 6 digit code";
                                              } else {
                                                return null;
                                              }
                                            },
                                            pinTheme: PinTheme(
                                              shape: PinCodeFieldShape.box,
                                              borderRadius: BorderRadius.circular(5),
                                              fieldHeight: 50,
                                              fieldWidth: 40,
                                              activeFillColor: hasError ? Colors.blue : Colors.red,
                                              activeColor: Colors.black,
                                              inactiveFillColor: Colors.white,
                                              inactiveColor: Colors.white,
                                              selectedColor: Colors.orange,
                                              selectedFillColor: Colors.pink,

                                            ),
                                            cursorColor: Colors.black,
                                            animationDuration: const Duration(milliseconds: 300),
                                            enableActiveFill: true,
                                            errorAnimationController: errorController,
                                            controller: verificationcodecontroller,
                                            keyboardType: TextInputType.number,
                                            boxShadows: const [
                                              BoxShadow(
                                                offset: Offset(0, 1),
                                                color: Colors.black12,
                                                blurRadius: 10,
                                              )
                                            ],

                                            // onTap: () {
                                            //   print("Pressed");
                                            // },
                                            onChanged: (value) {},
                                            beforeTextPaste: (text) {
                                              debugPrint("Allowing to paste $text");
                                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                              return true;
                                            },
                                          )),
                                    ),
                                  ),


                                ],)),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),


                            child: ButtonRound(text: 'Verify', loading: loading, ontap: () async {
                              setState(() {
                                loading = true;
                              });
                              final credential =PhoneAuthProvider.credential(
                                  verificationId: widget.VerificationId,
                                   smsCode: verificationcodecontroller.text.toString());
                              try{
                                await _auth.signInWithCredential(credential);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen(lat: 13.12 , long: 12.0,)));
                                Utils().toastMessage('Login Succesful');
                                loading = false;
                              }catch(e){
                                setState(() {
                                  loading = false;
                                });
                                Utils().toastMessage(e.toString());
                              }







                            },),


                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 25.0,right: 25,bottom: 50, top: 30),
                          //   child:   Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //
                          //       Text("Login with email?", style: txtstyllc,),
                          //       SizedBox(width: 5,),
                          //       InkWell(
                          //         onTap: () {
                          //           Navigator.pushReplacementNamed(context, '/login');
                          //         },
                          //         child: Container(
                          //             height: 30,
                          //             width: 80,
                          //             decoration: BoxDecoration(
                          //                 gradient: LinearGradient(colors: [appColor1, appColor2]),
                          //                 borderRadius: BorderRadius.circular(10)
                          //             ),
                          //             child:  Center(child: Text('Login', style: txtstyllc))),
                          //       ),
                          //
                          //     ],
                          //
                          //   ),
                          // )

                        ],
                      )),

                ),



              ],
            ),
          ),
        ),
      );
  }
}
