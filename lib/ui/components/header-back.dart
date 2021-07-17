import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:youth/ui/styles/_colors.dart';

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
          decoration: BoxDecoration(
            color: widget.reversed ? Colors.transparent : Color(0xff020D18),
          ),
          child: SafeArea(
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
                        Icons.arrow_back,
                        color: primaryColor,
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
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          widget.title.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.reversed
                                  ? primaryColor
                                  : Color(0xeefafbfc),
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
