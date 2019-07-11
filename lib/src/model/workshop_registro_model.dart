// To parse this JSON data, do
//
//     final BeaconModel = BeaconModelFromJson(jsonString);

import 'dart:convert';

WorkshopRegisterModel workshopRegisterModelFromJson(String str) => WorkshopRegisterModel.fromJson(json.decode(str));

String workshopRegisterModelToJson(WorkshopRegisterModel data) => json.encode(data.toJson());

class WorkshopRegisterModel {

    String id;
    String fechaini;
    String fechafin;

    WorkshopRegisterModel({
        this.id,
        this.fechaini = '',
        this.fechafin = '',
    });

    factory WorkshopRegisterModel.fromJson(Map<String, dynamic> json) => new WorkshopRegisterModel(
        id         : json["id"],
        fechaini     : json["fechaini"],
        fechafin      : json["fechafin"],
    );

    Map<String, dynamic> toJson() => {
        //"id"         : id,
        "fechaini"     : fechaini,
        "fechafin"     : fechafin
    };
}
