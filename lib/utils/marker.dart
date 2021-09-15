import 'package:google_maps_flutter/google_maps_flutter.dart';

//클래스를 선언해야 하는 이유 => 객체 지향 프로그래밍 하기 위해서.
//클래스를 선언하지 않으면 최상위 함수가 되고, 이는 파일만 분리되어 있을 뿐, 객체 지향적이 아니다.

//밖에서 하는 일 :
// 1. 첫 카메라 위치,
// 2. 맵생성 - 구글맵 컨트롤러,
// 3. 위치허가,
// 4. 마커 리스트 받기,
// 5. 현재 위치로 이동,
//안에서 하는 일: 마커 리스트 생성, 마커 추가, 마커 위치 업데이트

class MarkerFunction {
  List<Marker> _markers = [Marker(markerId: MarkerId("007"), position: LatLng(37.431532, 126.841079))];

  List<Marker> getMarkerList() {
    List<Marker> firstMark = _markers;
    print("이게 되나? $firstMark"); //되네
    return _markers;
  }

  void addMarker(List<Marker> a) {
    print("이것도 되나용?? $a");
    a.add(Marker(
        markerId: MarkerId("1"),
        draggable: true,
        onTap: () => print("Marker!"),
        position: LatLng(37.531774, 126.841079)));
    print("마커 추가 $a");
  }

  void updateMarkerPosition(CameraPosition _position) {
    Marker m = _markers.firstWhere((marker) => marker.markerId == MarkerId('1'),
        orElse: () {
          Marker emptyMarker = Marker(
            markerId: MarkerId('0'),
          );
          _markers.add(emptyMarker);
          return emptyMarker;
        }); //todo: 빈 마커 생성
    _markers.remove(m);
    _markers.add(
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(_position.target.latitude, _position.target.longitude),
        draggable: true,
      ),
    );
    // setState(() {});
    //todo: rebuild
  }
}