import 'package:flutter/widgets.dart';
import 'package:quick_math/common/local_pref_config.dart';
import 'package:quick_math/models/user_model.dart';
import 'package:quick_math/repositories/user_repositories.dart';

class AppController extends ChangeNotifier {
  final UserRepository userRepository;
  String? id;
  UserModel? userModel;
  AppController({required this.userRepository});

  Future<void> initState() async{
    id =  await LocalPrefConfig.getString(LocalPrefConstant.idUser);
    //LocalPrefConfig.removeString(LocalPrefConstant.idUser);
    if(id != null && id!.isNotEmpty){
      userModel = await userRepository.getUser(id: id);
    }
    notifyListeners();
  }
}