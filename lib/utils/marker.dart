import 'package:google_maps_flutter/google_maps_flutter.dart';

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