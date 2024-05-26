import 'package:flutter/material.dart';

import '../utils/global_variables.dart';

class CustomFields {
  Padding customLabel(
      Size size, BuildContext context, String iconPath, String label,
      {bool optional = false}) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 15.0, bottom: 10.0, right: 8.0, left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image(
                image: AssetImage(iconPath),
              ),
              SizedBox(width: size.width * 0.01),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(width: size.width * 0.01),
          optional == true
              ? const Text(
                  'Optional',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold),
                )
              : const Text(''),
        ],
      ),
    );
  }

  Padding customTextFormField(
      Size size,
      BuildContext context,
      TextEditingController controller,
      String label,
      TextInputType keyboardType,
      {EdgeInsets contentPadding = const EdgeInsets.fromLTRB(10, 14, 10, 0)}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        style: const TextStyle(fontSize: 14.0),
        decoration: InputDecoration(
          label: Text(label),
          isDense: true,
          contentPadding: contentPadding,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: GlobalVariables.colors.primary),
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: GlobalVariables.colors.primary),
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }

  Padding customDatePickerField(
      Size size, BuildContext context, TextEditingController dateCtl) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.36,
            child: TextFormField(
              controller: dateCtl,
              decoration: InputDecoration(
                labelText: "YYYY-MM-DD",
                hintText: "YYYY-MM-DD",
                isDense: true,
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: GlobalVariables.colors.primary),
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
              ),
              onTap: () async {
                DateTime? date = DateTime(1900);
                FocusScope.of(context).requestFocus(FocusNode());
            
                date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
            
                dateCtl.text = date!.toIso8601String().split("T")[0];
              },
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding customTimePickerField(Size size, BuildContext context,
      TextEditingController startTimeCtl, TextEditingController endTimeCtl) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: startTimeCtl,
              decoration: InputDecoration(
                labelText: "Start Time",
                hintText: "HH:mm",
                isDense: true,
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: GlobalVariables.colors.primary,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
              onTap: () async {
                TimeOfDay? time = TimeOfDay.now();
                FocusScope.of(context).requestFocus(FocusNode());

                time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                // ignore: use_build_context_synchronously
                startTimeCtl.text = time!.format(context);
              },
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(" to "),
          ),
          Expanded(
            child: TextFormField(
              controller: endTimeCtl,
              decoration: InputDecoration(
                labelText: "End Time",
                hintText: "HH:mm",
                isDense: true,
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: GlobalVariables.colors.primary,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
              onTap: () async {
                TimeOfDay? time = TimeOfDay.now();
                FocusScope.of(context).requestFocus(FocusNode());

                time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                // ignore: use_build_context_synchronously
                endTimeCtl.text = time!.format(context);
              },
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
