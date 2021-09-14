import 'package:google_maps_flutter/google_maps_flutter.dart';

///mj형이 상수들을 모아 적어놓았던 것처럼 상수들이 들어 있을 dart
///지금 보니 굉장히 잘 짜 놓았다.
///
//클래스 안에만 static 선언 가능. 정확히 이해할 필요 있음.

static final CameraPosition _kGooglePlex = CameraPosition(
  target: LatLng(37.531774, 126.841079),

  /// 우리 집 위치로 변경
  zoom: 14.4746,
);
static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,

    ///베어링은 카메라가 돌아가면서 확대되는 것을 말하나? 맞았다. 바퀴의 베어링 맞물리는 것을 잘 되게 하는 것.
    ///카메라 베어링은 카메라가 바라보는 방위를 나타낸다.
    target: LatLng(37.4537251, 126.7960716),

    ///깃허브 글쓴이의 위치 핫로드는 작동x 핫restart 시작. => 대한민국이 맞다.
// tilt: 59.440717697143555,
    zoom: 19.151926040649414);
