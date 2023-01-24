import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber_clone/user/account.dart';
import 'package:uber_clone/user/activity.dart';
import 'package:uber_clone/user/home.dart';


class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with TickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;
  var  stlang;
  var stlat;

  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace) {
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition().then((value) {


    setState(()  {
     stlat = value.latitude;
        stlang = value.longitude;
      });
      return value;
    });

  }

  onItemClicked(int index){

    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
      getUserCurrentLocation().then((value) {
        stlang = value.longitude;
        stlat = value.latitude;
        print(stlat);
      });


    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    Geolocator.getCurrentPosition().then((value) {
      stlat = value.latitude;
      print(stlat);
      stlang = value.longitude;
      print(stlang);
    });
  }
  @override
  Widget build(BuildContext context) {
    //  getUserCurrentLocation().then((value) {
    //   stlat = value.latitude;
    //   stlang = value.longitude;
    // });
    return Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children:  [
            HomeScreen(lat: stlat?? 15.67 , long: stlang ?? 15.7654),
            ActivityScreen(),
            AccountScreen(),
          ],
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          )
        ],
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
    );
  }
}
