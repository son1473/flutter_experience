import 'package:flutter/material.dart';
import 'package:flutterpartyquest/utils/map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationFunctions {
  Future<void> getLocationPermission() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    ///현재 위치 받는지 테스트 해보기
    print("$_locationData 여기 입니다~!!!! 현재 위치 받기 성공");
  }

  Future<void> lookCurrentLocation() async {
    final GoogleMapController controller = await MapController().useController().future;
    LocationData currentLocation;
    Location location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null!;
    }

    ///현재 위치로 이동 하는 메소드
    ///다른데 보고 있다가 이거 누르면 현재 위치로 이동해야 함.
    ///퍼미션 성공했기 때문에 여기서 다시 getLocation 하여도 문제 없을 것으로 예상 됨.
    ///퍼미션이 성공한 후로 가정하기 때문에 위도 경도는 무조건 출력될 것이고
    ///그렇기에 nullchecker에게 null이 아니라는 사실로 "!"를 입력함.

    ///카메라 포지션을 현재 위치로 옮겨줄 코드
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        zoom: 16.0,
      ),
    ));
  }
}