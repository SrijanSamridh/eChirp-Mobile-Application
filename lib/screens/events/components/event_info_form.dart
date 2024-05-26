import 'package:echirp/components/custom_fields.dart';
import 'package:flutter/material.dart';

import '../../../utils/global_variables.dart';

class EventInfoForm extends StatefulWidget {
  const EventInfoForm({
    super.key,
    required this.size,
    required this.dateController,
    required this.startTimeController,
    required this.endTimeController,
    required this.locationController,
    required this.nameOfPlaceController,
    required this.addressController,
  });

  final Size size;
  final TextEditingController dateController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final TextEditingController locationController;
  final TextEditingController nameOfPlaceController;
  final TextEditingController addressController;

  @override
  State<EventInfoForm> createState() => _EventInfoFormState();
}

class _EventInfoFormState extends State<EventInfoForm> {
  String max = GlobalVariables.kOccupations[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // date
        CustomFields().customLabel(widget.size, context,
            'assets/icons/lets-icons_date-today-duotone.png', "Date"),
        CustomFields().customDatePickerField(widget.size, context, widget.dateController),

        // time
        CustomFields()
            .customLabel(widget.size, context, 'assets/icons/uiw_time.png', "Time"),
        CustomFields().customTimePickerField(
            widget.size, context, widget.startTimeController, widget.endTimeController),

        // location
        CustomFields().customLabel(
            widget.size, context, 'assets/icons/ion_location.png', 'Location'),
        CustomFields().customTextFormField(widget.size, context, widget.locationController,
            "Location", TextInputType.streetAddress),

        // Name of the place
        CustomFields().customLabel(widget.size, context,
            'assets/icons/mingcute_building-2-fill.png', 'Name of the place'),
        CustomFields().customTextFormField(widget.size, context, widget.nameOfPlaceController,
            "Name of the place", TextInputType.name),

        // Address
        CustomFields()
            .customLabel(widget.size, context, 'assets/icons/Vector.png', 'Address'),
        CustomFields().customTextFormField(widget.size, context, widget.addressController,
            "Address", TextInputType.streetAddress),

        
        // ElevatedButton(
        //   onPressed: () {
        //     // Validate returns true if the form is valid, or false otherwise.
        //     if (_formKey.currentState!.validate()) {
        //       // If the form is valid, display a snackbar. In the real world,
        //       // you'd often call a server or save the information in a database.
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(
        //             content: Text(
        //                 'Processing Data ${dateController.text}')),
        //       );
        //     }
        //   },
        //   child: const Text('Submit'),
        // ),
      ],
    );
  }
}
