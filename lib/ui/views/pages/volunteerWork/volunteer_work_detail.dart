import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youth/core/constants/values.dart';
import 'package:youth/core/models/volunteer_work.dart';
import 'package:youth/ui/styles/_colors.dart';

import '../../../../size_config.dart';

class VolunteerWorkDetail extends StatefulWidget {
  final VolunteerWork item;

  const VolunteerWorkDetail({Key key, this.item}) : super(key: key);
  @override
  _VolunteerWorkDetailState createState() => _VolunteerWorkDetailState();
}

class _VolunteerWorkDetailState extends State<VolunteerWorkDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: volunteerColor,
        title: Text(
          'Сайн дурын ажил'.toUpperCase(),
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Text(
              widget.item.name == null ? '' : widget.item.name,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            widget.item.image != null
                ? CachedNetworkImage(
                    imageUrl: baseUrl + widget.item.image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        backgroundColor: Colors.red,
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.network(
                      baseUrl + "/assets/youth/images/noImage.jpg",
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : Container(
                    height: 136,
                    child: Image.network(
                      baseUrl + "/assets/youth/images/noImage.jpg",
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
            SizedBox(
              height: 15,
            ),
            Container(
              //child: Html(data: widget.news.content),
              child: Html(
                data: widget.item.description.toString(),
                style: {
                  "p": Style(
                    color: kTextColor,
                    fontSize: FontSize(13),
                    fontWeight: FontWeight.normal,
                  ),
                },
              ),
            ),
            Container(
              height: 90,
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 30,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width - 25,
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: knowLedgeColor,
                          size: 14.0,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Нэмсэн огноо: ',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          widget.item.createdAt.toString().substring(0, 10),
                          style: TextStyle(
                            color: knowLedgeColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
