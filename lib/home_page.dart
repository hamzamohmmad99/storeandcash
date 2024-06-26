import 'package:flutter/material.dart';
//import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:into_statemangment/model/haive_model.dart';
import 'package:into_statemangment/service/model_service.dart';



class Hmoepage extends StatefulWidget {
  @override
  _HmoepageState createState() => _HmoepageState();
}

class _HmoepageState extends State<Hmoepage> {
  @override
  void initState() {
    super.initState();
    fetchAndStoreCats();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Cats')),
          body: ValueListenableBuilder(
            valueListenable: Hive.box<CatModelHive>('catsBox').listenable(),
            builder: (context, Box<CatModelHive> box, _) {
              if (box.values.isEmpty) {
                return const Center(child: Text('No cats available.'));
              } else {
                return ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    CatModelHive? cat = box.getAt(index);
                    return ListTile(
                      title: Text(cat?.name ?? 'Unknown'),
                    );
                  },
                );
              }
            },
          ),
        );
      }
    );
  }
}
