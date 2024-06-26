import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:into_statemangment/model/cat_model.dart';
import 'package:into_statemangment/model/haive_model.dart';
import 'package:into_statemangment/service/handle_model.dart';
import 'package:hive/hive.dart';

class Service {
  Dio dio = Dio();
  late Response response;
  String baesurl = 'https://freetestapi.com/api/v1/';
}

abstract class CatService extends Service {
  Future<ResulModel> getCat();
  Future<ResulModel> getAllCat();


  
}

class CatModelImp extends CatService {
  CatModel? cat;
  List<CatModel> cats = [];

  @override
  Future<ResulModel> getAllCat() async {
    try {
      if (cats.isNotEmpty) {
        return ListOf(modelList: cats);
      } else {
        response = await dio.get("${baesurl}cats");
        if (response.statusCode == 200) {
          return ListOf<CatModel>(
            modelList: List.generate(
              response.data.length,
              (index) => CatModel.fromMap(
                response.data[index],
              ),
            ),
          );
        }else{
          return ErrorModel(message: 'there is no internet');
        }
      }
    } catch (e) {
      return ExceptionModel(message: e.toString());
    }
  }

  @override
  Future<ResulModel> getCat() async {
    try {
      if (cat != null) {
        print("From cahe");
        return cat!;
      } else {
        print("From server");
        response = await dio.get('${baesurl}cats/1');
        if (response.statusCode == 200) {
          cat = CatModel.fromMap(response.data);
          return cat!;
        } else {
          return ErrorModel(message: "there is no internet");
        }
      }
    } catch (e) {
      return ExceptionModel(message: e.toString());
    }
  }
  
 
  
  
}
Future<void> fetchAndStoreCats() async {
  Dio dio=Dio();
   final response = await dio.get('https://freetestapi.com/api/v1/cats');
    if (response.statusCode == 200) {
    final List<CatModelHive> catsJson = List.generate(response.data.length, (index) => CatModelHive.fromMap(response.data[index]));
    var box = Hive.box<CatModelHive>('catsBox');

     for (var cat in catsJson) {
     
      box.add(cat);
    
      
    }
  } else {
    throw Exception('Failed to load cats');
  }
}