import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_hike/GlobalController.dart';

class Add_Hike extends StatefulWidget {

  const Add_Hike({Key? key}) : super(key: key);

  @override
  State<Add_Hike> createState() => _Add_HikeState();
}

class _Add_HikeState extends State<Add_Hike> {

  final TextEditingController _nController = TextEditingController();
  final TextEditingController _lController = TextEditingController();
  final TextEditingController _dController = TextEditingController();
  final TextEditingController _lenController = TextEditingController();
  final TextEditingController _diffController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  MainController globalController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Add New Hike"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(

          children:  <Widget>[
            OutlinedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Return to home")),
            TextField(
              controller: _nController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name:',
                hintText: 'Enter Name',
              ),
            ),
            TextField(
              controller: _lController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'LocatSion:',
                hintText: 'Enter Location',
              ),
            ),
            TextField(
              controller: _dController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Date:',
                hintText: 'Enter Date',
              ),
            ),
            TextField(
              controller: _lenController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Length of the hike (Miles):',
                hintText: 'Enter Length',
              ),
            ),
            TextField(
              controller: _diffController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Difficulty',
                hintText: 'Enter Difficulty',
              ),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
                hintText: 'Enter Description',
              ),
            ),
            ElevatedButton(onPressed: (){
              // Save data here
              var name = _nController.text;
              var location = _lController.text;
              var date = _dController.text;
              var length = _lenController.text;
              var difficulty = _diffController.text;
              var description = _descController.text;

              if (_nController.text.isNotEmpty &&
                  _lController.text.isNotEmpty &&
                  _dController.text.isNotEmpty &&
                  _lenController.text.isNotEmpty &&
                  _diffController.text.isNotEmpty &&
                  _descController.text.isNotEmpty){
                    var newHike = Hike(name, location, date, length, difficulty, description);
                    // hikeArray.add(newHike);
                    globalController.dB.insertHike(newHike.toMap(), false);

                    Navigator.pop(context);
                  }
                }, child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("ADD"),
                ))
          ],
        ),
      ),
    );
  }

}

var local_Hike_Array = <Hike>[];


class Hike {
  final String name;
  final String location;
  final String date;
  final String length;
  final String difficulty;
  final String description;

  const Hike(this.name, this.location, this.date, this.length, this.difficulty,
      this.description);

  Map<String, dynamic> toMap() => {
    "name": name,
    "location": location,
    "date": date,
    "length": length,
    "difficulty": difficulty,
    "description": description
  };


}