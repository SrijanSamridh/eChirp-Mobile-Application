import 'package:dotted_line/dotted_line.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text('Profile'),
          ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Image, Name, and Add Friend Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                        gradient: GlobalVariables.kPrimaryGradientColor,
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  //SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Meg Johnson',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text('Artist')
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: GlobalVariables.kPrimaryGradientColor
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Handle add friend action
                      },
                      child: Text('Add Friend',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              // User Bio
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla consequat odio in turpis tempor',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              SizedBox(height: 20),
              // Stats Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  height: 95,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '10', // Replace with actual number of events created
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            'Events Created',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      DottedLine(
                        direction: Axis.vertical,
                        dashColor: Colors.white,
                        lineThickness: 1.5,
                      ),
                      SizedBox(width: 8,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '38.2k', // Replace with actual number of events created
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            'Friends',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(width: 8,),
                      DottedLine(
                        direction: Axis.vertical,
                        dashColor: Colors.white,
                        lineThickness: 1.5,
                      ),
                      
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '58', // Replace with actual number of events created
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            'Events Attended',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Events Created
              Text(
                'My Created Events',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // List of events created
              Container(
                height: 150, // Adjust height as needed
                child: ListView.builder(
                  itemCount: 5, // Replace with actual number of events created
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      color: Colors.grey,
                      height: 50,
                      child: Center(child: Text('Event $index')),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              // Events Attended
              Text(
                'Events Attended',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Horizontal list of events attended
              Container(
                height: 100, // Adjust height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Replace with actual number of events attended
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      color: Colors.grey,
                      width: 150,
                      child: Center(child: Text('Event $index')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
