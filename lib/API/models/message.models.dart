import 'dart:convert';

class MessageModel {
    List<MessageElement>? messages;

    MessageModel({
        this.messages,
    });

    factory MessageModel.fromRawJson(String str) => MessageModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        messages: json["messages"] == null ? [] : List<MessageElement>.from(json["messages"]!.map((x) => MessageElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    };
}

class MessageElement {
    String? groupId;
    String? message;
    String? messageType;
    DateTime? createdAt;
    User? user;
    String? messageId;

    MessageElement({
        this.groupId,
        this.message,
        this.messageType,
        this.createdAt,
        this.user,
        this.messageId,
    });

    factory MessageElement.fromRawJson(String str) => MessageElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MessageElement.fromJson(Map<String, dynamic> json) => MessageElement(
        groupId: json["groupId"],
        message: json["message"],
        messageType: json["messageType"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        messageId: json["messageId"],
    );

    Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "message": message,
        "messageType": messageType,
        "createdAt": createdAt?.toIso8601String(),
        "user": user?.toJson(),
        "messageId": messageId,
    };
}

class User {
    String? username;
    String? email;
    String? userId;

    User({
        this.username,
        this.email,
        this.userId,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "userId": userId,
    };
}
