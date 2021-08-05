import 'package:flutter/material.dart';

List<BottomNavigationBarItem> bottomNavigationBarItems() {
  return <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
  ];
}
