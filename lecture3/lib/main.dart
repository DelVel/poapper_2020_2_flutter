import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'tab_pages/custom_staggered_grid.dart';
import 'tab_pages/drag_drop.dart';
import 'tab_pages/flutter_icon_hero.dart';
import 'tab_pages/heroes_of_the_storm.dart';

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
      home: MyHomePage(title: 'Flutter third lecture'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    var tabList = <Tuple2<Tab, Widget>>[];
    tabList.add(Tuple2(
      Tab(child: Text('drag & drop')),
      DragDrop(),
    ));
    tabList.add(Tuple2(
      Tab(child: Text('rotation')),
      HIOS(),
    ));
    tabList.add(Tuple2(
      Tab(child: Text('hero')),
      FlutterIconHero(),
    ));
    tabList.add(Tuple2(
      Tab(child: Text('grid')),
      CustomStaggeredGrid(),
    ));

    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(tabs: tabList.map((Tuple2<Tab, Widget> e) => e.item1).toList(growable: false)),
        ),
        body: TabBarView(children: tabList.map((Tuple2<Tab, Widget> e) => e.item2).toList(growable: false)),
      ),
    );
  }
}
