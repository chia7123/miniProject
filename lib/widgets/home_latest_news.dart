import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LatestNews extends StatelessWidget {
  // ignore: non_constant_identifier_names
  Widget NewsItem(
      {@required double height,
      @required DateTime timestamp,
      @required Text textWidget,
      @required Image image}) {
    return Container(
      width: 360.0,
      height: height,
      decoration: BoxDecoration(
          color: Color(0xfff7f7f7),
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                spreadRadius: 0.2,
                blurRadius: 5.0,
                color: Colors.black.withOpacity(0.2))
          ]),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset(
                    "assets/images/profile.jpg",
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "CPRC KKM\n",
                    style: TextStyle(
                        fontFamily: "MazzardH-SemiBold",
                        fontSize: 14.0,
                        color: Colors.black)),
                TextSpan(
                    text: DateFormat('dd MMMM yyyy hh:mm aaa')
                        .format(timestamp)
                        .toString(),
                    style: TextStyle(
                        fontFamily: "MazzardH-Medium",
                        fontSize: 11.0,
                        height: 1.3,
                        color: Colors.black))
              ])),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: textWidget,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Align(alignment: Alignment.bottomCenter, child: image),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(left: 25.0),
            child: Text(
              "Latest News",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "MazzardH-SemiBold",
                  fontSize: 18.0),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          height: 550,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('news')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      final news = snapshot.data.docs[index];
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: NewsItem(
                            height: 440.0,
                            timestamp: news['time'].toDate(),
                            textWidget: Text(
                              news['caption'],
                              style: TextStyle(
                                  fontFamily: "MazzardH-SemiBold",
                                  fontSize: 14.0,
                                  color: Colors.black),
                            ),
                            image: Image.network(news['imageUrl'],
                                width: double.infinity)),
                      );
                    });
              }),
        ),
      ],
    );
  }
}
