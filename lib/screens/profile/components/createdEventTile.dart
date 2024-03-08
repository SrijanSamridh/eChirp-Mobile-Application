import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  final String category;
  final String title;
  final String date;
  final String time;
  final String imageUrl;

  const EventTile({
    super.key,
    required this.category,
    required this.title,
    required this.date,
    required this.time,
    required this.imageUrl

  });
  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 115,
              height: 95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                

              ),
              child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(imageUrl, fit: BoxFit.fill),
          ),
              
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined,size: 16,),
                              SizedBox(width: 5),
                      Text(date),
                            ],
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Icon(Icons.access_time_filled_rounded,size: 16,color: Colors.grey[700],),
                          SizedBox(width: 5),
                      Text(time),
                        ],
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

