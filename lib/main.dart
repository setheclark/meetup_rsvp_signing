import 'package:flutter/material.dart';
import 'package:meetup_event_signin/home_screen.dart';

void main() {
  runApp(MaterialApp(
    title: "IO Extended 2018",
    theme: ThemeData(primarySwatch: Colors.blue),
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
