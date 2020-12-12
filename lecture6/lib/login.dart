import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mainpage.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController idController = TextEditingController();
    TextEditingController pwController = TextEditingController();

    return Align(
      alignment: Alignment.topCenter,
      child: Card(
        child: Container(
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    labelText: 'ID',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  controller: pwController,
                  decoration: InputDecoration(
                    labelText: 'PW',
                  ),
                ),
              ),
              InkWell(
                child: Text('button'),
                onTap: () async {
                  if (idController.text == 'flutter' && pwController.text == 'poapper') {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return MainPage();
                    }));
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Log in failed')));
                  }
                },
              ),
            ],
          ),
        ),
        elevation: 10,
        margin: EdgeInsets.all(10),
      ),
    );
  }
}
