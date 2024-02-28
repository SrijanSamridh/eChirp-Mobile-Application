import 'dart:convert';

import 'package:echirp/API/models/event.models.dart';
import 'package:echirp/API/services/base_client.dart';
import 'package:flutter/material.dart';

class EventController {
  final client = BaseClient();

  Future<Events?> fetchEvents(String route) async {
    try {
      final response = await client.get("/events$route");

      if (response == null || response.isEmpty) {
        debugPrint('Unexpected response format: $response');
        return null;
      }

      final decodedResponse = json.decode(response);

      if (decodedResponse is! Map<String, dynamic>) {
        debugPrint('Unexpected response format: $decodedResponse');
        return null;
      }

      final eventsData = decodedResponse['events'];

      if (eventsData != null && eventsData is List) {
        final events = eventsData.map<Event>((eventData) => Event.fromJson(eventData)).toList();
        return Events(events: events);
      } else {
        debugPrint('Events data not found in response');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching events: $e');
      return null;
    }
  }

  Future<dynamic> postEvent(String code) async {
    try {
      debugPrint("Posting event...");

      final response = await client.postJoinEvent(code);

      if (response != null && response.isNotEmpty) {
        final decodedResponse = json.decode(response as String);
        return decodedResponse;
      } else {
        debugPrint('Empty or null response received');
        return null;
      }
    } catch (e) {
      debugPrint('Error posting event: $e');
      return null;
    }
  }
}
