import 'package:flutter/material.dart';
import 'package:youth/ui/styles/_colors.dart';

class EmptyItems extends StatelessWidget {
  const EmptyItems({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [shadow],
      ),
      child: Text('Мэдээлэл оруулаагүй байна.'),
    );
  }
}
