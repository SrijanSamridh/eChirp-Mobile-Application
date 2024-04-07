import 'package:flutter/material.dart';

import '../controller/event.controller.dart';
import '../controller/friend.controller.dart';
import '../controller/userData.controller.dart';
import '../models/event.models.dart';
import '../models/userData.model.dart';

class UserProvider extends ChangeNotifier {
  late Future<UserData?> _profileData;
  late Future<Events?> _eventsAttended;
  late Future<Events?> _eventsCreated;

  Future<UserData?> get profileData => _profileData;
  Future<Events?> get eventsAttended => _eventsAttended;
  Future<Events?> get eventsCreated => _eventsCreated;

  Future<void> fetchUserData(String id, bool loggedUser) async {
    try {
      _eventsAttended = EventController().fetchEvents('/attended');
      _eventsCreated = EventController().fetchEvents('/created');

      // Fetch profile data based on id and loggedUser status
      // Assigned the fetched data to _profileData
      _profileData = loggedUser
          ? UserDataController().fetchUserData()
          : FriendController().fetchFriendProfile('/$id');
      notifyListeners(); // Notify listeners after updating data
    } catch (e) {
      debugPrint('Error fetching profile data: $e');
    }
  }

  Future<UserData?> fetchUserId() {
    _profileData = UserDataController().fetchUserData();
    return _profileData;
  }
}
