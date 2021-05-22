import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youth/ui/views/pages/national_council.dart';

import '../../size_config.dart';

class DefaultSliverAppBar extends StatelessWidget {
  const DefaultSliverAppBar({
    Key key,
    @required this.size,
    this.color,
    this.svgData,
    this.title,
  }) : super(key: key);

  final String title;
  final Size size;
  final Color color;
  final String svgData;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: getProportionateScreenHeight(200),
      floating: false,
      pinned: true,
      backgroundColor: color,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 1,
              child: Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        background: Stack(
          children: [
            Positioned(
              right: getProportionateScreenWidth(-50),
              bottom: 0,
              child: SvgPicture.asset(
                svgData,
                width: size.width,
                height: size.height * getProportionateScreenWidth(.13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
