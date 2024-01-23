import 'package:echirp/components/custom_fields.dart';
import 'package:flutter/material.dart';

class EventInfoForm extends StatelessWidget {
  const EventInfoForm({
    super.key,
    required this.size,
    required this.dateController,
    required this.startTimeController,
    required this.endTimeController,
    required this.locationController,
    required this.nameOfPlaceController,
    required this.addressController,
    required this.maxMemberController,
  });

  final Size size;
  final TextEditingController dateController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final TextEditingController locationController;
  final TextEditingController nameOfPlaceController;
  final TextEditingController addressController;
  final TextEditingController maxMemberController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // date
        CustomFields().customLabel(size, context,
            'assets/icons/lets-icons_date-today-duotone.png', "Date"),
        CustomFields().customDatePickerField(size, context, dateController),

        // time
        CustomFields()
            .customLabel(size, context, 'assets/icons/uiw_time.png', "Time"),
        CustomFields().customTimePickerField(
            size, context, startTimeController, endTimeController),

        // location
        CustomFields().customLabel(
            size, context, 'assets/icons/ion_location.png', 'Location'),
        CustomFields().customTextFormField(size, context, locationController,
            "Location", TextInputType.streetAddress),

        // Name of the place
        CustomFields().customLabel(size, context,
            'assets/icons/mingcute_building-2-fill.png', 'Name of the place'),
        CustomFields().customTextFormField(size, context, nameOfPlaceController,
            "Name of the place", TextInputType.name),

        // Address
        CustomFields()
            .customLabel(size, context, 'assets/icons/Vector.png', 'Address'),
        CustomFields().customTextFormField(size, context, addressController,
            "Address", TextInputType.streetAddress),

        // Max Member
        CustomFields().customLabel(
            size,
            context,
            'assets/icons/fluent_people-12-filled.png',
            'Maximum number of people'),
        CustomFields().customTextFormField(size, context, maxMemberController,
            "i.e, 10", TextInputType.number),

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
