// To parse this JSON data, do
//
//     final QuestModel = QuestModelFromJson(jsonString);

import 'dart:convert';

QuestModel questModelFromJson(String str) => QuestModel.fromJson(json.decode(str));

String questModelToJson(QuestModel data) => json.encode(data.toJson());

class QuestModel {

    String id;
    String iduser;
    String question;

    QuestModel({
        this.id,
        this.iduser = '',
        this.question = '',
    });

    factory QuestModel.fromJson(Map<String, dynamic> json) => new QuestModel(
        id         : json["id"],
        iduser     : json["iduser"],
        question      : json["question"],
    );

    Map<String, dynamic> toJson() => {
        //"id"         : id,
        "iduser"     : iduser,
        "question"       : question
    };
}
