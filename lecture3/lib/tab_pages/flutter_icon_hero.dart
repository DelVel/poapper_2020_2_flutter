import 'package:flutter/material.dart';

class FlutterIconHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Hero(
          child: FlutterLogo(size: 100),
          tag: 'logoHero',
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LogoHero();
          }));
        },
      ),
    );
  }
}

class LogoHero extends StatefulWidget {
  @override
  _LogoHeroState createState() => _LogoHeroState();
}

class _LogoHeroState extends State<LogoHero> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          flexibleSpace: Hero(
            child: RotationTransition(
              child: FlutterLogo(size: 100),
              turns: CurvedAnimation(curve: Curves.easeOutCubic, parent: _animationController),
            ),
            tag: 'logoHero',
          ),
        ),
      ),
      body: Center(child: Text('All hail flutter!', style: Theme.of(context).textTheme.headline2)),
    );
  }
}
