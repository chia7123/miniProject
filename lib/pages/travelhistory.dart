import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myselamat/widgets/travel_history_item.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TravelHistory extends StatefulWidget {
  // const TravelHistory({Key? key}) : super(key: key);
  @override
  _TravelHistoryState createState() => _TravelHistoryState();
}

class _TravelHistoryState extends State<TravelHistory> {
  DateTime _start_date;
  DateTime _end_date;
  final DateRangePickerController _date_controller =
      DateRangePickerController();
  // String _range = '';
  // String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _start_date = args.value.startDate.subtract(new Duration(days: 1));
        _end_date = args.value.endDate ?? args.value.startDate;
        _end_date = _end_date.add(new Duration(days: 1));
      }

      // print("TEST: start_date: " + _start_date.toString());
      // print("TEST: end_date: " + _end_date.toString());
    });
  }

  _showDateRangePicker() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            //color: Colors.amber,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Date Range Picker'),
                  SfDateRangePicker(
                    controller: _date_controller,
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        child: TextButton(
                          child: const Text('Clear'),
                          onPressed: () {
                            _start_date = null;
                            _end_date = null;
                            _date_controller.selectedRange = null;
                          },
                        ),
                        flex: 4,
                      ),
                      Expanded(
                        child: Container(),
                        flex: 2,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          child: const Text('Done'),
                          //style: ,
                          onPressed: () => Navigator.pop(context),
                        ),
                        flex: 4,
                      ),
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection('travel history')
            .orderBy("id", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final appBar = AppBar(
            title: Text("Travel History"),
          );

          // Display travel history if exists
          if (snapshot.hasData) {
            var data = snapshot.data.docs.toList();

            return Scaffold(
                appBar: AppBar(
                  title: Text("Travel History"),
                ),
                body: Column(
                  children: <Widget>[
                    Container(
                      child: ElevatedButton(
                          onPressed: _showDateRangePicker,
                          child: Text("Date Range Picker")),
                    ),
                    Expanded(
                      child: ListView.builder(
                        //padding: EdgeInsets.only(top: 50),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (_start_date == null) {
                            return TravelHistoryItem(
                                location: data[index]['place'],
                                date: data[index]['date'],
                                time: data[index]['time']);
                          }

                          if (_start_date.isBefore(
                                  DateTime.parse(data[index]['date'])) &&
                              _end_date.isAfter(
                                  DateTime.parse(data[index]['date']))) {
                            return TravelHistoryItem(
                                location: data[index]['place'],
                                date: data[index]['date'],
                                time: data[index]['time']);
                          }

                          return SizedBox(height: 0);
                        },
                      ),
                    ),
                  ],
                ));
          }

          // display no history if no travel history
          return Scaffold(
              appBar: appBar,
              body: Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 8,
                  vertical: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.05,
                ),
                child: Text(
                  'No Travel History...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
              ));
        });
  }
}
