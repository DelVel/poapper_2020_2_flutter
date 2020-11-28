import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

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
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final Stream<Response> _btcStream = (() async* {
    var client = Client();
    while (true) {
      try {
        var response = await client.get('https://www.coindesk.com/price/bitcoin', headers: {'accept': '/*'});
        print(response);
        yield response;
      } catch (XMLHttpRequest) {
        print('error!');
      }
      await Future.delayed(Duration(seconds: 1));
    }
  })();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<Response>(
              stream: _btcStream,
              builder: (context, response) {
                if (response.hasData) {
                  return Text(response.data.body);
                } else if (response.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return Text('error!');
                }
              },
            ),
            FutureBuilder(
              future: http.get('https://jsonplaceholder.typicode.com/posts'),
              builder: (context, response) {
                if (response.hasData) {
                  return Text(response.data.body);
                } else if (response.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return Text('error!');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
