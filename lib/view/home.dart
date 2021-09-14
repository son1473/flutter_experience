// 여기가 홈이고, 여기서 화면에 출력될 내용들 적을 것이고,
// 그러므로 지도에 있는 내용들은 전부 home.dart에 들어올 것이고,
///친구들의 마커 받기.
///
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  //todo: 4. inheritance - statefulWidget은 부모로 부모의 속성과 기능을 가져와 HomseScreen으로 만든다.
  //todo: 5. 다형성 override - 부모에게 받은 특성에 자신의 특성을 추가한다.
  @override
  State<HomeScreen> createState() => HomeScreenState();

  //todo: HomeScreenState 클래스의 객체 = 상태, 즉 상태를 추가한다.
}

class HomeScreenState extends State<HomeScreen> {
  //todo: State라는 부모로부터 HomeScreenState라는 자식을 받는다.
  //todo: 그냥 함수 사용하는 것과 override하고 함수 써주는 것은 어떤 차이가 있는 걸까?
  //todo: extends 사용 시에는 항상 override하고 함수를 써야하는 것일까?
  //todo: properties 모음
  //section marker
  List<Marker> _markers = []; //todo: private property다. 다른 곳에서 이것을 접근하려면 함수로 접근해야 한다.
  //section constants
  Completer<GoogleMapController> _controller = Completer();
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

  @override
  void initState() {
    super.initState();
    _markers.add(Marker( //todo: 함수이기 때문에 추가 가능.
        markerId: MarkerId("1"),
        draggable: true, //todo: 마커 눌러서 드래그 가능여부
        onTap: () => print("Marker!"),
        position: LatLng(37.531774, 126.841079)));
  }
  //section function updatePosition
  void _updatePosition(CameraPosition _position) {
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
    setState(() {});
    //todo: rebuild
  }
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    //todo: final은 런타임시 실행된다. const는 컴파일 때 실행되고
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
  //section location 허가
  //build(context)보다 밑에 있어서 동작 됨. 위에 있으면 동작 되지 않음. 왜일까?
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
  //section 현재위치 이동버튼
  Future<void> _lookCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = new Location();
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

  @override
  Widget build(BuildContext context) {
  // section google Map body
    return new Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set.from(_markers),
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller); //todo: _controller 사용하려 함수 사용했다.
          getLocationPermission(); //권한 허용 추가 완료.
        },
        onCameraMove: ((_position) => _updatePosition(_position)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _lookCurrentLocation();
        },
        label: Text('현재 위치로!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }
}
