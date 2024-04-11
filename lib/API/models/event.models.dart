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
    CreatedBy? createdBy;
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
    List<Participant>? participants;
    String? eventMode;
    String? ageRange;
    String? gender;
    int? femaleCount;
    int? maleCount;
    String? occupation;
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
        this.ageRange,
        this.gender,
        this.femaleCount,
        this.maleCount,
        this.occupation,
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
        createdBy: json["createdBy"] == null ? null : CreatedBy.fromJson(json["createdBy"]),
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
        participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => participantValues.map[x]!)),
        eventMode: json["eventMode"],
        ageRange: json["ageRange"],
        gender: json["gender"],
        femaleCount: json["femaleCount"],
        maleCount: json["maleCount"],
        occupation: json["occupation"],
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
        "createdBy": createdBy?.toJson(),
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
        "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => participantValues.reverse[x])),
        "eventMode": eventMode,
        "ageRange": ageRange,
        "gender": gender,
        "femaleCount": femaleCount,
        "maleCount": maleCount,
        "occupation": occupation,
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

class CreatedBy {
    String? id;
    String? username;
    String? email;

    CreatedBy({
        this.id,
        this.username,
        this.email,
    });

    factory CreatedBy.fromRawJson(String str) => CreatedBy.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
    };
}

enum Participant {
    THE_660_F8_FEDD1981_FF70_FF6_B920,
    THE_660_F908852_FAF823234_BAF1_B,
    THE_66110285_EB88_C7798_FE635_F5
}

final participantValues = EnumValues({
    "660f8fedd1981ff70ff6b920": Participant.THE_660_F8_FEDD1981_FF70_FF6_B920,
    "660f908852faf823234baf1b": Participant.THE_660_F908852_FAF823234_BAF1_B,
    "66110285eb88c7798fe635f5": Participant.THE_66110285_EB88_C7798_FE635_F5
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
