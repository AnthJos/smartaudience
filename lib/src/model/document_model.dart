// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

DocumentModel documentModelFromJson(String str) => DocumentModel.fromJson(json.decode(str));

String documentModeltToJson(DocumentModel data) => json.encode(data.toJson());

class DocumentModel {
    String id;
    String tipo;
    String title;
    String urlfile;

    DocumentModel({
        this.id,
        this.tipo,
        this.title,
        this.urlfile,
    });

    factory DocumentModel.fromJson(Map<String, dynamic> json) => new DocumentModel(
        id: json["id"],
        tipo: json["tipo"],
        title: json["title"],
        urlfile: json["urlfile"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "title": title,
        "urlfile": urlfile,
    };
}
