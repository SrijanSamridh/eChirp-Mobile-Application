import 'package:flutter/material.dart';

class EventCreateFrom extends StatefulWidget {
  static const String routeName = "/event-create-form";
  const EventCreateFrom({super.key, required this.category});
  final String category;

  @override
  State<EventCreateFrom> createState() => _EventCreateFromState();
}

class _EventCreateFromState extends State<EventCreateFrom> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event Details",
          style: TextStyle(fontSize: size.height * 0.02, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(child: Text('dropdown value: ${widget.category}')),
    );
  }
}
