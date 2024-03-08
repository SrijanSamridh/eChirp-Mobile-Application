// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    int numberOfEventsAttended;
    String id;
    String username;
    String email;
    String password;
    List<String> friends;
    List<dynamic> friendRequests;
    int numberOfFriends;
    List<String> myCreatedEvents;
    List<String> eventsAttended;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String bio;
    String firstName;
    String lastName;
    int numberOfEventsCreated;

    UserData({
        required this.numberOfEventsAttended,
        required this.id,
        required this.username,
        required this.email,
        required this.password,
        required this.friends,
        required this.friendRequests,
        required this.numberOfFriends,
        required this.myCreatedEvents,
        required this.eventsAttended,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.bio,
        required this.firstName,
        required this.lastName,
        required this.numberOfEventsCreated,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        numberOfEventsAttended: json["numberOfEventsAttended"] ?? '',
        id: json["_id"] ?? '',
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        friends: List<String>.from(json["friends"].map((x) => x)),
        friendRequests: List<dynamic>.from(json["friendRequests"].map((x) => x)),
        numberOfFriends: json["numberOfFriends"],
        myCreatedEvents: List<String>.from(json["myCreatedEvents"].map((x) => x)),
        eventsAttended: List<String>.from(json["eventsAttended"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"]?? '',
        bio: json["bio"]?? '',
        firstName: json["firstName"]?? '',
        lastName: json["lastName"]?? '',
        numberOfEventsCreated: json["numberOfEventsCreated"]?? '',
    );

    Map<String, dynamic> toJson() => {
        "numberOfEventsAttended": numberOfEventsAttended,
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "friends": List<dynamic>.from(friends.map((x) => x)),
        "friendRequests": List<dynamic>.from(friendRequests.map((x) => x)),
        "numberOfFriends": numberOfFriends,
        "myCreatedEvents": List<dynamic>.from(myCreatedEvents.map((x) => x)),
        "eventsAttended": List<dynamic>.from(eventsAttended.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "bio": bio,
        "firstName": firstName,
        "lastName": lastName,
        "numberOfEventsCreated": numberOfEventsCreated,
    };
}
