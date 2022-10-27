import 'package:flutter/material.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';


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

void main() {
  runApp( MaterialApp(

    // initialRoute: '/home', will make app go to home page first
    // initialRoute: '/home',
    // initialRoute: '/', will make app follow the routes pages
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
    },
  ));
}
