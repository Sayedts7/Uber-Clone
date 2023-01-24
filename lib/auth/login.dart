import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:uber_clone/auth/verify_code.dart';
import 'package:uber_clone/components/constants.dart';

import '../user/bottombar.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
   late double stlat;
   late double stlang;
  var Ccode;
  bool loading = false;

  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace) {
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }


  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin()async{
    final googleUser = await googleSignIn.signIn();
    if( googleUser == null) {
       return ;
    }
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomBar()));
    });
  }


  final _formKey = GlobalKey<FormState>();
  TextEditingController phonecontroller = TextEditingController();
  // TextEditingController passwordcontroller = TextEditingController();

   final FirebaseAuth _auth = FirebaseAuth.instance ;



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phonecontroller.dispose();

  }

  void isLogin(){
    setState(() {
      loading= true;
    });
    _auth.verifyPhoneNumber(
        phoneNumber: Ccode+phonecontroller.text,
        verificationCompleted: (_){
          setState(() {
            loading= false;
          });
        },

        verificationFailed:(e) {
          Utils().toastMessage(e.toString());
          print(phonecontroller);
          setState(() {
            loading= false;
          });
        },

        codeSent: (String verification, int? token) {
          print(phonecontroller);
          setState(() {
            loading= false;
          });
          Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyCodeScreen(
            VerificationId: verification, phonenumber: Ccode+phonecontroller.text, )));
          print(phonecontroller);
        },

        codeAutoRetrievalTimeout: (e){
          Utils().toastMessage(e.toString());
          print(phonecontroller);
          setState(() {
            loading= false;
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("What's your phone number?", style: fontSize20,),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: IntlPhoneField(
                          initialCountryCode: 'PK',
                          keyboardType: TextInputType.phone,
                          controller: phonecontroller,
                          style: const TextStyle(color: Colors.black, fontSize: 20),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.phone,),
                            hintText: 'Enter phone number',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:  BorderSide(color: themecolor,),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: themecolor,)
                            ),

                          ),
                          onChanged: (phone) {
                            Ccode = phone.countryCode;
                          },

                        ),
                      ),

                    ],
                  )),
              ButtonRound(text: 'Login', loading: loading, ontap: () async {
                if(_formKey.currentState!.validate()){
                  isLogin();

                }
              },),

              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                child: Stack(
                  children: [
                    Divider(),
                    Center(
                      child: Container(
                        width: 50,
                        height: 25,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text('or', style: fontSize20,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  googleLogin();
                  getUserCurrentLocation().then((value) {
                    stlang = value.longitude;
                     stlat = value.latitude;
                  });
                  print('hello');
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      color: themecolor
                  ),
                  width: MediaQuery.of(context).size.width * 0.96,
                  child: Row(crossAxisAlignment:
                  CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [

                     Image(
                         height: 50,
                         width: 50,
                         image: AssetImage('images/google.png')),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Continue with google '),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: InkWell(
                  onTap: ()async{
                    try{
                      final fbloginresult = await FacebookAuth.instance.login();
                      final userData = await FacebookAuth.instance.getUserData();
                      final fbauthcredential = FacebookAuthProvider.credential(fbloginresult.accessToken!.token);
                      await FirebaseAuth.instance.signInWithCredential(fbauthcredential);

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const BottomBar()));
                    } on FirebaseAuthException catch(e){
                      var content = '';
                      switch(e.code){
                        case 'account-exists-with-different-credential':
                          content = 'This accouint exists with different sign in provider';
                          break; }
                      showDialog(context: context, builder: (context)=> AlertDialog(
                        title: const Text(' log in failed'),
                        content: Text(content),
                        actions: [TextButton(onPressed: (){
                          Navigator.of(context).pop();
                        },
                            child: const Text('ok'))],
                      ));
                    } finally{
                      setState(() {
                      }
                      );
                    }

                  },
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                        color: themecolor
                    ),
                    width: MediaQuery.of(context).size.width * 0.96,
                    child: Row(crossAxisAlignment:
                    CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [

                        Image(
                            width: 40,
                            height: 40,
                            image: AssetImage('images/facebook.png')),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Continue with Facebook'),
                      ],
                    ),
                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 20.0),
                 child: Center(child: Text('Find  my account', )),
               )
            ],
          ),
        ),
      ),
    );
  }
}
