import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutterpartyquest/models/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

/// 뷰 모델은 아직 어떻게 만드는지 완벽하게 이해되지 않았는데,
///  영상 보고 다시 한번 이해해보자.
/// 뷰모델이 어떤 역할인지 무엇을 어떻게 왜 정확하게 이해하고 정리하자.
/// 크릿에 있었던 뷰모델을 보니 클래스(class FeedViewModel1 extends BaseViewModel 이렇게 적혀 있다.)
/// 클래스 내 생성자, 그리고 비디오를 움직일 함수들이 저장되어 있다.

/// 픽쳐뷰 모델의 리스트를 만든다??
// class ListPictureViewModel{
//   ///뷰모델 리스트 생성
//   List<PictureViewModel>? pictures;
//
//   ///데이터를 서버에서 비동기로 가져오는 부분.
//   Future<void> fetchPictures() async{
//     final apiResult = await Service().fetchPicturesAPI();
//     this.pictures = apiResult.map((e) => PictureViewModel(e)).toList();
//   }
//
//   ///뷰모델을 만드는 것.
//   class PictureViewModel {
//     final PicSumModel? picSumModel;
//
//     PictureViewModel(this.picSumModel);
//   }
// }


///모델에서
///
///
/// ViewModel 만드는 방법 정리
/// 크게 두가지 기능을 만든다.
/// 1. 모델에서 데이터 받고 뷰모델로 이동
/// 2. 뷰모델에 받은 내용을 뷰로 이동.
/// 일단 Model에서 데이터를 읽어와 뿌려주는 내용부터 만들어보자 => 뷰모델은 사이에 있는 친구이니 데이터창고에 데이터를 읽어와 뷰로 뿌려줘야 한다.

class UserPartyQuestViewModel {
  UserPartyQuest _userPartyQuest;

  UserPartyQuestViewModel({required UserPartyQuest userPartyQuest}) : _userPartyQuest = userPartyQuest;

  String? get userID {
    return _userPartyQuest.userID;
  }

  String? get password {
    return _userPartyQuest.password;
  }

  List<String>? get permittedUser {
    return _userPartyQuest.permittedUser;
  }

  String? get userLatitude {
    return _userPartyQuest.userLatitude;
  }

  String? get userLongitude {
    return _userPartyQuest.userLongitude;
  }
}

// enum LoadingStatus { completed, searching, empty }

//뷰로 notify 해줄 내용들 정리.
class UserViewModel extends ChangeNotifier {
  // LoadingStatus loadingStatus = LoadingStatus.empty;

  //section marker
  List<Marker> _markers = [];
  ///이건 클래스의 property private화 한 것.
  ///왜? 이 마커는 다른 파일에서 건들지 않을거니까. => 칸막이 기능.
  ///이 마커를 다른 파일에서도 건드리는 게 아닌 이 파일에서 건드리는 경우에도 함수를 사용해서 불러줘야 하나?
  ///답 yes
  void addMarker() {
    _markers.add(Marker(
        markerId: MarkerId("1"),
        ///마커 아이디
        draggable: true,
        ///마커 드래그 가능여부
        onTap: () => print("Marker!"),
        ///마커 누르면 Marker!를 콘솔에 출력. 화면x
        position: LatLng(37.531774, 126.841079)));
  }

  UserViewModel(
      );


  // Future<void> _onMapCreated(GoogleMapController controller) async {
  //   _controller.
  //
  // }



  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,

      ///베어링은 카메라가 돌아가면서 확대되는 것을 말하나? 맞았다. 바퀴의 베어링 맞물리는 것을 잘 되게 하는 것.
      ///카메라 베어링은 카메라가 바라보는 방위를 나타낸다.
      target: LatLng(37.4537251, 126.7960716),

      ///깃허브 글쓴이의 위치 핫로드는 작동x 핫restart 시작. => 대한민국이 맞다.
// tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }


  //section function updatePosition
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

  //section location
  ///build(context)보다 밑에 있어서 동작 됨. 위에 있으면 동작 되지 않음.
  //위치 허가 요청
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
  void _lookCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null!;
    }

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













class NewsArticleViewModel {
  ///뉴스 아티클은 뉴스아티클모델이다.
  ///인스턴스 생성했다고 보면 된다.
  NewsArticle _newsArticle;
  ///모델 클래스의 인스턴스를 생성했다고 생각하면 된다.
  NewsArticleViewModel({NewsArticle newsArticle}) : _newsArticle = newsArticle;

  ///모델에서 모델의 정보를 받아온다. 그래서 get.
  String get title {
    return _newsArticle.title;
  }

  String get author {
    return _newsArticle.author;
  }

  String get url {
    return _newsArticle.url;
  }

  String get urlToImage {
    return _newsArticle.urlToImage;
  }

  String get content {
    return _newsArticle.content;
  }

  String get description {
    return _newsArticle.description;
  }

  String get publishedAt {
    return _newsArticle.publishedAt;
  }
}

///다음은 List로 가져온 뉴스를 보여줄 ViewModel이다.
/// import 'package:flutter/material.dart';

///오류 방지를 위한 명확한 상수들을 정리
enum LoadingStatus { completed, searching, empty }

class NewsArticleListViewModel extends ChangeNotifier {
  //초기에 로딩 데이터 없음
  LoadingStatus loadingStatus = LoadingStatus.empty;

  //기사 가져오기
  void topHeadLines() {
    //...

    //LoadingStatus를 로딩중으로 변경

    //데이터 가져오면 업데이트
    notifyListeners();
    ///changeNotifier와 같은 부분은 getX 사용하면 된다.
  }
}
///이제 기본적인 Model에서 데이터를 가져와 ViewModel로 연결하는 건 끝이 났다