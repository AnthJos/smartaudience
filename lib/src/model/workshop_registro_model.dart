// To parse this JSON data, do
//
//     final BeaconModel = BeaconModelFromJson(jsonString);

import 'dart:convert';

WorkshopRegisterModel workshopRegisterModelFromJson(String str) => WorkshopRegisterModel.fromJson(json.decode(str));

String workshopRegisterModelToJson(WorkshopRegisterModel data) => json.encode(data.toJson());

class WorkshopRegisterModel {

    String tok;
    String iduser;
    String fechaini;
    String fechafin;

    WorkshopRegisterModel({
      
        this.tok,
        this.iduser,
        this.fechaini = '',
        this.fechafin = '',
    });

    factory WorkshopRegisterModel.fromJson(Map<String, dynamic> json) => new WorkshopRegisterModel(
      
        tok        : json["tok"],
        iduser         : json["iduser"],
        fechaini     : json["fechaini"],
        fechafin      : json["fechafin"],
    );

    Map<String, dynamic> toJson() => {
        "iduser"         : iduser,
        "fechaini"     : fechaini,
        "fechafin"     : fechafin
    };
}
