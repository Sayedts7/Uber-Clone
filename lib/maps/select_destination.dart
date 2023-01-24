import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/components/constants.dart';
import 'package:uber_clone/user/home.dart';

class SearchDestination extends StatefulWidget {
  var lat, lang;
  SearchDestination({Key? key, required this.lat, required this.lang}) : super(key: key);

  @override
  State<SearchDestination> createState() => _SearchDestinationState();
}

class _SearchDestinationState extends State<SearchDestination> {

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

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: (){

                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.169,

                      child: Column(
                        children: [
                          Row(
                            children: [
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                                 child: InkWell(
                                     onTap: (){
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen(lat: widget.lat, long:  widget.lang,)));

                                     },
                                     child: Icon(Icons.arrow_back)),
                               )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),

                                      hintText: ' Your Location',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                                  enabled: true,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: ' Your Location',
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      )
                    ),
                  ),
                ],
              ),
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

            ],
          ),
        ),
      ),
    );

  }

}
