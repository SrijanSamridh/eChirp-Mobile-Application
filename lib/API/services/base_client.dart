// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = 'https://e-chirp-server.vercel.app/api';
// const String baseUrl = 'https://api.eventchirp.com/api';

class BaseClient {
  var client = http.Client();

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('x-auth-token')!;
    var data = token;
    return data;
  }

  // Get request
  Future<dynamic> get(String route) async {
    try {
      var url = Uri.parse(baseUrl + route);
      var token = await getToken();
      var _headers = {
        'Content-Type': 'application/json',
        'x-auth-token': token,
      };
      var response = await client.get(url, headers: _headers);
      // print('Response of BaseClient for $route: ${response.body}');
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      print('Error in get request: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> post(String route, dynamic object) async {
    print("Procssing BaseClient with:\n $object");

    // Get Token
    var token = await getToken();
    // Parsing URL
    var url = Uri.parse(baseUrl + route);
    // Header Config
    var _headers = <String, String>{
      'Content-Type': 'application/json',
      'x-auth-token': token,
    };
    var _payload = jsonEncode(object);

    print("$_payload, Url : $url, \nToken : $token");

    // Make the POST Request
    try {
      final http.Response response = await http.post(
        url,
        body: _payload,
        headers: _headers,
      );

      print("Response from BaseClient : ${response.body}");

      // Check if the request was successful (status code 2xx)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Parse the response body
        return jsonDecode(response.body);
      } else {
        var errorJson = jsonDecode(response.body);
        var errorMessage = errorJson["message"] ?? "Error";
        print('Error: ${response.statusCode}, $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Internal server error');
    }
  }

  Future<dynamic> postJoinEvent(String eventID) async {
    var response = await post('/events/join', {"eventID": eventID});
    return response;
  }

  // Put request code snippet
  Future<dynamic> put(String route, dynamic object) async {
    var url = Uri.parse(baseUrl + route);
    var _payload = json.encode(object);
    // ignore: unused_local_variable,
    var _headers = {
      'Authorization': 'Bearer',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await client.put(url, body: _payload);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<dynamic> delete(String route) async {
    var url = Uri.parse(baseUrl + route);
    var token = await getToken();
    var _headers = {
      'Content-Type': 'application/json',
      'x-auth-token': token,
    };
    try {
      var response = await client.delete(url, headers: _headers);
      print("Response from BaseClient : ${response.body}");

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        var errorJson = json.decode(response.body);
        var errorMessage = errorJson["message"] ?? "Error";
        print('Error: ${response.statusCode}, $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Internal server error');
    }
  }
}
