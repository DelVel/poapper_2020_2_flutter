import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
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
      home: MyHomePage(title: 'Flutter Asynchronous'),
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
        var response = await client.get('https://cors-anywhere.herokuapp.com/https://www.coindesk.com/price/bitcoin');
        print('Got a future');
        yield response;
      } catch (XMLHttpRequest) {
        print('error!');
      }
      await Future.delayed(Duration(seconds: 10));
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
                  var htmlBody = response.data.body;
                  var parse2 = parse(htmlBody);
                  var querySelector = parse2.querySelector('.price-large');
                  return Text(querySelector.outerHtml);
                } else if (response.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return Text('error!');
                }
              },
            ),
            FutureBuilder<Response>(
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
