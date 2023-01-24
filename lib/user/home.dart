import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/components/constants.dart';
import 'package:uber_clone/user/account.dart';
import 'package:uber_clone/user/activity.dart';

import '../maps/maps_screen.dart';

class HomeScreen extends StatefulWidget {
  final double lat,long;
  const HomeScreen({Key? key, required this.lat, required this.long,}) : super(key: key);
 
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var stlat, stlang;

  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace) {
      print('error ha bhai' + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(12, 13.2312),
      zoom: 14);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  children: [
                   Flexible (
                      child: Text('Good Evening, Syed Taimoor', style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 15),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                        height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: themecolor,
                      ),
                        child: Icon(Icons.location_on)
                    ),
                     SizedBox(
                       width: MediaQuery.of(context).size.width * 0.02,                     ),
                     Expanded(
                       child: Column(
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Mardan',style: TextStyle(
                                    fontSize: 20,
                                    //   fontWeight: FontWeight.bold
                                  )),

                                  Text('Khyber Pukhtunkhwa'),

                                ],
                              ),

                              Icon(Icons.arrow_forward_ios_rounded)
                            ],
                    ),
                         ],
                       ),
                     )

                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                child: Row(
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: themecolor,
                        ),
                        child: Icon(Icons.star)
                    ),
                     SizedBox(
                       width: MediaQuery.of(context).size.width * 0.02,
                     ),
                     Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Choose a saved place',style: TextStyle(
                                fontSize: 20,
                                //   fontWeight: FontWeight.bold
                              )),

                              Icon(Icons.arrow_forward_ios_rounded)
                            ],
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
              Divider(),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Text('Around you', style: fontSize20,),
                  ],
                ),
              ),
              InkWell(
                onTap:()async{
                  getUserCurrentLocation().then((value)async {
                     var lang = value.longitude;
                    var lat = value.latitude;
                    print(lang);
                     print(lat);
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> MapsScreen(lat: lat, lang: lang,)));
                  });

                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(
                        myLocationEnabled: true,
                        scrollGesturesEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        initialCameraPosition:
                        CameraPosition(
                            target: LatLng(widget.lat,widget.long),

                            zoom: 14
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)
                        ),
                        
                      )
                    ],
                  )
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
