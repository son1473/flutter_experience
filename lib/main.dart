///Main에서 runApp => MyApp => home: MapSample() stateful 위젯으로 생성 =>
///컨트롤러 존재, 카메라 포지션 존재,

import 'package:flutter/material.dart';
import 'package:flutterpartyquest/view/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("myApp의 buildContext-위치정보 : ${context.hashCode}"); //3
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: HomeScreen(),
    );
  }
}
