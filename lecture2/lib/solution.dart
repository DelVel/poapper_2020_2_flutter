import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      child: Image.network(
                        "https://avatars1.githubusercontent.com/u/19258681?s=200&v=4",
                        height: 100,
                        width: 100,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    Container(
                      width: 400,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: idController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "ID",
                                filled: true,
                                fillColor: Colors.white24,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: pwController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "PW",
                                filled: true,
                                fillColor: Colors.white24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Card(
                  color: Colors.lightBlue,
                  child: Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        onTap: () {
                          var data = "Try again.";
                          if(idController.text == "Poapper" && pwController.text == "flutter")
                            data = "Hi!";
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(data),
                          ));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                          child: Text("Log in"),
                        ),
                      );
                    },
                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
          margin: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Useless Button',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "bottom",
              style: Theme.of(context).textTheme.button,
            ),
          ),
          height: 50,
          color: Colors.black45,
        ),
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}
