import 'package:flutter/material.dart';
import 'package:echirp/API/controller/event.controller.dart';
import '../../API/models/event.models.dart';

class EventsProvider extends ChangeNotifier {
  final EventController _eventController = EventController();
  Events? _allEvents;
  Events? _myEvents;
  Events? _upcomingEvents;

  Events? get allEvents => _allEvents;
  Events? get myEvents => _myEvents;
  Events? get upcomingEvents => _upcomingEvents;

  Future<void> fetchEvents() async {
    try {
      _allEvents = await _eventController.fetchEvents('/');
      _myEvents = await _eventController.fetchEvents('/created');
      _upcomingEvents = await _eventController.fetchEvents('/upcoming');
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching events: $e');
    }
  }

  Future<void> joinEvent(BuildContext context, String id) async {
    try {
      var response = await _eventController.postEvent(context, id);
      if (response != null) {
        debugPrint('Response from server: $response');
        // Refresh events after joining
        await fetchEvents();
      }
    } catch (e) {
      debugPrint("Error joining event: $e");
    }
  }
}
