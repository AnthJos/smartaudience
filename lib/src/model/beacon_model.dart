// To parse this JSON data, do
//
//     final BeaconModel = BeaconModelFromJson(jsonString);

import 'dart:convert';

BeaconModel beaconModelFromJson(String str) => BeaconModel.fromJson(json.decode(str));

String beaconModelToJson(BeaconModel data) => json.encode(data.toJson());

class BeaconModel {

    String tok;
    String id;
    String fechaini;
    String fechafin;

    BeaconModel({
        this.tok,
        this.id,
        this.fechaini = '',
        this.fechafin = '',
    });

    factory BeaconModel.fromJson(Map<String, dynamic> json) => new BeaconModel(
        tok        : json["tok"],
        id         : json["id"],
        fechaini     : json["fechaini"],
        fechafin      : json["fechafin"],
    );

    Map<String, dynamic> toJson() => {
        
        "id"         : id,
        "fechaini"     : fechaini,
        "fechafin"     : fechafin
    };
}
