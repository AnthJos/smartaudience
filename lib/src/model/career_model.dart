// To parse this JSON data, do
//
//     final CareerModel = CareerModelFromJson(jsonString);

import 'dart:convert';

CareerModel careerModelFromJson(String str) => CareerModel.fromJson(json.decode(str));

String careerModelToJson(CareerModel data) => json.encode(data.toJson());

class CareerModel {

    String id;
    String imagen;
    String name;

    CareerModel({
        this.id,
        this.imagen = '',
        this.name = '',
    });

    factory CareerModel.fromJson(Map<String, dynamic> json) => new CareerModel(
        id         : json["id"],
        imagen     : json["imagen"],
        name      : json["name"],
    );

    Map<String, dynamic> toJson() => {
        //"id"         : id,
        "imagen"     : imagen,
        "name"       : name
    };
}
