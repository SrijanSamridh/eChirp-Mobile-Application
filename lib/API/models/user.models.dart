import 'dart:convert';

class User {
    String? message;
    UserClass? user;

    User({
        this.message,
        this.user,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        message: json["message"],
        user: json["user"] == null ? null : UserClass.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user": user?.toJson(),
    };
}

class UserClass {
    String? id;
    String? username;
    String? email;
    String? password;
    List<String>? friends;
    List<dynamic>? friendRequests;
    int? numberOfFriends;
    List<dynamic>? myCreatedEvents;
    List<dynamic>? eventsAttended;
    int? numberOfEventsCreated;
    int? numberOfEventsAttended;
    String? token;

    UserClass({
        this.id,
        this.username,
        this.email,
        this.password,
        this.friends,
        this.friendRequests,
        this.numberOfFriends,
        this.myCreatedEvents,
        this.eventsAttended,
        this.numberOfEventsCreated,
        this.numberOfEventsAttended,
        this.token,
    });

    factory UserClass.fromRawJson(String str) => UserClass.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        friends: json["friends"] == null ? [] : List<String>.from(json["friends"]!.map((x) => x)),
        friendRequests: json["friendRequests"] == null ? [] : List<dynamic>.from(json["friendRequests"]!.map((x) => x)),
        numberOfFriends: json["numberOfFriends"],
        myCreatedEvents: json["myCreatedEvents"] == null ? [] : List<dynamic>.from(json["myCreatedEvents"]!.map((x) => x)),
        eventsAttended: json["eventsAttended"] == null ? [] : List<dynamic>.from(json["eventsAttended"]!.map((x) => x)),
        numberOfEventsCreated: json["numberOfEventsCreated"],
        numberOfEventsAttended: json["numberOfEventsAttended"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "friends": friends == null ? [] : List<String>.from(friends!.map((x) => x)),
        "friendRequests": friendRequests == null ? [] : List<dynamic>.from(friendRequests!.map((x) => x)),
        "numberOfFriends": numberOfFriends,
        "myCreatedEvents": myCreatedEvents == null ? [] : List<dynamic>.from(myCreatedEvents!.map((x) => x)),
        "eventsAttended": eventsAttended == null ? [] : List<dynamic>.from(eventsAttended!.map((x) => x)),
        "numberOfEventsCreated": numberOfEventsCreated,
        "numberOfEventsAttended": numberOfEventsAttended,
        "token": token,
    };
}
