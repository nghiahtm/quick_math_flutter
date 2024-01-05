import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quick_math/common/local_pref_config.dart';
import 'package:quick_math/common/music_constant.dart';

class HomeController with ChangeNotifier {
  bool isPlayMusic = true;
  final player = AudioPlayer();
  
  HomeController() {
    player.setAsset(MusicConstant.bg);
    player.play();
    player.setLoopMode(LoopMode.one);
    initState();
  }

  void initState() async {
    isPlayMusic =
        await LocalPrefConfig.readBool(LocalPrefConstant.isMusic) ?? true;
    _setMusicPlayer();
  }

  void setPlayMusic() {
    isPlayMusic = !isPlayMusic;
   _setMusicPlayer();
    LocalPrefConfig.setBool(LocalPrefConstant.isMusic, isPlayMusic);
    notifyListeners();
  }

  ///TODO: SET Volume PLAYER
  void _setMusicPlayer(){
    if (!isPlayMusic) {
      player.setVolume(0);
    } else {
      player.setVolume(1);
    }
  }
}
