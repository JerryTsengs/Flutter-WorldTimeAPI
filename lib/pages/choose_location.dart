import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';


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

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
/*
  //this is ElevatedButton style for below "body: ElevatedButton()"
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  int counter = 0;
*/

  //List for other countries
  List<WorldTime> locations = [
    WorldTime(urlString: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(urlString: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(urlString: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(urlString: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(urlString: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(urlString: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(urlString: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(urlString: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];


  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('2 build function ran');
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  print(locations[index].location);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        }
      ),
/*
      //this is ElevatedButton example, and it uses the style above
      ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () {
          setState(() {
            counter += 1;
          });
        },
        child: Text('counter is $counter'),
      ),
*/



    );
  }
}

