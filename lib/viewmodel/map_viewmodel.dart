/// 뷰 모델은 아직 어떻게 만드는지 완벽하게 이해되지 않았는데,
///  영상 보고 다시 한번 이해해보자.
/// 뷰모델이 어떤 역할인지 무엇을 어떻게 왜 정확하게 이해하고 정리하자.
/// 크릿에 있었던 뷰모델을 보니 클래스(class FeedViewModel1 extends BaseViewModel 이렇게 적혀 있다.)
/// 클래스 내 생성자, 그리고 비디오를 움직일 함수들이 저장되어 있다.

/// 픽쳐뷰 모델의 리스트를 만든다??
class ListPictureViewModel{
  ///뷰모델 리스트 생성
  List<PictureViewModel>? pictures;

  ///데이터를 서버에서 비동기로 가져오는 부분.
  Future<void> fetchPictures() async{
    final apiResult = await Service().fetchPicturesAPI();
    this.pictures = apiResult.map((e) => PictureViewModel(e)).toList();
  }

  ///뷰모델을 만드는 것.
  class PictureViewModel {
    final PicSumModel? picSumModel;

    PictureViewModel(this.picSumModel);
  }
}


///모델에서
///
///
/// ViewModel 만드는 방법 정리
/// 크게 두가지 기능을 만든다.
/// 1. 모델에서 데이터 받고 뷰모델로 이동
/// 2. 뷰모델에 받은 내용을 뷰로 이동.
/// 일단 Model에서 데이터를 읽어와 뿌려주는 내용부터 만들어보자 => 뷰모델은 사이에 있는 친구이니 데이터창고에 데이터를 읽어와 뷰로 뿌려줘야 한다.

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