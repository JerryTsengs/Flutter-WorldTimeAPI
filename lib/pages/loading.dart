import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


/* This is a Stateful widgets lifecycle example */

// Stateful Widgets have 3 states
// 1. initState()
//     Called only once when the widget is created
//     Subscribe to streams or any object that could change our widget data
// 2. Build()
//     Builds the widget tree
//     A build is triggered every time we use setState()
// 3. Dispose()
//     When the widget / state object is removed

bool kDebugMode = false;

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  //set initial "time" String to show on the screen at beginning, and this  "time" will be change after running setupWorldTime()
  String time = 'loading';

  void setupWorldTime() async {

    //declare a WorldTime class and name it 'instance', assign time zone data to WorldTime constructor
    WorldTime instance = WorldTime(location: 'Adelaide', flag: 'australia.png', urlString: 'Australia/Adelaide');
    //print(instance.location);
    //print(instance.flag);
    //print(instance.urlString);

    // for this instance to call getTime(), it takes sometimes to finish before data comes back
    // so use await keyword to wait until finish, and we can print data in this instance
    // BTW, when using await, the async keyword must be declare in this setupWorldTime() function
    await instance.getTime();
    //print(instance.time);

    //this route Navigator will replace the initState() page underneath
    //this route also pass three arguments which received for the above instance.getTime() api;
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDayTime
    });
  }



  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('1 initState function ran');
    }
    setupWorldTime();
/*
    //this is for getData() testing only
    getData();
    print('I will print before getData()');
*/

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        //install flutter_spinkit, than call spin functions
        //visit https://pub.dev/packages/flutter_spinkit for more spinkit
        child:  SpinKitThreeBounce(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
