import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poapper login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var idController = TextEditingController();
    var pwController = TextEditingController();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          flexibleSpace: Image.network("http://postech.ac.kr/wp-content/uploads/2020/08/header_logo_%EA%B5%AD%EB%AC%B8.png"),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.all(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        child: Image.network("https://avatars1.githubusercontent.com/u/19258681?s=200&v=4"),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      width: 30,
                    ),
                    Container(
                      width: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "ID",
                            ),
                            controller: idController,
                          ),
                          SizedBox(height: 5),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "PW",
                            ),
                            controller: pwController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Card(
                  elevation: 5,
                  child: Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        onTap: () {
                          var data = "not identified.";
                          if (idController.text == "Poapper" && pwController.text == "flutter") data = "welcome!";
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text(data)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                          child: Text("log me in!"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("FAB!");
        },
        child: Icon(Icons.add_ic_call),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Center(
            child: Text("bottom .."),
          ),
          height: 60,
        ),
      ),
    );
  }
}
