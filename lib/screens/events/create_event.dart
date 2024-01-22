import 'package:echirp/screens/events/components/event_cerate_form.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';

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
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.arrow_drop_down_circle,
                    color: GlobalVariables.kPrimaryColor,
                  ),
                ),
                elevation: 16,
                style: const TextStyle(
                    color: Color.fromARGB(255, 87, 47, 14), fontSize: 14.0),
                underline: Container(
                  height: 2,
                  color: GlobalVariables.kPrimaryColor,
                  width: size.width * 0.2,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: GlobalVariables.kEventCategory
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context)
                  //     .pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const BottomBar()), (route) => false);
                  Navigator.of(context)
                      .pushNamed(EventCreateFrom.routeName, arguments: dropdownValue);
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
