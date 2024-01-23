import 'package:echirp/screens/events/components/event_cerate_form.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';

import '../../components/custom_dropdown.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = '/create-event';
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  String dropdownValue = GlobalVariables.kEventCategory.first;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Image(image: AssetImage('assets/images/create-event.png')),
              const Text(
                'CREATE YOUR EVENT',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const Text(
                textAlign: TextAlign.center,
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla consequat odio in turpis tempor condimentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                style: TextStyle(),
              ),
              const Text(
                'Select  category',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              CustomDropdown(
                  dropdownValue: dropdownValue,
                  size: size,
                  onChnaged: (String? value) {
                    // This is called when the user selects an item.
                    setState(
                      () {
                        dropdownValue = value!;
                      },
                    );
                  }, categorys: GlobalVariables.kEventCategory,),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(EventCreateFrom.routeName,
                      arguments: dropdownValue);
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    gradient: GlobalVariables.kPrimaryGradientColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: size.width * 0.12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}