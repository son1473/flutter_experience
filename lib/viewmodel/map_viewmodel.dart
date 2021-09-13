// /// 뷰 모델은 아직 어떻게 만드는지 완벽하게 이해되지 않았는데,
// ///  영상 보고 다시 한번 이해해보자.
// /// 뷰모델이 어떤 역할인지 무엇을 어떻게 왜 정확하게 이해하고 정리하자.
//
// /// 픽쳐뷰 모델의 리스트를 만든다??
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