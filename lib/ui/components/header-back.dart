import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HeaderBack extends StatefulWidget {
  final String title;
  final bool reversed;

  HeaderBack({@required this.title, this.reversed});

  @override
  _HeaderBackState createState() => _HeaderBackState();
}

class _HeaderBackState extends State<HeaderBack> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 90,
          padding: EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            color: widget.reversed ? Colors.transparent : Color(0xff020D18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    width: 50.0,
                    child: Icon(
                      Feather.getIconData('arrow-left'),
                      color: Color(0xeefafbfc),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        widget.title.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: widget.reversed
                                ? Colors.white70
                                : Color(0xeefafbfc),
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
