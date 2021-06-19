import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:youth/core/constants/values.dart';
import 'package:youth/core/models/knowledge.dart';
import 'package:youth/core/models/volunteer_work.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:flutter/rendering.dart';

class ddd extends StatefulWidget {
  const ddd({Key key}) : super(key: key);

  @override
  _dddState createState() => _dddState();
}

class _dddState extends State<ddd> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class KnowLedgeDetailPage extends StatefulWidget {
  final KnowLedge item;

  const KnowLedgeDetailPage({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  _KnowLedgeDetailPageState createState() => _KnowLedgeDetailPageState();
}

class _KnowLedgeDetailPageState extends State<KnowLedgeDetailPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: knowLedgeColor,
          image: DecorationImage(
            image: AssetImage("assets/images/page-heading-knowledge.jpg"),
            alignment: Alignment.topRight,
            //fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: widget.item.title.length > 70 ? 210 : 165,
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
                          widget.item.title != null
                              ? widget.item.title.toUpperCase()
                              : 'Сайн дурын ажил'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            shadows: [shadow],
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
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.grey[200],
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          widget.item.thumb != null
                              ? Container(
                                  height: 280,
                                  decoration: BoxDecoration(
                                    boxShadow: [shadow],
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                baseUrl + widget.item.thumb,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                backgroundColor: Colors.red,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.network(
                                              baseUrl +
                                                  "/assets/youth/images/noImage.jpg",
                                              width: double.infinity,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          )),
                                    ],
                                  ),
                                )
                              : Container(
                                  height: 136,
                                  child: Image.network(
                                    baseUrl +
                                        "/assets/youth/images/noImage.jpg",
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                          SizedBox(height: 10),
                          Container(
                            child: Html(
                              data: widget.item.description.toString(),
                              style: {
                                "p": Style(
                                  color: kTextColor,
                                  fontSize: FontSize(12),
                                  textAlign: TextAlign.justify,
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
                                        color: knowLedgeColor,
                                        size: 14.0,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        widget.item.createdAt
                                            .toString()
                                            .substring(0, 10),
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
