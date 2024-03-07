// To parse this JSON data, do
//
//     final potentialFriends = potentialFriendsFromJson(jsonString);

import 'dart:convert';

PotentialFriends potentialFriendsFromJson(String str) => PotentialFriends.fromJson(json.decode(str));

String potentialFriendsToJson(PotentialFriends data) => json.encode(data.toJson());

class PotentialFriends {
    List<PotentialFriend> potentialFriends;

    PotentialFriends({
        required this.potentialFriends,
    });

    factory PotentialFriends.fromJson(Map<String, dynamic> json) => PotentialFriends(
        potentialFriends: List<PotentialFriend>.from(json["potentialFriends"].map((x) => PotentialFriend.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "potentialFriends": List<dynamic>.from(potentialFriends.map((x) => x.toJson())),
    };
}

class PotentialFriend {
    int count;
    Friend friend;

    PotentialFriend({
        required this.count,
        required this.friend,
    });

    factory PotentialFriend.fromJson(Map<String, dynamic> json) => PotentialFriend(
        count: json["count"],
        friend: Friend.fromJson(json["friend"]),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "friend": friend.toJson(),
    };
}

class Friend {
    String id;
    String username;
    String? bio;

    Friend({
        required this.id,
        required this.username,
        this.bio,
    });

    factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        id: json["_id"],
        username: json["username"],
        bio: json["bio"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "bio": bio,
    };
}
