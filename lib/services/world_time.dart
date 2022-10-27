//import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime{

  late String location; //location name for the UI
  late String time; // the time in that location, this will be set after getTime() called by others
  late String flag; // url to an asset flag icon
  late String urlString; //location url for api endpoint e.g. Australia/Adelaide
  bool isDayTime = true; //ture or false if daytime or not

  //Create a constructor for the above parameters
  WorldTime({ required this.location, required this.flag, required this.urlString });

  //this is for getData() testing only
  //void getData() async {

  //this is for getTime() function to
  Future<void> getTime() async {

/*
    //this is for await Future.delayed testing only
    //simulate network request for a Text1
    String Text1 = await Future.delayed(Duration(seconds: 3), () {
      return 'Text1 String';
    });

    //simulate network request to get Text2 of the Text1
    String Text2 = await Future.delayed(Duration(seconds: 2), () {
      return 'Text2 String';
    });

    print('$Text1 - $Text2');
*/

/*
    //this is for getData() testing only
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
    var response = await http.get(url);
    Map data = jsonDecode(response.body);
    print(data);
    print(data['title']);
*/

    //for Error Handling, try to get time back, if not success, go to catch { do something}
    try{
      // When using await, the async keyword must be declare in this getTime() function
      var url = Uri.parse('http://worldtimeapi.org/api/timezone/$urlString');
      var response = await http.get(url);

      //check #23 if you don't understand Map usage
      Map data = jsonDecode(response.body);
      //print(data); //print data is down below

      /*
    {abbreviation: ACDT, client_ip: 149.167.169.40,
    datetime: 2022-10-27T06:47:50.294574+10:30, day_of_week: 4,
    day_of_year: 300, dst: true, dst_from: 2022-10-01T16:30:00+00:00,
    dst_offset: 3600, dst_until: 2023-04-01T16:30:00+00:00,
    raw_offset: 34200, timezone: Australia/Adelaide, unixtime: 1666815470,
    utc_datetime: 2022-10-26T20:17:50.294574+00:00, utc_offset: +10:30, week_number: 43}
      */

      //get information from the above timezone data string
      String datetime = data['datetime'];
      //print(datetime); //2022-10-27T06:45:29.690482+10:30

      //get properties from data, substring() can get the words you need in between offset String
      //in some City, the offset has hours and minutes, so change it if needed
      //String offset = data['utc_offset'].substring(1,3);
      String offset_hours = data['utc_offset'].substring(1,3);
      String offset_minutes = data['utc_offset'].substring(4,6);
      //print(offset); //+10:30
      //print(offset_hours); //10
      //print(offset_minutes); //30

      //create DateTime object, parse to change format and add offset hours, minutes to the current time zone
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset_hours),minutes: int.parse(offset_minutes)));
      //print(now); //2022-10-26 20:17:50.294574Z

      //change time zone data to String type and set the time property
      //time = now.toString();

      //use the import intl.dart libs to reformat time for more human readable e.g. 11:46 AM
      time = DateFormat.jm().format(now);
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    }
    catch (e) {
      //print error in the Console, try to find error msg start with 'caught error' key word
      print('caught error: $e');
      //error occur, so set time parameter to notice user on the screen
      time = 'could not get time data';
    }
  }
}

