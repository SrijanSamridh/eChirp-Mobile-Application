import 'package:echirp/screens/events/components/event_cerate_form.dart';
import 'package:flutter/material.dart';

import '../../components/custom_dropdown.dart';
import '../../components/custom_sub_dropdown.dart';
import '../../utils/global_variabes.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = '/create-event';
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  // Initial dropdown values
  String dropdownValue = GlobalVariables.kEventCategory.first;
  String dropdownSubValue = GlobalVariables
      .kEventSubCategory[GlobalVariables.kEventCategory.first]!.first;
  String dropdownSubSubValue = '';

  // Lists to store dropdown options
  // List<String> dropdownSubCategories = <String>[];
  List<String> dropdownSubSubCategories = <String>[];

  @override
  void initState() {
    super.initState();
    // Set initial dropdown values
    setState(() {
      dropdownSubValue =
          GlobalVariables.kEventSubCategory[dropdownValue]!.first;
      // dropdownSubSubValue =
      //     GlobalVariables.kEventSubSubCategory[dropdownSubValue]!.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Image(
                image: AssetImage('assets/images/create-event.png'),
              ),
              const Text(
                'CREATE YOUR EVENT',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
                textAlign: TextAlign.center,
                "Let's start by selecting the category so people can identify and easily search your event. Select from the drop down list below. If it doesnt match any of the categories, choose other and detail it in \"event description\" please. You'll see it in the next few steps, don't fret!",
                style: TextStyle(
                  fontSize: size.height * 0.013
                ),
              ),

              const Text(
                'Select category',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),

              // Dropdown for selecting main category
              CustomSubDropdown(
                dropdownValue: dropdownValue,
                size: size,
                onChanged: (String? value) {
                  setState(() {
                    // set the dropdown value for the category
                    dropdownValue = value!;

                    // set the dropdown value for the Sub-category
                    dropdownSubValue =
                        GlobalVariables.kEventSubCategory[value]?.first ?? '';
                    // dropdownSubCategories =
                    //     GlobalVariables.kEventSubCategory[value] ?? [];

                    // set the dropdown value for the Sub-Sub-Category
                    dropdownSubSubValue = "";
                    dropdownSubSubCategories =
                        GlobalVariables.kEventSubSubCategory[value] ?? [];
                  });
                },
                categorySubcategories: GlobalVariables.kEventSubCategory,
              ),

              const Text(
                'Select sub-category',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 24),
              ),

              // Dropdown for selecting sub-category
              CustomDropdown(
                dropdownValue: dropdownSubValue,
                size: size,
                onChanged: (String? value) {
                  setState(() {
                    // set the dropdown value for the Sub-Category
                    dropdownSubValue = value!;

                    // set the dropdown value for the Sub-Sub-Category
                    dropdownSubSubValue = '';
                    dropdownSubSubCategories =
                        GlobalVariables.kEventSubSubCategory[value] ?? [];
                    try {
                      dropdownSubSubValue = dropdownSubSubCategories.first;
                    } catch (err) {
                      dropdownSubSubValue = '';
                    }
                  });
                },
                categories:
                    GlobalVariables.kEventSubCategory[dropdownValue] ?? [],
              ),

              // ! Error on this section
              if (dropdownSubSubCategories.isNotEmpty)
                const Text(
                  'Select sub-sub-category',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 24),
                ),

              // Dropdown for selecting sub-sub-category
              if (dropdownSubSubCategories.isNotEmpty)
                CustomDropdown(
                  dropdownValue: dropdownSubSubValue,
                  size: size,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownSubSubValue = value!;
                    });
                  },
                  categories: dropdownSubSubCategories,
                ),
              // TODO: Need to check the above section

              SizedBox(height: size.height * 0.01),
              GestureDetector(
                onTap: () {
                  debugPrint(
                      'Category: $dropdownValue\nSub-Categpory: $dropdownSubValue\nSub-Sub Category: $dropdownSubSubValue');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventCreateFrom(
                                category: dropdownValue,
                                subCategory: dropdownSubValue,
                                subSubCategory: dropdownSubSubValue,
                              )));
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    gradient: GlobalVariables.colors.primaryGradient,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: size.width * 0.12,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
