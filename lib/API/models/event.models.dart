import 'dart:convert';

class Events {
    List<Event>? events;

    Events({
        this.events,
    });

    factory Events.fromRawJson(String str) => Events.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Events.fromJson(Map<String, dynamic> json) => Events(
        events: json["events"] == null ? [] : List<Event>.from(json["events"]!.map((x) => Event.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "events": events == null ? [] : List<dynamic>.from(events!.map((x) => x.toJson())),
    };
}

class Event {
    String? id;
    String? createdBy;
    String? mainCategory;
    String? subCategory;
    String? subSubCategory;
    DateTime? dateOfEvent;
    String? startTime;
    String? endTime;
    String? location;
    String? nameOfPlace;
    String? address;
    int? maxParticipants;
    List<String>? participants;
    String? eventMode;
    int? femaleCount;
    int? maleCount;
    String? eventTitle;
    String? eventDescription;
    String? coverImgUrl;
    String? img1Url;
    String? img2Url;
    String? img3Url;
    String? img4Url;
    DateTime? createdAt;
    DateTime? updatedAt;

    Event({
        this.id,
        this.createdBy,
        this.mainCategory,
        this.subCategory,
        this.subSubCategory,
        this.dateOfEvent,
        this.startTime,
        this.endTime,
        this.location,
        this.nameOfPlace,
        this.address,
        this.maxParticipants,
        this.participants,
        this.eventMode,
        this.femaleCount,
        this.maleCount,
        this.eventTitle,
        this.eventDescription,
        this.coverImgUrl,
        this.img1Url,
        this.img2Url,
        this.img3Url,
        this.img4Url,
        this.createdAt,
        this.updatedAt,
    });

    factory Event.fromRawJson(String str) => Event.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["_id"],
        createdBy: json["createdBy"],
        mainCategory: json["mainCategory"],
        subCategory: json["subCategory"],
        subSubCategory: json["subSubCategory"],
        dateOfEvent: json["dateOfEvent"] == null ? null : DateTime.parse(json["dateOfEvent"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        location: json["location"],
        nameOfPlace: json["nameOfPlace"],
        address: json["address"],
        maxParticipants: json["maxParticipants"],
        participants: json["participants"] == null ? [] : List<String>.from(json["participants"]!.map((x) => x)),
        eventMode: json["eventMode"],
        femaleCount: json["femaleCount"],
        maleCount: json["maleCount"],
        eventTitle: json["eventTitle"],
        eventDescription: json["eventDescription"],
        coverImgUrl: json["coverImgUrl"],
        img1Url: json["Img1Url"],
        img2Url: json["Img2Url"],
        img3Url: json["Img3Url"],
        img4Url: json["Img4Url"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "createdBy": createdBy,
        "mainCategory": mainCategory,
        "subCategory": subCategory,
        "subSubCategory": subSubCategory,
        "dateOfEvent": dateOfEvent?.toIso8601String(),
        "startTime": startTime,
        "endTime": endTime,
        "location": location,
        "nameOfPlace": nameOfPlace,
        "address": address,
        "maxParticipants": maxParticipants,
        "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x)),
        "eventMode": eventMode,
        "femaleCount": femaleCount,
        "maleCount": maleCount,
        "eventTitle": eventTitle,
        "eventDescription": eventDescription,
        "coverImgUrl": coverImgUrl,
        "Img1Url": img1Url,
        "Img2Url": img2Url,
        "Img3Url": img3Url,
        "Img4Url": img4Url,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
