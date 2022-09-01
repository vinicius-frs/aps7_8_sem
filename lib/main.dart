import 'package:flutter/material.dart';
import 'package:aps7_8_sem/ui/home.dart';

void main(){
  runApp(const APS());
}

class APS extends StatelessWidget {
  const APS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
