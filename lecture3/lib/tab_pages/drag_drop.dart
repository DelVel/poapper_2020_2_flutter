import 'package:flutter/material.dart';

class DragDrop extends StatefulWidget {
  @override
  _DragDropState createState() => _DragDropState();
}

class _DragDropState extends State<DragDrop> {
  var isSuccessful = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Card(
            elevation: 15,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Draggable(
              data: 'Flutter',
              child: FlutterLogo(
                size: 100.0,
              ),
              feedback: Card(
                elevation: 15,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: FlutterLogo(
                  size: 100.0,
                ),
              ),
              childWhenDragging: SizedBox(height: 100),
            ),
          ),
          DragTarget(
            builder: (context, List<String> candidateData, rejectedData) {
              return Center(
                child: isSuccessful
                    ? Container(
                        color: Colors.yellow,
                        height: 200,
                        width: 200,
                        child: Center(child: FlutterLogo(size: 100.0)),
                      )
                    : Container(
                        color: Colors.yellow,
                        height: 200,
                        width: 200,
                        child: Center(child: CircularProgressIndicator()),
                      ),
              );
            },
            onWillAccept: (data) {
              return data == 'Flutter';
            },
            onAccept: (data) {
              setState(() {
                isSuccessful = !isSuccessful;
              });
            },
          ),
        ],
      ),
    );
  }
}
