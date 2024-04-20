import 'dart:convert';

class Notifications {
    List<NotificationElement>? notifications;

    Notifications({
        this.notifications,
    });

    factory Notifications.fromRawJson(String str) => Notifications.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        notifications: json["notifications"] == null ? [] : List<NotificationElement>.from(json["notifications"]!.map((x) => NotificationElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    };
}

class NotificationElement {
    String? userId;
    String? message;
    String? type;
    List<Link>? links;
    DateTime? createdAt;
    String? notificationId;

    NotificationElement({
        this.userId,
        this.message,
        this.type,
        this.links,
        this.createdAt,
        this.notificationId,
    });

    factory NotificationElement.fromRawJson(String str) => NotificationElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationElement.fromJson(Map<String, dynamic> json) => NotificationElement(
        userId: json["userId"],
        message: json["message"],
        type: json["type"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        notificationId: json["notificationId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "message": message,
        "type": type,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "notificationId": notificationId,
    };
}

class Link {
    int? start;
    int? end;
    String? link;
    String? type;
    String? typeId;
    String? id;

    Link({
        this.start,
        this.end,
        this.link,
        this.type,
        this.typeId,
        this.id,
    });

    factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        start: json["start"],
        end: json["end"],
        link: json["link"],
        type: json["type"],
        typeId: json["typeId"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
        "link": link,
        "type": type,
        "typeId": typeId,
        "_id": id,
    };
}
