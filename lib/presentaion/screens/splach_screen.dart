import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_contacts_app/constants/screens.dart' as screens;

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {

  @override
  void initState() {
    Timer(Duration(milliseconds: 1000), () {
      Navigator.pushNamedAndRemoveUntil(context, screens.homeLayout, (route) => false);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
    );
  }
}
