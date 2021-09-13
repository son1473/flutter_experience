///모델은 이렇게 짜는 것이고
///클래스 속성 행위 지정하고 생성자 다 구분할 줄 알아야하고
///factory가 무엇인지, fromJson하는 것 조차 모두 정확하게 이해해야 한다.


class NewsArticle {
  final String? title;
  final String? author;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  NewsArticle(
      {this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      author: json['author'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}