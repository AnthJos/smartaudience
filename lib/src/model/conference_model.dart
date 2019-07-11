// To parse this JSON data, do
//
//     final ConferenceModel = ConferenceModelFromJson(jsonString);

import 'dart:convert';

ConferenceModel conferenceModelFromJson(String str) => ConferenceModel.fromJson(json.decode(str));

String conferenceModelToJson(ConferenceModel data) => json.encode(data.toJson());

class ConferenceModel {

    String id;
    String description;
    String theme;
    String time;
    String timeFin;
    String title;
    String urlVideo;
    String urlImage;

    ConferenceModel({
        this.id,
        this.description = '',
        this.theme = '',
        this.time = '',
        this.timeFin = '',
        this.title = '',
        this.urlVideo = '',
        this.urlImage = '',
    });

    factory ConferenceModel.fromJson(Map<String, dynamic> json) => new ConferenceModel(
        id         : json["id"],
        description     : json["description"],
        theme      : json["theme"],
        time     : json["time"],
        timeFin      : json["timeFin"],
        title     : json["title"],
        urlVideo      : json["urlVideo"],
        urlImage     : json["urlImage"],
    );

    Map<String, dynamic> toJson() => {
        //"id"         : id,
        "description"     : description,
        "theme"       : theme,
        "time"     : time,
        "timeFin"       : timeFin,
        "title"     : title,
        "urlVideo"       : urlVideo,
        "urlImage"       : urlImage
    };
}
