import 'package:flutter/material.dart';

class TravelHistory extends StatelessWidget {
  // const TravelHistory({Key? key}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Travel History"),),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index) {
          return Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            color: Colors.blue[100],
            child: ListTile(
              title: Text('Place $index'),
              subtitle: Text('Date $index'),
              leading: Icon(Icons.map),
            ),
          );
        },
      ),
    );
  }
}
