import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void getLocation() async {
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  print(position);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool light0 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Attendance')),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(18),
                width: MediaQuery.of(context).size.width * .90,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                height: 75,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Text(
                          'Give Location Access',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Transform.scale(
                          scale: 1.5,
                          child: Switch(
                            activeColor: Colors.white,
                            value: light0,
                            onChanged: (bool value) {
                              setState(() {
                                getLocation();
                                light0 = value;
                              });
                            },
                          ),
                        )
                      ]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .65,
            width: double.infinity,
            child: ListView.builder(
                itemCount: 25,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Color.fromRGBO(0, 0, 0, 0.688),
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Professor: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Text(
                              'Lecture name:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Text(
                              'Room no:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Text(
                              'Timing:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // ElevatedButton(
                                //   onPressed: () {
                                //     getLocation;
                                //   },
                                //   child: const Text('Mark Atttendance'),
                                //   style: ElevatedButton.styleFrom(
                                //       primary: Colors
                                //           .redAccent, //background color of button
                                //       side: BorderSide(
                                //           width: 3,
                                //           color: Colors
                                //               .brown), //border width and color
                                //       elevation: 3, //elevation of button
                                //       shape: RoundedRectangleBorder(
                                //           //to set border radius to button
                                //           borderRadius:
                                //               BorderRadius.circular(30)),
                                //       padding: EdgeInsets.all(8)),
                                // )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          // Row(children: [
          //   Container(
          //     margin: const EdgeInsets.all(20),
          //     decoration: const BoxDecoration(
          //       color: Colors.blue,
          //       borderRadius: BorderRadius.all(Radius.circular(25)),
          //     ),
          //     height: 200,
          //     child: Column(
          //       children: <Widget>[
          //         const Text(
          //           'data',
          //           style: TextStyle(
          //               fontSize: 25,
          //               color: Colors.white,
          //               fontWeight: FontWeight.bold),
          //         ),
          //       ],
          //     ),
          //   ),
          // ]),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              currentAccountPicture: Image.network(
                  'https://th.bing.com/th?id=ODL.b888a41f9a8eb720963897b5e5430fc1&w=100&h=100&c=12&pcl=faf9f7&o=6&dpr=1.3&pid=13.1'),
              accountName: Text('Welcome  Emma'),
              accountEmail: Text('emma@ternaengg.ac.in'),
            ),
            ListTile(
              title: const Text('View Timetable'),
              onTap: () {
                // Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const Timetable()),
                // );
              },
            ),
            ListTile(
              title: const Text('View Attendance'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
