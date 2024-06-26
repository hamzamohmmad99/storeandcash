import 'package:get_it/get_it.dart';
import 'package:into_statemangment/service/model_service.dart';

GetIt core =GetIt.instance;
init(){
  core.registerSingleton(CatModelImp());
}