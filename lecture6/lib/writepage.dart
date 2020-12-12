import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WritePage extends StatelessWidget {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write your story'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _title,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                expands: true,
                minLines: null,
                maxLines: null,
                controller: _description,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              width: 70,
              height: 50,
              child: InkWell(
                onTap: () async {
                  var sharedPreferences = await SharedPreferences.getInstance();
                  List<String> tileList = sharedPreferences.getStringList('testFlutterList') ?? <String>[];
                  String newTile = _title.text + '\\' + _description.text;
                  tileList.add(newTile);
                  sharedPreferences.setStringList('testFlutterList', tileList);
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text('Confirm'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
