import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myselamat/admin/update_news.dart';
import 'package:myselamat/authentication/wrapper.dart';
import 'package:myselamat/pages/profile.dart';
import 'package:myselamat/pages/home.dart';
import 'package:myselamat/pages/qrScan.dart';
import 'package:myselamat/pages/travelhistory.dart';
import 'package:myselamat/widgets/bottom_nav_bar_items.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MySelamat',
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 76, 123, 237),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          primarySwatch: Theme.of(context).primaryColor,
          fontFamily: 'MazzardH-SemiBold'),
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
      routes: {
        "/travelhistory": (context) => TravelHistory(),
        UpdateNews.routeName:(context)=> UpdateNews(),
      },
    );
  }
}

class AppHome extends StatefulWidget {
  AppHome({
    Key key,
  }) : super(key: key);

  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  static var pages = <Widget>[];

  void initState() {
    super.initState();

    // Hide Android Status Bar and Navigation Bar
    // SystemChrome.setEnabledSystemUIOverlays([]);

    pages = [HomePage(), ProfilePage()];
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: pages[_selectedPageIndex],
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: BottomNavigationBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              items: bottomNavigationBarItems(),
              currentIndex: _selectedPageIndex,
              onTap: _selectPage),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          child: Icon(
            Icons.qr_code_scanner,
            size: 28.0,
          ),
          backgroundColor: Color(0xff4f8eff),
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => ScanPage()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
