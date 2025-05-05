import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_hike/Add_Hike.dart';
import 'package:m_hike/GlobalController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hiker app',
      theme: ThemeData(

        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'M-Hike'),
      onInit: () {
        Get.put(MainController());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  MainController mainController = Get.find();

  @override
  void initState() {
    super.initState();
    mainController.setDb();
    getDataFromDataBase();
  }
// Function to get data from database
  void getDataFromDataBase() async {
    local_Hike_Array = await mainController.dB.getAllHikesFromDB();
    setState(() {

    });
  }
// Function directing to Add hike screen
  void addNewHike() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Add_Hike())).then((value) {
          getDataFromDataBase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          OutlinedButton(onPressed: addNewHike, child: Text("Add New Hike")),
          Expanded(

            child: Padding(
              padding: const EdgeInsets.all(10.0),
              // List View in the main page where it shows list of hikes
              child: ListView.builder(
                itemCount: local_Hike_Array.length,
                itemBuilder: (BuildContext ctxt, int i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${local_Hike_Array[i].name}"),
                          Text("Location: ${local_Hike_Array[i].location}"),
                          Text("Date: ${local_Hike_Array[i].date}"),
                          Text("Length: ${local_Hike_Array[i].length}"),
                          Text("Difficulty: ${local_Hike_Array[i].difficulty}"),
                          Text("Description: ${local_Hike_Array[i].description}")
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
