import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController {
  Completer<GoogleMapController> _controller = Completer();

  Completer<GoogleMapController> useController() {
    return _controller;
  }
}