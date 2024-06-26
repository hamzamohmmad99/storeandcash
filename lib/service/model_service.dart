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

 class ServiceCatHive {
   

Future<List<CatModelHive>> fetchCats() async {
  Dio dio=Dio();
  try {
    Response response = await dio.get("https://freetestapi.com/api/v1/cats");

    if (response.statusCode == 200) {
      List jsonResponse = response.data;
      List<CatModelHive> birds = [];

      for (var catsData in jsonResponse) {
        // Check if all required fields are not null
        if (catsData['name'] != null && catsData['origin'] != null && catsData['image'] != null) {
          birds.add(CatModelHive(
            name: catsData['name'],
            origin: catsData['origin'],
            image: catsData['image'],
          ));
        }
      }

      return birds;
    } else {
      throw Exception('Failed to load ctas');
    }
  } catch (e) {
    throw Exception('Failed to load cats: $e');
  }
}

 }