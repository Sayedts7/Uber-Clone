import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/components/constants.dart';
import 'package:uber_clone/maps/select_destination.dart';
import 'package:uber_clone/maps/test.dart';

class MapsScreen extends StatefulWidget {
   var lat, lang;
   MapsScreen({Key? key, required this.lat, required this.lang}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
 
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(12, 13.2312),
      zoom: 14);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('yahan hn maaaaaaa' );
    print(widget.lat);

  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.74,
                child: GoogleMap(initialCameraPosition:  CameraPosition(target: LatLng(widget.lat, widget.lang), zoom: 14),
                  myLocationEnabled: true,
                  mapToolbarEnabled: true,
                  onMapCreated: (GoogleMapController controller){
                    _controller.complete(controller);
                  },
                )
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MapScreen(lat: widget.lat, lang: widget.lang)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .9,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: themecolor,
                      ),
                      child: Center(child:Text( 'Search Destination', style: TextStyle(fontSize: 25, color: Colors.white),)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
