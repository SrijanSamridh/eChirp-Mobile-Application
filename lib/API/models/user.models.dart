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
    int? numberOfEventsAttended;
    String? id;
    String? username;
    String? email;
    String? password;
    List<String>? friends;
    List<dynamic>? friendRequests;
    int? numberOfFriends;
    List<String>? myCreatedEvents;
    List<String>? eventsAttended;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? bio;
    String? firstName;
    String? lastName;
    int? numberOfEventsCreated;
    String? token;

    UserClass({
        this.numberOfEventsAttended,
        this.id,
        this.username,
        this.email,
        this.password,
        this.friends,
        this.friendRequests,
        this.numberOfFriends,
        this.myCreatedEvents,
        this.eventsAttended,
        this.createdAt,
        this.updatedAt,
        this.bio,
        this.firstName,
        this.lastName,
        this.numberOfEventsCreated,
        this.token,
    });

    factory UserClass.fromRawJson(String str) => UserClass.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        numberOfEventsAttended: json["numberOfEventsAttended"],
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        friends: json["friends"] == null ? [] : List<String>.from(json["friends"]!.map((x) => x)),
        friendRequests: json["friendRequests"] == null ? [] : List<dynamic>.from(json["friendRequests"]!.map((x) => x)),
        numberOfFriends: json["numberOfFriends"],
        myCreatedEvents: json["myCreatedEvents"] == null ? [] : List<String>.from(json["myCreatedEvents"]!.map((x) => x)),
        eventsAttended: json["eventsAttended"] == null ? [] : List<String>.from(json["eventsAttended"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        bio: json["bio"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        numberOfEventsCreated: json["numberOfEventsCreated"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "numberOfEventsAttended": numberOfEventsAttended,
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "friends": friends == null ? [] : List<dynamic>.from(friends!.map((x) => x)),
        "friendRequests": friendRequests == null ? [] : List<dynamic>.from(friendRequests!.map((x) => x)),
        "numberOfFriends": numberOfFriends,
        "myCreatedEvents": myCreatedEvents == null ? [] : List<dynamic>.from(myCreatedEvents!.map((x) => x)),
        "eventsAttended": eventsAttended == null ? [] : List<dynamic>.from(eventsAttended!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "bio": bio,
        "firstName": firstName,
        "lastName": lastName,
        "numberOfEventsCreated": numberOfEventsCreated,
        "token": token,
    };
}
