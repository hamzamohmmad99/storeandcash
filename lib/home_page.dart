import 'package:flutter/material.dart';
//import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:into_statemangment/model/haive_model.dart';
import 'package:into_statemangment/service/model_service.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Box<CatModelHive> catBox = Hive.box<CatModelHive>('catsBox');
  List<CatModelHive> catList = [];
  int displayCount = 5;
  final ServiceCatHive apiService = ServiceCatHive();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      List<CatModelHive> cats = await apiService.fetchCats();

      // Check if fetched cats list is empty
      if (cats.isEmpty) {
        throw Exception('Empty response from API');
      }

      print('Fetched cats: $cats');
      await catBox.clear();
      await catBox.addAll(cats);
      setState(() {
        catList = cats;
      });
    } catch (e) {
      print('Error fetching cats from API: $e');
      print('Fetching data from Hive');
      setState(() {
        catList = catBox.values.toList();
      });
    }
    print('Cat list after fetch: $catList');
  }

  void loadMore() {
    setState(() {
      displayCount += 5;
    });
    print('Display count after load more: $displayCount');
  }

  void clearData() {
    setState(() {
      catList = [];
      catBox.clear();
    });
    print('Cat list after clear: $catList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cats'),
      ),
      body: catList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: catList.length > displayCount ? displayCount : catList.length,
              itemBuilder: (context, index) {
                final cat = catList[index];
                return ListTile(
                  leading: Image.network(cat.image),
                  title: Text(cat.name),
                  subtitle: Text(cat.origin),
                );
              },
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: loadMore,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: clearData,
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}