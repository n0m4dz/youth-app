import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youth/ui/views/pages/subCouncil/introduction.dart';

import '../../../size_config.dart';

class SubCouncil extends StatefulWidget {
  final int id;
  final String title;

  const SubCouncil({Key key, this.title, this.id}) : super(key: key);
  @override
  _SubCouncilState createState() => _SubCouncilState();
}

class _SubCouncilState extends State<SubCouncil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF409EFF),
      //   bottomOpacity: 0.0,
      //   elevation: 0.0,
      // ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF409EFF),
          // image: DecorationImage(
          //   image: AssetImage("assets/images/ux_big.png"),
          //   alignment: Alignment.topRight,
          // ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 5, top: 40, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SubButton(
                            title: "Танилцуулга",
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Introduction(title: 'Танилцуулга'),
                                ),
                              );
                            },
                          ),
                          SubButton(title: "Гишүүд", press: () {}),
                          SubButton(title: "Мэдээ", press: () {}),
                          SubButton(title: "Тогтоол", press: () {}),
                          SubButton(title: "Тайлан", press: () {}),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubButton extends StatelessWidget {
  final String title;
  final Function press;
  const SubButton({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(15),
        vertical: getProportionateScreenHeight(10),
      ),
      child: FlatButton(
        padding: EdgeInsets.all(15),
        onPressed: press,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(8),
          ),
          side: BorderSide(
            color: Color(0xFF409EFF),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(title),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF409EFF),
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
