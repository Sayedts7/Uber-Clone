import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:uber_clone/auth/login.dart';
import 'package:uber_clone/components/constants.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  final colorList = <Color>[

    Color(0xffFFFFFF),
    Color(0xffFFFFFF),
    Color(0xff4285f4),
  ];

  final googleSignIn = GoogleSignIn();
  Future Signout() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      StreamBuilder(
                          stream: FirebaseAuth.instance.authStateChanges(),
                          builder: (context, snapshot){
                          if( snapshot.hasData) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snapshot.data!.displayName.toString(), style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                )),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.06,
                                ),
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(snapshot.data!.photoURL.toString()),
                                )
                              ],
                            );
                          } else if( snapshot.hasError) {
                            return Center(
                              child: Text('Something went wrong'),
                            );
                          }
                          else {

                          }
                            return Text('erroe');
                          }),

                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 25,
                        decoration: BoxDecoration(
                          color: themecolor,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.star, size: 12, color: Colors.black,),
                              Text('5.0')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.27,
                          decoration: BoxDecoration(
                            color: themecolor,
                              borderRadius: BorderRadius.circular(10)

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Icon(Icons.help, size: 30,),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text('Help', style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),

                        ),

                        Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.27,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                            color: themecolor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Icon(Icons.wallet, size: 30,),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text('Wallet', style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),

                        ),

                        Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.27,
                          decoration: BoxDecoration(
                            color: themecolor,
                              borderRadius: BorderRadius.circular(10)

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Icon(Icons.watch_later, size: 30,),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text('Trips', style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),

                        )
                      ],
                    ),
                  ),
                   Padding(
                     padding: const EdgeInsets.only(top: 20.0,),
                     child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                          color: themecolor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text('Safety checkup', style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  Flexible(child: Text('Boost your safety by  turning on additional features')),
                                ],
                              ),
                            ),
                            PieChart(
                              dataMap: {
                                'Trusted Contacts': 1,
                               'Ride Check' : 1,
                                'Pin verification' :1,
                              },
                              // chartValuesOptions: ChartValuesOptions(
                              //     showChartValuesInPercentage: false),
                              chartRadius:
                              MediaQuery.of(context).size.width / 2.2,
                              legendOptions: LegendOptions(
                                showLegends: false,
                              ),
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: false,
                                showChartValuesOutside: false,
                                showChartValueBackground: false
                              ),
                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),

                          ],
                        ),
                      ),
                  ),
                   )


                ],
              ),

            ),
            Divider(
              thickness: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.mail),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.06,
                        ),
                        Text('Messages', style: fontSizebold,),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 20),
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.06,
                        ),
                        Text('Settings', style: fontSizebold,),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 20),
                    child: Row(
                      children: [
                        Icon(Icons.manage_accounts),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.06,
                        ),
                        Text('Earn by driving or delivering', style: fontSizebold,),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 20),
                    child: Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.06,
                        ),
                        Text('Legal', style: fontSizebold,),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 20),
                    child: InkWell(
                      onTap: (){
                        Signout();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.info),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          Text('Sign out', style: fontSizebold,),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ) ,),
    );
  }
}
