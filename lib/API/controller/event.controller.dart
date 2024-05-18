// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:echirp/API/models/event.models.dart';
import 'package:echirp/API/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EventController {
  final client = ApiClient();

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
        final events = eventsData
            .map<Event>((eventData) => Event.fromJson(eventData))
            .toList();
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

  Future<dynamic> postEvent(BuildContext context, String code) async {
    try {
      debugPrint("Posting event...");

      final response = await client.post('/events/join', {"eventID": code});

      if (response.isNotEmpty) {
        var message = response['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
        return response;
      } else {
        debugPrint('Empty or null response received');
        return http.Response(
            '', 204); // Return an empty response with status code 204
      }
    } catch (e) {
      debugPrint('Error posting event: $e');
      rethrow; // Rethrow the error for handling in the calling code
    }
  }

  Future<dynamic> createEvent(dynamic body) async {
    // Get Token
    String token = await ApiClient().getToken();

    // Header Config
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'x-auth-token': token,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse("$baseUrl/events"),
        headers: headers,
        body: jsonEncode(body),
      );

      return response;
    } catch (e) {
      debugPrint('Error creating event: $e');
      rethrow; // Rethrow the error for handling in the calling code
    }
  }
}
