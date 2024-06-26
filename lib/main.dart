import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:into_statemangment/home_page.dart';



import 'package:into_statemangment/model/haive_model.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CatModelAdapter());
  await Hive.openBox<CatModelHive>('catsBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:HomePage() ,
    );
  }
}




