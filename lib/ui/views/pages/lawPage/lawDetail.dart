import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youth/core/constants/values.dart';
import 'package:youth/core/models/law.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LawDetailPage extends StatefulWidget {
  final Law item;

  const LawDetailPage({Key key, this.item}) : super(key: key);

  @override
  LawDetailPageState createState() => LawDetailPageState();
}

class LawDetailPageState extends State<LawDetailPage> {
  var _url;
  final _key = UniqueKey();
  bool _isLoadingPage = false;
  WebViewController webController;
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  final Set<Factory> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();

  void initState() {
    super.initState();
    _isLoadingPage = true;

    // _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: lawColor,
        title: Text(
          'Хууль'.toUpperCase(),
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: Container(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView(
          children: [
            Text(
              widget.item.title == null ? '' : widget.item.title,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            widget.item.thumb != null
                ? /*CachedNetworkImage(
                    imageUrl: baseUrl + widget.item.thumb,
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
                  )*/
                Image.network(
                    baseUrl + widget.item.thumb,
                    fit: BoxFit.fitWidth,
                  )
                : Container(
                    height: 136,
                    child: Image.network(
                      baseUrl + "/assets/youth/images/noImage.jpg",
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
            Container(
              child: widget.item.body != null
                  ? Html(data: widget.item.body)
                  : Text(''),
            ),
            Container(
              height: 90,
              margin: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 1))),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      width: MediaQuery.of(context).size.width - 25,
                      child: Row(
                        children: [
                          Icon(Icons.access_time,
                              color: knowLedgeColor, size: 14.0),
                          SizedBox(width: 5),
                          Text(
                            'Нэмсэн огноо: ',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          Text(
                            widget.item.createdAt == null
                                ? ''
                                : DateFormat("y-MM-dd")
                                    .format(
                                      DateTime.parse(widget.item.createdAt),
                                    )
                                    .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      )),
    );

    return Scaffold(
        body: Stack(
      children: <Widget>[
        WebView(
          key: _key,
          initialUrl: widget.item.link,
          javascriptMode: JavascriptMode.unrestricted,
          gestureRecognizers: gestureRecognizers,
          onWebViewCreated: (webViewCreate) {
            webController = webViewCreate;
//                    webController.evaluateJavascript('document.cookie = "token=$token}"; path=/');
            _controller.complete(webViewCreate);
          },
          onPageFinished: (finish) {
            setState(() {
              _isLoadingPage = false;
            });
          },
        ),
        _isLoadingPage
            ? Container(
                color: Colors.white,
                alignment: FractionalOffset.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    )
                  ],
                ),
              )
            : Text('')
      ],
    ));
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Color.fromRGBO(51, 142, 108, 0.9);
    var path = Path();
    path.lineTo(0, size.height - size.height / 12);
    // path.lineTo(size.width / 1.2, size.height);
    path.lineTo(size.width, size.height - size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
