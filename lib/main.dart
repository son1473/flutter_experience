///Main에서 runApp => MyApp => home: MapSample() stateful 위젯으로 생성 =>
///컨트롤러 존재, 카메라 포지션 존재,

import 'dart:async';
import 'package:flutterpartyquest/view/home.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: GoogleMapview(),
    );
  }
}
