import 'dart:math';

import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ChessBoard();
        },
        itemCount: 10,
      ),
    );
  }
}

class ChessBoard extends StatelessWidget {
  static const size = 42.0;

  @override
  Widget build(BuildContext context) {
    var builder2 = Builder(
            builder: (context) {
              var random = Random();
              var nextInt = random.nextInt(12);
              if (nextInt == 0) {
                return WhitePawn(size: size);
              }
              if (nextInt == 1) {
                return WhiteRook(size: size);
              }
              if (nextInt == 2) {
                return WhiteKnight(size: size);
              }
              if (nextInt == 3) {
                return WhiteBishop(size: size);
              }
              if (nextInt == 4) {
                return WhiteQueen(size: size);
              }
              if (nextInt == 5) {
                return WhiteKing(size: size);
              }
              if (nextInt == 6) {
                return BlackPawn(size: size);
              }
              if (nextInt == 7) {
                return BlackRook(size: size);
              }
              if (nextInt == 8) {
                return BlackKnight(size: size);
              }
              if (nextInt == 9) {
                return BlackBishop(size: size);
              }
              if (nextInt == 10) {
                return BlackQueen(size: size);
              }
              return BlackKing(size: size);
            },
          );
    final sizedBox = SizedBox(
      height: size,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: InkWell(
          onLongPress: () {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("long press")));
          },
          child: builder2,
        ),
      ),
    );
    final sizedBox2 = SizedBox(
      height: size,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.black45),
        child: InkWell(
          onLongPress: () {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("long press")));
          },
          child: builder2,
        ),
      ),
    );
    final tableRow = TableRow(
      children: <Widget>[
        sizedBox,
        sizedBox2,
        sizedBox,
        sizedBox2,
        sizedBox,
        sizedBox2,
        sizedBox,
        sizedBox2,
      ],
    );
    final tableRow2 = TableRow(
      children: <Widget>[
        sizedBox2,
        sizedBox,
        sizedBox2,
        sizedBox,
        sizedBox2,
        sizedBox,
        sizedBox2,
        sizedBox,
      ],
    );

    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.lightBlue, width: 15)),
        margin: EdgeInsets.all(20),
        child: SizedBox(
          width: size * 8,
          child: Table(
            children: <TableRow>[
              tableRow,
              tableRow2,
              tableRow,
              tableRow2,
              tableRow,
              tableRow2,
              tableRow,
              tableRow2,
            ],
          ),
        ),
      ),
    );
  }
}
