import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CustomStaggeredGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(

      itemBuilder: (BuildContext context, int index) {
        return Container(color: Colors.blue,child: Center(child: Text(index.toString())));
      },

      staggeredTileBuilder: (int index) {
        return StaggeredTile.count((index % 2) + 1, (index % 3) + 1);
      },

      itemCount: 100,
      crossAxisCount: 6,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
    );
  }
}
