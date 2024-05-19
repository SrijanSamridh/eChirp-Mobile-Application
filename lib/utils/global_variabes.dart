import 'theme/app_color_scheme.dart';
import 'theme/theme_manager.dart';

// ignore: constant_identifier_names
enum EventType { PRIVATE, PUBLIC }

enum Gender { male, female, undisclosed }

class GlobalVariables {
  static final AppColorScheme colors = ThemeManager().colorScheme;

  static const List<String> kEventCategory = <String>[
    'Music and Dance',
    'Social Food & Drink',
    'Social Pickup Sports',
    'Social Activities'
  ];

  static const Map<String, List<String>> kEventSubCategory = {
    'Music and Dance': <String>['Classical', 'Western', 'others'],
    'Social Food & Drink': <String>[
      'Drinks/Cocktails',
      'Mocktails',
      'Brunch Gathering',
      'Dinner Party'
    ],
    'Social Pickup Sports': <String>[
      'Soccer',
      'Basketball',
      'Pickleball',
      'Tennis'
    ],
    'Social Activities': <String>[
      'Reading party',
      'Card games',
      'Crafts',
      'Dog social'
    ],
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

  static const List<String> kMaxMemberCount = [
    "1",
    "2",
    "5",
    "10",
    "20",
    "30",
    "40",
    "50",
    "60",
    "70",
    "80",
    "100",
    "150",
    "200",
    "250"
  ];
}
