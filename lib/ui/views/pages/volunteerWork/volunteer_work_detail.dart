import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:youth/core/constants/values.dart';
import 'package:youth/core/models/volunteer_work.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:flutter/rendering.dart';

class VolunteerWorkDetail extends StatefulWidget {
  final VolunteerWork item;

  const VolunteerWorkDetail({Key key, this.item}) : super(key: key);
  @override
  _VolunteerWorkDetailState createState() => _VolunteerWorkDetailState();
}

class _VolunteerWorkDetailState extends State<VolunteerWorkDetail> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: volunteerColor,
          image: DecorationImage(
            image: AssetImage("assets/images/page-heading-legal.jpg"),
            alignment: Alignment.topRight,
            //fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 180,
              padding: EdgeInsets.only(top: 60, right: 20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.item.name != null
                              ? widget.item.name.toUpperCase()
                              : 'Сайн дурын ажил'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height: size.height,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(10),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      widget.item.image != null
                          ? CachedNetworkImage(
                              imageUrl: baseUrl + widget.item.image,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                              errorWidget: (context, url, error) =>
                                  Image.network(
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
                      SizedBox(height: 10),
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
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: volunteerColor,
                                    size: 14.0,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.item.createdAt
                                        .toString()
                                        .substring(0, 10),
                                    style: TextStyle(
                                      color: volunteerColor,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
