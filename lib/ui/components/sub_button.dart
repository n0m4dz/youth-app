import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth/core/contants/values.dart';

import '../../size_config.dart';

class SubButton extends StatelessWidget {
  final String title;
  final Function press;
  final IconData icon;
  const SubButton({
    Key key,
    this.title,
    this.press,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        //horizontal: getProportionateScreenWidth(15),
        vertical: getProportionateScreenHeight(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 1,
              color: Colors.grey.withOpacity(0.23),
            )
          ],
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(8),
          ),
        ),
        child: FlatButton(
          padding: EdgeInsets.all(15),
          onPressed: press,
          child: Row(
            children: [
              Icon(
                icon,
                color: Color(0xFF409EFF),
                size: 13,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: kTextColor),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF409EFF),
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
