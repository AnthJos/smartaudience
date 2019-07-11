// To parse this JSON data, do
//
//     final WorkshopModel = WorkshopModelFromJson(jsonString);

import 'dart:convert';

WorkshopModel workshopModelFromJson(String str) => WorkshopModel.fromJson(json.decode(str));

String workshopModelToJson(WorkshopModel data) => json.encode(data.toJson());

class WorkshopModel {

    String id;
    String description;
    String theme;
    String time;
    String timeFin;
    String title;
    String urlVideo;
    String urlImage;

    WorkshopModel({
        this.id,
        this.description = '',
        this.theme = '',
        this.time = '',
        this.timeFin = '',
        this.title = '',
        this.urlVideo = '',
        this.urlImage = '',
    });

    factory WorkshopModel.fromJson(Map<String, dynamic> json) => new WorkshopModel(
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
