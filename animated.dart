import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedFabu extends StatefulWidget {
  final VoidCallback onClick;
  final VoidCallback onClickOne;
  final VoidCallback onClickTwo;
  final VoidCallback onClickThree;
  final VoidCallback onClickFour;

  const AnimatedFabu(
      {Key key,
      this.onClick,
      this.onClickOne,
      this.onClickTwo,
      this.onClickThree,
      this.onClickFour})
      : super(key: key);

  @override
  _AnimatedFabState createState() => new _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFabu>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorAnimation;

  final double expandedSize = 180.0;
  final double hiddenSize = 20.0;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    _colorAnimation = new ColorTween(begin: Colors.black87, end: Colors.black54)
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: expandedSize,
      height: expandedSize,
      child: new AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return new Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildExpandedBackground(),
              _buildOptionOne(CupertinoIcons.create, 0.0),
              _buildOptionTwo(CupertinoIcons.photo_camera, -math.pi / 3),
              _buildOptionThree(CupertinoIcons.time, -2 * math.pi / 3),
              _buildOptionFour(CupertinoIcons.clear, math.pi),
              _buildFabCore(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOptionOne(IconData icon, double angle) {
    if (_animationController.isDismissed) {
      return Container();
    }
    double iconSize = 0.0;
    if (_animationController.value > 0.8) {
      iconSize = 26.0 * (_animationController.value - 0.8) * 5;
    }
    return new Transform.rotate(
      angle: angle,
      child: new Align(
        alignment: Alignment.topCenter,
        child: new Padding(
          padding: new EdgeInsets.only(top: 8.0),
          child: new IconButton(
            onPressed: widget.onClickOne,
            icon: new Transform.rotate(
              angle: -angle,
              child: Column(
                children: <Widget>[
                  new Icon(
                    icon,
                    color: Colors.white,
                    size: 22,
                  ),
                  Text("Texto")
                ],
              ),
            ),
            iconSize: iconSize,
            alignment: Alignment.center,
            padding: new EdgeInsets.all(0.0),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTwo(IconData icon, double angle) {
    if (_animationController.isDismissed) {
      return Container();
    }
    double iconSize = 0.0;
    if (_animationController.value > 0.8) {
      iconSize = 26.0 * (_animationController.value - 0.8) * 5;
    }
    return new Transform.rotate(
      angle: angle,
      child: new Align(
        alignment: Alignment.topCenter,
        child: new Padding(
          padding: new EdgeInsets.only(top: 8.0),
          child: new IconButton(
            onPressed: widget.onClickTwo,
            icon: new Transform.rotate(
              angle: -angle,
              child: Column(
                children: <Widget>[
                  new Icon(
                    icon,
                    color: Colors.white,
                    size: 22,
                  ),
                  Text("Mídia")
                ],
              ),
            ),
            iconSize: iconSize,
            alignment: Alignment.center,
            padding: new EdgeInsets.all(0.0),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionThree(IconData icon, double angle) {
    if (_animationController.isDismissed) {
      return Container();
    }
    double iconSize = 0.0;
    if (_animationController.value > 0.8) {
      iconSize = 26.0 * (_animationController.value - 0.8) * 5;
    }
    return new Transform.rotate(
      angle: angle,
      child: new Align(
        alignment: Alignment.topCenter,
        child: new Padding(
          padding: new EdgeInsets.only(top: 8.0),
          child: new IconButton(
            onPressed: widget.onClickThree,
            icon: new Transform.rotate(
              angle: -angle,
              child: Column(
                children: <Widget>[
                  new Icon(
                    icon,
                    color: Colors.white,
                    size: 22,
                  ),
                  Text("Flash")
                ],
              ),
            ),
            iconSize: iconSize,
            alignment: Alignment.center,
            padding: new EdgeInsets.all(0.0),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionFour(IconData icon, double angle) {
    if (_animationController.isDismissed) {
      return Container();
    }
    double iconSize = 0.0;
    if (_animationController.value > 0.8) {
      iconSize = 26.0 * (_animationController.value - 0.8) * 5;
    }
    return new Transform.rotate(
      angle: angle,
      child: new Align(
        alignment: Alignment.topCenter,
        child: new Padding(
          padding: new EdgeInsets.only(bottom: 8.0),
          child: new IconButton(
            onPressed: widget.onClickFour,
            icon: new Transform.rotate(
              angle: -angle,
              child: Column(
                children: <Widget>[
                  new Icon(
                    icon,
                    color: Colors.white,
                    size: 22,
                  ),
                  Text("Secret")
                ],
              ),
            ),
            iconSize: iconSize,
            alignment: Alignment.center,
            padding: new EdgeInsets.all(0.0),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedBackground() {
    double size =
        hiddenSize + (expandedSize - hiddenSize) * _animationController.value;
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Container(
        height: size,
        width: size,
      ),
    );
  }

  Widget _buildFabCore() {
    double scaleFactor = 2 * (_animationController.value - 0.5).abs();
    return new FloatingActionButton(
      mini: true,
      onPressed: _onFabTap,
      child: new Transform(
        alignment: Alignment.center,
        transform: new Matrix4.identity()..scale(1.0, scaleFactor),
        child: new Icon(
          _animationController.value > 0.5 ? Icons.close : Icons.filter_list,
          color: Colors.white,
          // size: 26.0,
        ),
      ),
      backgroundColor: _colorAnimation.value,
    );
  }

  open() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    }
  }

  close() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  _onFabTap() {
    if (_animationController.isDismissed) {
      open();
    } else {
      close();
    }
  }
}
