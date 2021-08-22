import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myselamat/widgets/checkin.dart';

class TravelHistoryItem extends StatelessWidget {
  final location;
  final date;
  final time;
  final DateFormat dateFormatter = DateFormat('MMM d, yyyy');

  TravelHistoryItem({
    @required this.location,
    @required this.date,
    @required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(220, 76, 123, 237),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        //tileColor: Colors.white,
        title: Text(
          'Check in at $location',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          dateFormatter.format(DateTime.parse(this.date)).toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        leading: Icon(
          Icons.location_on_outlined,
          color: Colors.white,
          size: 40,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CheckIn(
                      date: this.date,
                      time: this.time,
                      location: this.location)));
        },
      ),
    );
    
  }
}
