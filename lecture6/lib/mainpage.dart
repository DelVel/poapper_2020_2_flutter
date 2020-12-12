import 'package:flutter/material.dart';
import 'package:lecture6/writepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged in'),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: InkWell(
                child: Center(child: Text(index.toString())),
                onTap: () {
                  print('tapped');
                },
              ),
              elevation: 5,
            );
          },
          itemCount: 5,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WritePage();
          }));
          setState(() {});
        },
        tooltip: 'FAB',
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
          await Future.delayed(Duration(seconds: 1));
        },
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
            if (snapshot.hasData) {
              var sharedPreferences = snapshot.data;
              List<String> tileList = sharedPreferences.getStringList('testFlutterList') ?? <String>[];
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  String str = tileList[index];
                  var split = str.split('\\');
                  return ListTile(
                    leading: FlutterLogo(),
                    title: Text(split[0]),
                    subtitle: Text(split[1]),
                  );
                },
                itemCount: tileList.length,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),

      // ListView.builder(
      //   itemBuilder: (BuildContext context, int index) {
      //     return ListTile(
      //       leading: FlutterLogo(),
      //       title: Text('ListTile'),
      //       subtitle: Text(index.toString()),
      //     );
      //   },
      //   itemCount: _itemCount,
      // ),
    );
  }
}
