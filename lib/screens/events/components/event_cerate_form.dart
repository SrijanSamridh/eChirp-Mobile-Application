// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:echirp/API/controller/event.controller.dart';
import 'package:echirp/components/custom_dropdown.dart';
import 'package:echirp/components/custom_fields.dart';
import 'package:echirp/screens/events/components/custom_stepper_count.dart';
import 'package:echirp/screens/events/components/event_info_form.dart';
// import 'package:echirp/screens/events/components/upload_status.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import 'upload_status.dart';

class EventCreateFrom extends StatefulWidget {
  static const String routeName = "/event-create-form";
  const EventCreateFrom(
      {super.key,
      required this.category,
      required this.subCategory,
      this.subSubCategory});
  final String category;
  final String subCategory;
  final String? subSubCategory;

  @override
  State<EventCreateFrom> createState() => _EventCreateFromState();
}

class _EventCreateFromState extends State<EventCreateFrom> {
  int currentIndex = 1;
  final _formKey = GlobalKey<FormState>();
  String ageGroupRange = GlobalVariables.kAgeGroups[0];
  String occupationValue = GlobalVariables.kOccupations[0];

  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController nameOfPlaceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String maxMemberController = GlobalVariables.kMaxMemberCount[0];
  TextEditingController femaleCntController = TextEditingController();
  TextEditingController maleCntController = TextEditingController();
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  EventType? _type = EventType.PUBLIC;
  Gender? _gender;
  File? image1;
  Color borderColor = GlobalVariables.kPrimaryColor;
  double stroke = 1;
  File? image2;
  File? image3;
  File? image4;
  File? image5;

  void selectImage(int index) async {
    var res = await pickImages();
    if (res.isNotEmpty) {
      setState(() {
        switch (index) {
          case 1:
            image1 = res.first;
            break;
          case 2:
            image2 = res.first;
            break;
          case 3:
            image3 = res.first;
            break;
          case 4:
            image4 = res.first;
            break;
          case 5:
            image5 = res.first;
            break;
        }
        // debugPrint('Image $index selected: ${res.first.path}');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      stroke = 1;
      borderColor = GlobalVariables.kPrimaryColor;
    });
  }

  void _handleSubmitButton() async {
    // Validate the form
    if (!_formKey.currentState!.validate()) {
      // If the form is not valid, set border color to red
      setState(() {
        borderColor = Colors.red;
        stroke = 2;
      });
      return; // Exit the method
    }

    // Prepare data for API
    Map<String, dynamic> dataMap = {
      "mainCategory": widget.category,
      "subCategory": widget.subCategory,
      "subSubCategory": widget.subSubCategory ?? "",
      "dateOfEvent": dateController.text,
      "startTime": startTimeController.text,
      "endTime": endTimeController.text,
      "location": locationController.text,
      "nameOfPlace": nameOfPlaceController.text,
      "address": addressController.text,
      "maxParticipants": 20,
      "eventMode": _type.toString().split('.')[1], //! error on server
      "ageRange": "18-40",
      "gender": "Any",
      "occupation": occupationValue,
      "eventTitle": eventTitleController.text,
      "eventDescription": eventDescriptionController.text,
      "coverImgUrl": image1?.path ??
          "https://media.istockphoto.com/id/1913125761/photo/silhouettes-of-people-dancing-and-rising-hands-at-open-air-summer-festival.webp?b=1&s=170667a&w=0&k=20&c=50RtfZ05NSgpYdSgWpOf5ePkp5yRwVdb2atxzqmRKY4=",
      "Img1Url": "https://example.com/image1.jpg",
      "Img2Url": "https://example.com/image2.jpg",
      "Img3Url": "https://example.com/image3.jpg",
      "Img4Url": "https://example.com/image4.jpg"
    };
    // print and check whats the out put of the _type
    print(_type);
    try {
      // Make API call to create event
      var response = await EventController().createEvent(dataMap);

      // Check if API call was successful
      if (response.statusCode == 201) {
        // If event creation is successful, navigate to UploadStatusScreen
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => UploadStatusScreen(
              eventType: _type.toString(),
            ),
          ),
          (route) => false,
        );
      } else {
        // ignore: avoid_print
        print('status: ${response.statusCode}, ${response.body}');
        // If API call fails, show error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to create event. Please try again. \nError: ${response.body}'),
          ),
        );
      }
    } catch (e) {
      // If an error occurs during API call, show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while creating event.'),
        ),
      );
      debugPrint('Error creating event: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    locationController.dispose();
    nameOfPlaceController.dispose();
    addressController.dispose();
    // maxMemberController.dispose();
    femaleCntController.dispose();
    maleCntController.dispose();
    eventTitleController.dispose();
    eventDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = size.height * 0.15;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event Details",
          style: TextStyle(
              fontSize: size.height * 0.02, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomStepperCount(currentIndex: currentIndex, size: size),
                Form(
                  key: _formKey,
                  child: currentIndex == 1
                      ? Column(
                          children: [
                            EventInfoForm(
                              size: size,
                              dateController: dateController,
                              startTimeController: startTimeController,
                              endTimeController: endTimeController,
                              locationController: locationController,
                              nameOfPlaceController: nameOfPlaceController,
                              addressController: addressController,
                            ),
                            // Max Member
                            CustomFields().customLabel(
                                size,
                                context,
                                'assets/icons/fluent_people-12-filled.png',
                                'Maximum number of people'),
                            // CustomFields().customTextFormField(size, context, maxMemberController,
                            //     "i.e, 10", TextInputType.number)
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.08),
                                  child: CustomDropdown(
                                    dropdownValue: maxMemberController,
                                    size: size,
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(
                                        () {
                                          maxMemberController = value!;
                                        },
                                      );
                                    },
                                    categories: GlobalVariables.kMaxMemberCount,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      : currentIndex == 2
                          // From part 2
                          ? eventSpecification(size, context)
                          // From part 3
                          : uploadData(size, context, height),
                ),
                SizedBox(height: size.height * 0.05),
                currentIndex >= 3
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          currentIndex > 1
                              ? TextButton(
                                  onPressed: () {
                                    setState(() {
                                      currentIndex--;
                                    });
                                  },
                                  child: const Text('back'),
                                )
                              : SizedBox(width: size.width * 0.1),
                          currentIndex < 3
                              ? ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              GlobalVariables.kPrimaryColor)),
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'please fill all reqiured fields!')),
                                      );
                                    } else {
                                      setState(() {
                                        currentIndex++;
                                        if (currentIndex > 3) {
                                          debugPrint(
                                              'image1: ${image1?.path}, image2: ${image2?.path}, image3: ${image3?.path}, image4: ${image4?.path}, image5: ${image5?.path}');
                                        }
                                      });
                                    }
                                  },
                                  child: const Text(
                                    'next',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : Container(),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // * Event Specification part 2
  Column eventSpecification(Size size, BuildContext context) {
    return Column(
      children: [
        CustomFields().customLabel(
            size, context, 'assets/icons/pajamas_title.png', 'Event Kind'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: Row(
            children: [
              const Text(
                'Category : ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(widget.category.toUpperCase())
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: Row(
            children: [
              const Text(
                'Sub Category : ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(widget.subCategory.toUpperCase())
            ],
          ),
        ),
        widget.subSubCategory != ''
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Row(
                  children: [
                    const Text(
                      'Sub-Sub Category : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.subSubCategory?.toUpperCase() ?? '')
                  ],
                ),
              )
            : const SizedBox(),
        CustomFields().customLabel(
            size, context, 'assets/icons/Vector-2.png', 'Event Mode'),
        Row(
          children: <Widget>[
            Row(
              children: [
                Radio<EventType>(
                  value: EventType.PUBLIC,
                  groupValue: _type,
                  onChanged: (EventType? value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
                const Text('Public'),
              ],
            ),
            Row(
              children: [
                Radio<EventType>(
                  value: EventType.PRIVATE,
                  groupValue: _type,
                  onChanged: (EventType? value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
                const Text('Private'),
              ],
            ),
          ],
        ),
        CustomFields().customLabel(
            size, context, 'assets/icons/game-icons_ages.png', 'Age Group',
            optional: true),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: CustomDropdown(
                dropdownValue: ageGroupRange,
                size: size,
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(
                    () {
                      ageGroupRange = value!;
                    },
                  );
                },
                categories: GlobalVariables.kAgeGroups,
              ),
            ),
          ],
        ),
        CustomFields().customLabel(size, context,
            'assets/icons/mdi_human-male-female.png', 'Gender Choices',
            optional: true),
        Row(
          children: <Widget>[
            Row(
              children: [
                Radio<Gender>(
                  value: Gender.male,
                  groupValue: _gender,
                  onChanged: (Gender? value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                const Text('Male'),
              ],
            ),
            Row(
              children: [
                Radio<Gender>(
                  value: Gender.female,
                  groupValue: _gender,
                  onChanged: (Gender? value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                const Text('Female'),
              ],
            ),
            Row(
              children: [
                Radio<Gender>(
                  value: Gender.others,
                  groupValue: _gender,
                  onChanged: (Gender? value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                const Text('Others'),
              ],
            ),
          ],
        ),
        CustomFields().customLabel(size, context,
            'assets/icons/foundation_torsos-female-male.png', 'Gender Count',
            optional: true),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: femaleCntController,
                  decoration: const InputDecoration(
                    labelText: "Female",
                    hintText: "05",
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalVariables.kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(" : "),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: maleCntController,
                  decoration: const InputDecoration(
                    labelText: "Male",
                    hintText: "05",
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalVariables.kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        CustomFields().customLabel(
            size, context, 'assets/icons/ic_baseline-work.png', 'Occupation',
            optional: true),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: CustomDropdown(
                dropdownValue: occupationValue,
                size: size,
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(
                    () {
                      occupationValue = value!;
                    },
                  );
                },
                categories: GlobalVariables.kOccupations,
              ),
            ),
          ],
        )
      ],
    );
  }

  // * Upload Section part 3
  Column uploadData(Size size, BuildContext context, double height) {
    return Column(
      children: [
        CustomFields().customLabel(
            size, context, 'assets/icons/pajamas_title.png', 'Event Title'),
        CustomFields().customTextFormField(size, context, eventTitleController,
            'Event Title', TextInputType.name),
        CustomFields().customLabel(
            size,
            context,
            'assets/icons/material-symbols_description.png',
            'Event Description'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: SizedBox(
            // <--- SizedBox
            height: height,
            child: TextFormField(
              controller: eventDescriptionController,
              cursorColor: Colors.red,
              maxLines: height ~/ 20, // <--- maxLines
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                hintText: 'Add description',
                hintStyle: TextStyle(fontWeight: FontWeight.normal),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalVariables.kPrimaryColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalVariables.kPrimaryColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a small description here!';
                }
                return null;
              },
            ),
          ),
        ),
        CustomFields().customLabel(
            size, context, 'assets/icons/uim_image-v.png', 'Cover Image'),
        // Cover Image 1
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: image1 != null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.file(
                      image1!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () => selectImage(1),
                  child: DottedBorder(
                    color: borderColor,
                    strokeWidth: stroke,
                    borderType: BorderType.RRect,
                    strokeCap: StrokeCap.round,
                    dashPattern: const [10, 4],
                    radius: const Radius.circular(30),
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage(
                              'assets/icons/solar_upload-broken.png',
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Upload the cover image for the event',
                            style: TextStyle(
                              fontSize: 15,
                              color: stroke == 1
                                  ? Colors.grey.shade400
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
        SizedBox(height: size.height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Cover Image 2
            image2 != null
                ? Container(
                    width: size.width * 0.2,
                    height: 85,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        image2!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () => selectImage(2),
                    child: DottedBorder(
                      color: GlobalVariables.kPrimaryColor,
                      borderType: BorderType.RRect,
                      // strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                      dashPattern: const [10, 4],
                      radius: const Radius.circular(20),
                      child: Container(
                        width: size.width * 0.2,
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: const AssetImage(
                                'assets/icons/solar_upload-broken.png',
                              ),
                              height: size.height * 0.03,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Image 1',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            // Cover Image 3
            image3 != null
                ? Container(
                    width: size.width * 0.2,
                    height: 85,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        image3!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () => selectImage(3),
                    child: DottedBorder(
                      color: GlobalVariables.kPrimaryColor,
                      borderType: BorderType.RRect,
                      // strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                      dashPattern: const [10, 4],
                      radius: const Radius.circular(20),
                      child: Container(
                        width: size.width * 0.2,
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: const AssetImage(
                                'assets/icons/solar_upload-broken.png',
                              ),
                              height: size.height * 0.03,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Image 2',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            // Cover Image 4
            image4 != null
                ? Container(
                    width: size.width * 0.2,
                    height: 85,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        image4!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () => selectImage(4),
                    child: DottedBorder(
                      color: GlobalVariables.kPrimaryColor,
                      borderType: BorderType.RRect,
                      // strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                      dashPattern: const [10, 4],
                      radius: const Radius.circular(20),
                      child: Container(
                        width: size.width * 0.2,
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: const AssetImage(
                                'assets/icons/solar_upload-broken.png',
                              ),
                              height: size.height * 0.03,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Image 3',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            // Cover Image 5
            image5 != null
                ? Container(
                    width: size.width * 0.2,
                    height: 85,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        image5!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () => selectImage(5),
                    child: DottedBorder(
                      color: GlobalVariables.kPrimaryColor,
                      borderType: BorderType.RRect,
                      // strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                      dashPattern: const [10, 4],
                      radius: const Radius.circular(20),
                      child: Container(
                        width: size.width * 0.2,
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: const AssetImage(
                                'assets/icons/solar_upload-broken.png',
                              ),
                              height: size.height * 0.03,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Image 4',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        SizedBox(height: size.height * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            currentIndex > 1
                ? TextButton(
                    onPressed: () {
                      setState(() {
                        currentIndex--;
                      });
                    },
                    child: const Text('back'),
                  )
                : SizedBox(width: size.width * 0.05),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(GlobalVariables.kPrimaryColor)),
              onPressed: _handleSubmitButton,
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
