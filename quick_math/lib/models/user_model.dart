import 'package:quick_math/models/level_model.dart';

class UserModel {
  String? name;
  String?id;
  List<LevelModel> levels;

  UserModel({this.levels = const <LevelModel>[], this.name,this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:json['id'],
      levels: json['levels'] == null
          ? []
          : List<LevelModel>.from(
              json['levels'].map((model) => LevelModel.fromJsom(model))),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
    };
  }

  @override
  String toString() {
    return 'UserModel{level: $levels, name: $name}';
  }
}
