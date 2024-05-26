import 'dart:convert';

class Groups {
  String? message;
  Group? group;
  List<Group>? groups;

  Groups({
    this.message,
    this.group,
    this.groups,
  });

  factory Groups.fromRawJson(String str) => Groups.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Groups.fromJson(Map<String, dynamic> json) => Groups(
        message: json["message"],
        group: json["group"] == null ? null : Group.fromJson(json["group"]),
        groups: json["groups"] == null
            ? null
            : List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "group": group?.toJson(),
        "groups": groups == null
            ? null
            : List<dynamic>.from(groups!.map((x) => x.toJson())),
      };
}

class Group {
  String? groupId;
  String? name;
  String? description;
  String? category;
  String? subCategory;
  String? subSubCategory;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  Owner? owner;
  List<Participant>? participants;
  List<dynamic>? lastMessage;

  Group({
    this.groupId,
    this.name,
    this.description,
    this.category,
    this.subCategory,
    this.subSubCategory,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.owner,
    this.participants,
    this.lastMessage,
  });

  factory Group.fromRawJson(String str) => Group.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        groupId: json["groupId"],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        subCategory: json["subCategory"],
        subSubCategory: json["subSubCategory"],
        imageUrl: json["imageUrl"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        participants: json["participants"] == null
            ? null
            : List<Participant>.from(
                json["participants"].map((x) => Participant.fromJson(x))),
        lastMessage: json["lastMessage"] == null
            ? null
            : List<dynamic>.from(json["lastMessage"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "name": name,
        "description": description,
        "category": category,
        "subCategory": subCategory,
        "subSubCategory": subSubCategory,
        "imageUrl": imageUrl,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "owner": owner?.toJson(),
        "participants": participants == null
            ? null
            : List<dynamic>.from(participants!.map((x) => x.toJson())),
        "lastMessage": lastMessage,
      };
}

class Owner {
  String? id;
  String? username;
  String? providerId;
  bool? owned;

  Owner({
    this.id,
    this.username,
    this.providerId,
    this.owned,
  });

  factory Owner.fromRawJson(String str) => Owner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["_id"],
        username: json["username"],
        providerId: json["providerId"],
        owned: json["owned"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "providerId" : providerId,
        "owned": owned,
      };
}

class Participant {
  String? userId;

  Participant({
    this.userId,
  });

  factory Participant.fromRawJson(String str) =>
      Participant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
      };
}
