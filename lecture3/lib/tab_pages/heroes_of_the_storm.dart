import 'package:flutter/material.dart';

class HIOS extends StatefulWidget {
  @override
  _HIOSState createState() => _HIOSState();
}

class _HIOSState extends State<HIOS> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      child: Image.network('https://t1.daumcdn.net/cfile/tistory/9937AC3C5C2757FE22'),
      turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
    );
  }
}
