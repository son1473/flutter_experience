///모델짜는 방법 정리
///모델은 이렇게 짜는 것이고 => 완료
///클래스 속성 행위 지정하고 생성자 다 구분할 줄 알아야하고 =>완료
///factory가 무엇인지, fromJson하는 것 조차 모두 정확하게 이해해야 한다. => 완료

class UserPartyQuest {
  final String? userID;
  final String? password;
  final List<String>? permittedUser; //이 사람이 허용된 사용자를 리스트 형식으로 받아오겠다.
  final String? userLatitude; // 경도
  final String? userLongitude; // 위도

  UserPartyQuest(
      {this.userID,
      this.password,
      this.permittedUser,
      this.userLatitude,
      this.userLongitude});

  factory UserPartyQuest.fromJson(Map<String, dynamic> json) {
    return UserPartyQuest(
      userID: json["userID"],
      password: json["password"],
      permittedUser: json["permittedUser"],
      userLatitude: json["userLatitude"],
      userLongitude: json["userLongitude"],
    );
  }
}



// class NewsArticle {
//   ///뉴스아티클이라는 틀을 만든다.
//   ///여기 있는 것들은 속성들을 의미한다.
//   final String? title;
//   final String? author;
//   final String? description;
//   final String? url;
//   final String? urlToImage;
//   final String? publishedAt;
//   final String? content;
//
//   ///생성자. 인스턴스화 하는 방법을 제공한다.
//   ///set 형식으로 순서 상관없는 집합.
//   NewsArticle(
//       {this.author,
//       this.title,
//       this.description,
//       this.url,
//       this.urlToImage,
//       this.publishedAt,
//       this.content});
//
//   ///map 구조에서 새로운 뉴스아티클 객체를 생성하기 위한 생성자인 User.fromJson() 생성자
//   ///factory는 새로운 인스턴스를 생성하고 싶지 않을 때 사용하는 생성자이다
//   ///위와 같은 생성자인데 인스턴스를 만들지 않는 생성자
//   factory NewsArticle.fromJson(Map<String, dynamic> json) {
//     return NewsArticle(
//       title: json['title'],
//       author: json['author'],
//       description: json['description'],
//       url: json['url'],
//       urlToImage: json['urlToImage'],
//       publishedAt: json['publishedAt'],
//       content: json['content'],
//     );
//   }
// }
