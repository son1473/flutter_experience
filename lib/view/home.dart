// 여기가 홈이고, 여기서 화면에 출력될 내용들 적을 것이고,
// 그러므로 지도에 있는 내용들은 전부 home.dart에 들어올 것이고,

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapview extends StatefulWidget {
  @override
  State<GoogleMapview> createState() => GoogleMapviewState();
}

class GoogleMapviewState extends State<GoogleMapview> {
  ///마커 추가
  ///왜 리스트 형식인가??
  List<Marker> _markers = [];

  ///이닛스테이트는 언제 왜 사용하는 것인가?
  ///이 물음표들을 모두 해소하고 넘어가야 한다. 결국에 다 알아야 할 내용이기 때문에.
  ///
  @override
  void initState() {
    super.initState();

    ///_markers 리스트에 추가. Marker라는 구글 맵에서 가져오는 것.
    _markers.add(Marker(
        markerId: MarkerId("1"),
        ///마커 아이디
        draggable: true,
        ///마커 드래그 가능여부
        onTap: () => print("Marker!"),
        ///마커 누르면 Marker!를 콘솔에 출력. 화면x
        position: LatLng(37.531774, 126.841079)));

    ///마커 위치 = 내위치로 변경
  }

  ///마커 이벤트 추가를 위해서 업데이트 포지션 함수 적용
  ///이 함수 또한 정확한 이해 필요.
  ///카메라가 움직일 때마다 마커가 계속 생성되는 메소드이다.
  ///카메라 포지션을 파라미터로 받아서.
  ///변수 생성 m 마커 리스트의 firstWhere는 리스트의 처음부분인가? p라는 파라미터로 p.마커IDrk 마커 아이디 '1'과 같을 경우,
  ///같지 않으면 null 값을 준다. 같으면 그래서 m은 마커 아이디 1 할당, 같지 않으면 null 할당. 없으면 상관없다는 뜻이네.
  ///그 후 마커리스트에서 m 지우기 즉 마커 아이디 1인 마커가 존재할 경우, 그 가존의 마커를 지운다고 생각.
  ///그리고 난 후, 새로운 마커 추가. 위치받고 드래거블 true, 마커아이디 1로
  ///아 기존의 마커 아이디 1을 지우고 새로운 마커 아이디 1로 만드는 구나.
  /// 이것도 setState, initState 사용하는 것으로 보아서는 디자인 패턴이 블록패턴도 아닌 형식일 수 있다.
  /// 스파게티 코드가 될 수 있으니, 이를 주의해서 설계하자. 프론트엔드는 설계하는 사람.
  /// 백엔드랑 어떻게 연결할지 설계해보자.
  void _updatePosition(CameraPosition _position) {
    var m = _markers.firstWhere((p) => p.markerId == MarkerId('1'),
        orElse: () => null!);

    /// 당연히 널 체커에 걸린다. 이 게시물은 작년 7월이기 때문에
    /// null!로 임시방편으로 널체커는 무시했는데, 무슨 값을 넣어주는 게 좋을까
    _markers.remove(m);
    _markers.add(
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(_position.target.latitude, _position.target.longitude),
        draggable: true,
      ),
    );
    setState(() {});

    ///계속 상태 변화 감지하는건가?
  }

  Completer<GoogleMapController> _controller = Completer();

  ///구글 맵 컨트롤러 Completer 생성에 관여한다고 함. 어떻게 일하는지 뜯어보고 이해할 필요가 있다.

  ///구글플렉스라는 변수는 카메라포지션이다. 여기서 위도 경도 세팅 하고, 어느 정도 확대 하는지를 적어 놓았다.
  ///googleplex 검색하니 googol plex가 나오며 googol = 10의 100승 => : the figure 10 to the power of googol equal to 10googol or 1010100.
  ///10googol을 가리키며 10의 백승을 가리키는 것이 맞다. 구글 이름의 어원이 구골이었다.
  ///구글 플렉스는 구글 본사 건물 이름이다.
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.531774, 126.841079),

    /// 우리 집 위치로 변경
    zoom: 14.4746,
  );

  ///KLake 이것은 호수를 보기 위한 카메라포지션을 적어 놓은 것. = 쇼라인이라는 호수 위치로 이동함. 베어링이란? 타겟은 위도 경도
  ///latitude의 lat은 broad를 의미 그래서 한 기준점에서 얼마나 넓은지를 가리키니 가로 선이 길게 생기고, 이는 위도이다.
  /// longitude는 long 얼마나 먼가, 즉 거리를 나타낼 때 쓰는 용어이다. 그래서 한 기준 점에서 얼마나 먼가. a에서 b사이의 거리 그러니 세로 선 => 이는 경도이다.
  /// 생각할 때 헷갈리면 lat은 아래로, long은 오른쪽으로
  /// STATIC FINAL로 하는 이유를 정확하게 알아야 한다.
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,

      ///베어링은 카메라가 돌아가면서 확대되는 것을 말하나? 맞았다. 바퀴의 베어링 맞물리는 것을 잘 되게 하는 것.
      ///카메라 베어링은 카메라가 바라보는 방위를 나타낸다.
      target: LatLng(37.4537251, 126.7960716),

      ///깃허브 글쓴이의 위치 핫로드는 작동x 핫restart 시작. => 대한민국이 맞다.
// tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    ///스캐폴드 안에 바디로 구글 맵을 넣음. 전체화면으로 만들고, 플로팅 액션버튼 추가하려고 예상됨.
    ///맵타입, 초기 카메라 위치는 kGooglePlex이다. 이것을 설정하면 내 위치를 조정할 수 있을 것으로 예상됨. 변경해보자.
    ///맵생성은 구글맵 컨트롤러에서 생성한다고 공식문서에서 보았다. 그것과 연관.
    ///플로팅액션버튼 - 익스텐디드 사용 이유는? 글자가 길어서 인가?
    ///누르면 호수 위치로 이동한다.
    ///라벨과 아이콘 존재.
// section google Map body부분
    return new Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,

        /// 내 위치가 표기 되는지 살펴 봄1 안에 뜯어봤는데, 버튼 생성 코드가 어디있는지 드러나지 않음.
        myLocationButtonEnabled: true,

        /// 내 위치가 표기 되는지 살펴봄 2 둘 다 작동을 하지 않는다. 버튼을 따로 생성해서 내 위치를 표기하게 만들어야 하는 것 같다. 정확한 이유 찾았음. => 위치 퍼미션 허용하니 버튼 생성됨 확인. 가장 큰 문제점 => 버튼 위치 변경 못함. 새로 생성해야 할 필요있음!
        markers: Set.from(_markers),

        /// 마커 추가 Set이라는 함수랑 연결 되어 있음. 정확하게 알 필요가 있다.
        mapType: MapType.normal,

        ///hybrid는 위성 => normal로 변경
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          getLocationPermission();

          ///권한 허용 추가 완료.
        },
        onCameraMove: ((_position) => _updatePosition(_position)),

        ///샘플코드에 없는 내용
        ///마커 이벤트를 주기 위해서 onCameraMove 프로퍼티 적용, 무슨 역할인지 정확하게 이해하자.
        ///이해 완료 : oncmeramove => 말 그대로 내가 화면(카메라)을 움직일 때 주는 속성 움직이는 모든 순간에 업데이트 포지션을 한다고 보면 된다.
      ),
      floatingActionButton: FloatingActionButton.extended(
// onPressed: _goToTheLake, /// 현재 위치로 가기 버튼을 만들어보자.
// onPressed: getLocationPermission, /// 현재 위치로 가기 버튼을 만들어보자.
        onPressed: () {
          _lookCurrentLocation();
        },

        /// 현재 위치로 가기 버튼을 만들어보자.
        label: Text('현재 위치로!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  ///비동기로 컨트롤러를 통해 호수로 이동하는 것 같다.
  ///비동기를 하는 이유는?
  ///비동기처리가 필요한 이유는 화면에서 서버로 데이터를 요청했을때 서버가 언제 그 요청에대한 응답을 줄지 모르는데 마냥 기다릴순 없기 때문이다.
  ///완전히 이해했다. 고 투 레이크는 언제 저 버튼을 누를 지 모르는데, 서버가 계속 기다리고 있을 수 없지 않냐
  ///비동기처리는 서버의 쉬는 시간을 만들어주기 위해 존재한다. 마냥 기다리고만 있지 않고, 서버가 다른 일에 집중할 수 있고, 요청할 때만 일을 시키기 위해
  ///필요한 것이다.
  ///그래서 컨트롤러가 서버와 대등하게 생각하면 되고 컨트롤러는 이제 요청을 받기까지 마냥 기다리고 있지 않는다. 컨트롤러는 쉬고 있는다.
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;

    ///final은 런타임시 실행된다. const는 컴파일 때 실행되고
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

//section location
  ///build(context)보다 밑에 있어서 동작 됨. 위에 있으면 동작 되지 않음.
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

//section 현재 위치로 이동 버튼 만들기
  /// 여기
  void _lookCurrentLocation() async {
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
}
