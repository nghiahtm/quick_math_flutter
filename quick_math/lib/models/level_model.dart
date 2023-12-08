class LevelModel {
  String? level;
  int highScore;
  String? idLevel;
  LevelModel({this.level, this.highScore = 0,this.idLevel});

  factory LevelModel.fromJsom(Map<String,dynamic> json) {
    return LevelModel(
      level: json['level'],
      highScore: json['highScore']??0,
        idLevel: json['idLevels']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'level': level,
      'highScore': highScore,
    };
  }

  @override
  String toString() {
    return 'LevelModel{level: $level, highScore: $highScore,id: $idLevel}';
  }
}