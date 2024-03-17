import 'package:flutter/material.dart';

class ColorSchema {
  static const Color _primary = Color.fromARGB(255, 236, 135, 53);
  static const Color _secondary = Colors.white;
  static const LinearGradient _primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(255, 169, 99, 1),
      Color.fromRGBO(238, 143, 143, 1),
    ],
  );
  static const LinearGradient _unselectedCardGradient =
      LinearGradient(colors: [Colors.white, Colors.white]);
}

enum EventType { private, public }

enum Gender { male, female, others }

class GlobalVariables {
  static const Color kPrimaryColor = ColorSchema._primary;
  static const Color kSecondaryColor = ColorSchema._secondary;
  static const backgroundColor = Colors.white;
  static var selectedNavBarColor = Colors.orange[800]!;
  static const unselectedNavBarColor = Colors.black87;
  static const chatBubbleColor =  Color(0xffFBE6BD);
  static const LinearGradient kPrimaryGradientColor =
      ColorSchema._primaryGradient;
  static const LinearGradient kUnselectedCardGradientColor =
      ColorSchema._unselectedCardGradient;

  static const List<String> kEventCategory = <String>[
    'Music and Dance',
    'Social Food & Drink',
    'Social Pickup Sports',
    'Social Activities'
  ];

  static const Map<String, List<String>> kEventSubCategory = {
    'Music and Dance' : <String>['Classical', 'Western', 'others'],
    'Social Food & Drink': <String>['Drinks/Cocktails', 'Mocktails', 'Brunch Gathering', 'Dinner Party'],
    'Social Pickup Sports': <String>['Soccer', 'Basketball', 'Pickleball', 'Tennis'],
    'Social Activities': <String>['Reading party', 'Card games', 'Crafts', 'Dog social'],
  };

  static const Map<String, List<String>> kEventSubSubCategory = {
    'Card games': ["Poker", "Bridge", "Cribbage", "Mahjong"],
    'Crafts': ["Knitting", "Crocheting", "Needlepoint", "Sewing", "Sketching"],
    'Dog social': [],
    'Reading party': [],
    'Drinks/Cocktails': [],
    'Mocktails': [],
    'Brunch Gathering': [],
    'Dinner Party': [],
    'Soccer': [],
    'Basketball': [],
    'Pickleball': [],
    'Tennis': [],
    'Classical': [],
    'Western': [],
    'others': [],
  };

  // static const Map<String, Map<String, List<String>>> kEventSubCategory = {
  //   'check': {},
  //   'Music and Dance': {'Classical': [], 'Western': [], 'others': []},
  //   'Social Food & Drink': {
  //     'Drinks/Cocktails': [],
  //     'Mocktails': [],
  //     'Brunch Gathering': [],
  //     'Dinner Party': []
  //   },
  //   'Social Pickup Sports': {
  //     'Soccer': [],
  //     'Basketball': [],
  //     'Pickleball': [],
  //     'Tennis': []
  //   },
  //   'Social Activities': {
  //     'Reading party': [],
  //     'Card games': ["Poker", "Bridge", "Cribbage", "Mahjong"],
  //     'Dog social': [],
  //     'Crafts': ["Knitting", "Crocheting", "Needlepoint", "Sewing", "Sketching"]
  //   }
  // };


  static const List<String> kAgeGroups = <String>[
    'Anyone',
    '10-15',
    '15-25',
    '25-35',
    '35-45',
    '45-60',
    'greater than 60'
  ];
  static const List<String> kOccupations = [
    'Any',
    'Accountant',
    'Actor',
    'Architect',
    'Artist',
    'Astronaut',
    'Athlete',
    'Author',
    'Baker',
    'Banker',
    'Barista',
    'Biologist',
    'Botanist',
    'Carpenter',
    'Chef',
    'Chemist',
    'Coach',
    'Dentist',
    'Designer',
    'Doctor',
    'Electrician',
    'Engineer',
    'Farmer',
    'Firefighter',
    'Flight Attendant',
    'Graphic Designer',
    'Hair Stylist',
    'Historian',
    'Journalist',
    'Judge',
    'Lawyer',
    'Librarian',
    'Mechanic',
    'Meteorologist',
    'Musician',
    'Nurse',
    'Painter',
    'Pharmacist',
    'Photographer',
    'Physician',
    'Pilot',
    'Plumber',
    'Police Officer',
    'Professor',
    'Programmer',
    'Psychologist',
    'Real Estate Agent',
    'Scientist',
    'Singer',
    'Social Worker',
    'Software Engineer',
    'Teacher',
    'Translator',
    'Veterinarian',
    'Waiter/Waitress',
    'Web Developer',
    'Writer',
  ];
}
